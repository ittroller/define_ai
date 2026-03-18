#!/bin/bash

# Configuration
SOURCE_DIR=".ai"
BACKUP_DIR=".ai_backups/backup_$(date +%Y%m%d_%H%M%S)"

# List of supported IDEs and their target directories
get_target_dir() {
    case $1 in
        "cursor") echo ".cursor/rules" ;;
        "vscode") echo ".vscode/ai-agents" ;;
        "jetbrains"|"pycharm"|"intellij"|"webstorm"|"phpstorm"|"rider"|"clion"|"datagrip"|"rubymine"|"goland"|"androidstudio") echo ".idea/ai-agents" ;;
        "claude") echo ".claude" ;;
        "antigravity") echo ".agent" ;;
        "xcode") echo ".xcode/rules" ;;
        "codex") echo ".codex" ;;
        "continue") echo ".continue/rules" ;;
        "zed") echo ".zed/rules" ;;
        "pearai") echo ".pearai/rules" ;;
        "cline") echo ".cline/rules" ;;
        "trae") echo ".trae/rules" ;;
        "windsurf") echo ".windsurf/rules" ;;
        "aider") echo ".aider/rules" ;;
        *) echo "" ;;
    esac
}

# Function to detect the IDE
detect_ide() {
    # 1. Ưu tiên nhận diện qua biến môi trường (Nếu đang chạy trong terminal của IDE)
    if [ "$TERM_PROGRAM" == "vscode" ]; then
        echo "vscode"
        return
    elif [ "$TERM_PROGRAM" == "cursor" ]; then
        echo "cursor"
        return
    fi

    # 2. Nhận diện qua các file đặc trưng (Markers) - Ưu tiên các Agent/IDE chuyên dụng trước
    if [ -d ".cursor" ] || [ -f ".cursorrules" ]; then
        echo "cursor"
    elif [ -e ".agent" ]; then
        echo "antigravity"
    elif [ -d ".cline" ] || [ -f ".clinerules" ]; then
        echo "cline"
    elif [ -d ".trae" ] || [ -f ".traerules" ]; then
        echo "trae"
    elif [ -d ".windsurf" ] || [ -f ".windsurfrules" ]; then
        echo "windsurf"
    elif [ -d ".claude" ] || [ -f ".claude-instructions.md" ]; then
        echo "claude"
    elif [ -d ".continue" ]; then
        echo "continue"
    elif [ -d ".codex" ]; then
        echo "codex"
    elif [ -d ".zed" ]; then
        echo "zed"
    elif [ -d ".pearai" ]; then
        echo "pearai"
    elif [ -d ".aider" ] || [ -f ".aider.instructions.md" ]; then
        echo "aider"
    elif [ -d ".vscode" ]; then
        echo "vscode"
    elif [ -d ".idea" ]; then
        echo "jetbrains"
    else
        echo "unknown"
    fi
}

# Function to backup existing AI configurations
backup_ai_configs() {
    local ide=$1
    local target=$(get_target_dir "$ide")
    
    # Chỉ sao lưu nếu có thư mục mục tiêu hoặc có INITIAL_SESSION.md cũ ở root
    if ([ -e "$target" ] || [ -f "INITIAL_SESSION.md" ]); then
        # Chỉ tạo BACKUP_DIR khi thực sự có gì đó để sao lưu
        mkdir -p "$BACKUP_DIR"
        
        if [ -f "$target" ]; then
            cp "$target" "$BACKUP_DIR/"
            echo "   📦 Sao lưu: $target"
        elif [ -d "$target" ]; then
            cp -r "$target" "$BACKUP_DIR/"
            echo "   📦 Sao lưu: $target"
        fi
        
        if [ -f "INITIAL_SESSION.md" ]; then
            cp "INITIAL_SESSION.md" "$BACKUP_DIR/"
            echo "   📦 Sao lưu: ./INITIAL_SESSION.md"
        fi
    fi
}

# Function to sync for JetBrains (Folder-based)
sync_jetbrains() {
    echo "📂 Đồng bộ cho JetBrains IDEs (.idea/)..."
    mkdir -p ".idea/ai-agents"
    rsync -av --delete "$SOURCE_DIR/agents/" ".idea/ai-agents/rules/"
    rsync -av --delete "$SOURCE_DIR/specifications/" ".idea/ai-agents/specifications/"
    rsync -av --delete "$SOURCE_DIR/knowledge/" ".idea/ai-agents/knowledge/"
    rsync -av --delete "$SOURCE_DIR/memory/" ".idea/ai-agents/memory/"
    rsync -av --delete "$SOURCE_DIR/skills/" ".idea/ai-agents/skills/"
    rsync -av --delete "$SOURCE_DIR/docs/" ".idea/ai-agents/docs/"
    rsync -av --delete "$SOURCE_DIR/hooks/" ".idea/ai-agents/hooks/"
    rsync -av --delete "$SOURCE_DIR/superpowers/" ".idea/ai-agents/superpowers/"
    rsync -av --delete "$SOURCE_DIR/mcp/" ".idea/ai-agents/mcp/"
    
    # Combined instructions for JetBrains
    cat "$SOURCE_DIR/INITIAL_SESSION.md" > ".idea/ai-instructions.md"
    # Thêm CLAUDE.md vào .idea để tăng khả năng nhận diện của AI Assistant
    cat "$SOURCE_DIR/INITIAL_SESSION.md" > ".idea/CLAUDE.md"
}

# Function to sync for folder-based IDEs
sync_folder_based() {
    local ide=$1
    local target=$(get_target_dir "$ide")
    echo "📂 Đồng bộ cho $ide ($target/)..."
    
    # Kiểm tra nếu target đang là tệp tin thì chuyển thành thư mục
    if [ -f "$target" ]; then
        echo "   ⚠️ Phát hiện $target là tệp tin, đang chuyển đổi thành thư mục..."
        mv "$target" "${target}.bak"
    fi
    
    mkdir -p "$target"
    rsync -av --delete "$SOURCE_DIR/agents/" "$target/"
    # Optional: copy other things if needed
    cp "$SOURCE_DIR/INITIAL_SESSION.md" "$target/INITIAL_SESSION.md"
}

# Function to generate a combined instruction file
sync_combined_file() {
    local target=$1
    local dir=$(dirname "$target")
    echo "📝 Tạo file nén tổng hợp: $target"
    mkdir -p "$dir"
    cat "$SOURCE_DIR/INITIAL_SESSION.md" > "$target"
    echo -e "\n\n# --- AGENT RULES ---\n" >> "$target"
    cat "$SOURCE_DIR/agents/"*.md >> "$target"
    echo -e "\n\n# --- SKILLS ---\n" >> "$target"
    cat "$SOURCE_DIR/skills/"*.md >> "$target"
}

# Main process
# Ưu tiên nhận IDE từ tham số truyền vào
REQUESTED_IDE=$1
FORCE_BACKUP=false

# Kiểm tra các tham số
for arg in "$@"; do
    if [ "$arg" == "--backup" ] || [ "$arg" == "-b" ]; then
        FORCE_BACKUP=true
    fi
done

if [ -n "$REQUESTED_IDE" ] && [[ "$REQUESTED_IDE" != -* ]]; then
    IDE="$REQUESTED_IDE"
    echo "📍 Sử dụng IDE được chỉ định: $IDE"
else
    IDE=$(detect_ide)
fi

if [ "$IDE" == "unknown" ]; then
    echo "❌ Không tìm thấy IDE được hỗ trợ (Cursor, VS Code, JetBrains, Antigravity, etc.)"
    echo "👉 Bạn có thể chỉ định IDE: npx minhck-dot-ai sync [tên-ide]"
    echo "👉 Ví dụ: npx minhck-dot-ai sync cursor, npx minhck-dot-ai sync antigravity"
    exit 1
fi

echo "🔍 Tự động nhận diện IDE: $IDE"
echo "🔄 Bắt đầu quá trình đồng bộ AI Agents cho: $IDE..."

# Chỉ sao lưu khi có yêu cầu explicit bằng flag --backup
if [ "$FORCE_BACKUP" = true ]; then
    echo "🛡️ Đang sao lưu các cấu hình AI hiện có cho IDE: $IDE..."
    backup_ai_configs "$IDE"
    if [ -d "$BACKUP_DIR" ]; then
        echo "✅ Đã sao lưu các cấu hình cũ vào thư mục: $BACKUP_DIR"
    fi
fi

case $IDE in
    "jetbrains"|"pycharm"|"intellij"|"webstorm"|"phpstorm"|"rider"|"clion"|"datagrip"|"rubymine"|"goland"|"androidstudio")
        sync_jetbrains
        ;;
    "vscode")
        sync_folder_based "vscode"
        sync_combined_file ".github/copilot-instructions.md"
        ;;
    "cline")
        sync_folder_based "cline"
        sync_combined_file ".clinerules"
        ;;
    "trae")
        sync_folder_based "trae"
        sync_combined_file ".traerules"
        ;;
    "windsurf")
        sync_folder_based "windsurf"
        sync_combined_file ".windsurfrules"
        ;;
    "aider")
        sync_folder_based "aider"
        sync_combined_file ".aider.instructions.md"
        ;;
    "xcode")
        sync_folder_based "xcode"
        sync_combined_file ".xcoderules"
        ;;
    "cursor"|"antigravity"|"codex"|"claude"|"continue"|"zed"|"pearai")
        sync_folder_based "$IDE"
        ;;
    *)
        echo "❌ IDE '$IDE' không được hỗ trợ chính thức."
        exit 1
        ;;
esac

# Chỉ update INITIAL_SESSION.md ở root khi đồng bộ thành công
cp "$SOURCE_DIR/INITIAL_SESSION.md" "./INITIAL_SESSION.md"

echo "✅ Đồng bộ thành công cho: $IDE!"
echo "------------------------------------------------"
echo "📍 Cấu hình IDE: $IDE"
echo "📍 Khởi tạo:    ./INITIAL_SESSION.md"
echo "------------------------------------------------"
echo "🚀 Hoàn tất! (Lưu ý: Thư mục $SOURCE_DIR đã được giữ lại)"
