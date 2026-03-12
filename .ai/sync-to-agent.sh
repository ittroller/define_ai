#!/bin/bash

# =================================================================
# Script: Sync AI Agents to IDE-specific configurations
# Mục đích: Đồng bộ cấu hình từ .ai sang các folder chuẩn của từng IDE
# =================================================================

# Kiểm tra sự tồn tại của thư mục .ai
if [ ! -d ".ai" ]; then
    echo "❌ Không tìm thấy thư mục .ai. Có thể quá trình đồng bộ đã thực hiện rồi."
    exit 1
fi

# Nhận tham số & Tự động nhận diện IDE
TARGET_IDE=""
FORCE_DELETE=""
FORCE_CLEAN_BACKUP=""

# 1. Nhận diện qua tham số dòng lệnh
for arg in "$@"; do
    case $arg in
        --delete|-d) FORCE_DELETE="--delete" ;;
        --clean|-c) FORCE_CLEAN_BACKUP="--clean" ;;
        jetbrains|cursor|vscode|claude|xcode|antigravity|all) TARGET_IDE="$arg" ;;
        *) [[ ! $arg == -* ]] && [ -z "$TARGET_IDE" ] && TARGET_IDE="$arg" ;;
    esac
done

# 2. Tự động phát hiện IDE nếu không chỉ định qua tham số
if [ -z "$TARGET_IDE" ]; then
    DETECTED_IDES=()
    
    # --- PHƯƠNG PHÁP 1: Nhận diện qua Cây tiến trình (Process Tree Tracing) ---
    # Truy vết ngược lên tối đa 10 cấp để tìm xem terminal này có được chạy bởi IDE không
    CUR_PID=$PPID
    for ((i=0; i<10; i++)); do
        [ -z "$CUR_PID" ] || [ "$CUR_PID" -le 1 ] && break
        # Lấy tên tiến trình và cả tham số (để bắt được CLI binary path)
        PROC_FULL=$(ps -p $CUR_PID -o command= 2>/dev/null | tr '[:upper:]' '[:lower:]')
        PROC_NAME=$(basename "$PROC_FULL" 2>/dev/null | awk '{print $1}')
        
        if [[ -n "$PROC_NAME" ]]; then
            if [[ "$PROC_NAME" == *"webstorm"* ]] || [[ "$PROC_NAME" == *"intellij"* ]] || [[ "$PROC_NAME" == *"phpstorm"* ]] || [[ "$PROC_NAME" == *"pycharm"* ]] || [[ "$PROC_NAME" == *"idea"* ]] || [[ "$PROC_NAME" == *"goland"* ]] || [[ "$PROC_NAME" == *"datagrip"* ]] || [[ "$PROC_NAME" == *"clion"* ]] || [[ "$PROC_NAME" == *"rustrover"* ]] || [[ "$PROC_FULL" == *"jetbrains"* ]]; then
                TARGET_IDE="jetbrains"
                echo "🔍 Tự động nhận diện IDE (Process Trace): JetBrains ($PROC_NAME)"
                break
            elif [[ "$PROC_NAME" == *"cursor"* ]] || [[ "$PROC_FULL" == *"cursor"* ]]; then
                TARGET_IDE="cursor"
                echo "🔍 Tự động nhận diện IDE (Process Trace): Cursor"
                break
            elif [[ "$PROC_NAME" == *"code"* ]] || [[ "$PROC_NAME" == *"visual studio code"* ]] || [[ "$PROC_FULL" == *"visual studio code"* ]]; then
                TARGET_IDE="vscode"
                echo "🔍 Tự động nhận diện IDE (Process Trace): VS Code"
                break
            elif [[ "$PROC_NAME" == *"xcode"* ]]; then
                TARGET_IDE="xcode"
                echo "🔍 Tự động nhận diện IDE (Process Trace): Xcode"
                break
            elif [[ "$PROC_NAME" == *"antigravity"* ]]; then
                TARGET_IDE="antigravity"
                echo "🔍 Tự động nhận diện IDE (Process Trace): Antigravity"
                break
            elif [[ "$PROC_NAME" == *"claude"* ]]; then
                TARGET_IDE="claude"
                echo "🔍 Tự động nhận diện IDE (Process Trace): Claude"
                break
            fi
        fi
        CUR_PID=$(ps -p $CUR_PID -o ppid= 2>/dev/null | awk '{print $1}')
    done

    # --- PHƯƠNG PHÁP 2: Nhận diện qua Biến môi trường (Environment Variables & IPC) ---
    if [ -z "$TARGET_IDE" ]; then
        # JetBrains
        if [ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ] || [[ -n "$__CFBundleIdentifier" ]] && [[ "$__CFBundleIdentifier" == com.jetbrains.* ]] || [ -n "$IDEA_INITIAL_DIRECTORY" ] || [ -n "$IDE_PROJECT_DIR" ]; then
            TARGET_IDE="jetbrains"
            echo "🔍 Tự động nhận diện IDE (Environment): JetBrains"
        # VS Code / Cursor
        elif [ "$TERM_PROGRAM" == "vscode" ] || [ -n "$VSCODE_IPC_HOOK_CLI" ] || [ -n "$VSCODE_GIT_IPC_HANDLE" ] || [ -n "$VSCODE_GIT_ASKPASS_NODE" ]; then
            if [[ -n "$CURSOR_PROJECT_PATH" ]] || [[ -d ".cursor" ]] || [[ "$TERMINAL_EMULATOR" == "cursor" ]]; then
                TARGET_IDE="cursor"
                echo "🔍 Tự động nhận diện IDE (Environment): Cursor"
            else
                TARGET_IDE="vscode"
                echo "🔍 Tự động nhận diện IDE (Environment): VS Code"
            fi
        # Claude
        elif [ "$TERM_PROGRAM" == "claude" ] || [ -n "$CLAUDE_CODE" ]; then
            TARGET_IDE="claude"
            echo "🔍 Tự động nhận diện IDE (Environment): Claude"
        # Antigravity
        elif [[ "$TERM_PROGRAM" == *"antigravity"* ]] || [[ -n "$ANTIGRAVITY_PROJECT_PATH" ]]; then
            TARGET_IDE="antigravity"
            echo "🔍 Tự động nhận diện IDE (Environment): Antigravity"
        # Devcontainer fallback
        elif [ -n "$REMOTE_CONTAINERS" ] || [ -n "$DEVCONTAINER" ]; then
             if [ -d ".vscode" ]; then TARGET_IDE="vscode"; else TARGET_IDE="jetbrains"; fi
             echo "🔍 Tự động nhận diện IDE (Devcontainer): $TARGET_IDE"
        fi
    fi

    # --- PHƯƠNG PHÁP 3: Nhận diện qua Thư mục/File cấu hình hiện có (Filesystem) ---
    if [ -z "$TARGET_IDE" ]; then
        [ -d ".idea" ] && DETECTED_IDES+=("jetbrains")
        [ -d ".cursor" ] && DETECTED_IDES+=("cursor")
        [ -d ".vscode" ] && DETECTED_IDES+=("vscode")
        [ -d ".claude" ] && DETECTED_IDES+=("claude")
        [ -d ".agent" ] && DETECTED_IDES+=("antigravity")
        [ -f ".xcoderules" ] && DETECTED_IDES+=("xcode")

        if [ ${#DETECTED_IDES[@]} -eq 1 ]; then
            TARGET_IDE="${DETECTED_IDES[0]}"
            echo "🔍 Tự động nhận diện IDE (Filesystem): $TARGET_IDE"
        elif [ ${#DETECTED_IDES[@]} -gt 1 ]; then
            # Ưu tiên nhận diện theo thứ tự nếu có nhiều dấu hiệu
            if [ -d ".idea" ]; then
                TARGET_IDE="jetbrains"
            elif [ -d ".cursor" ]; then
                TARGET_IDE="cursor"
            elif [ -d ".vscode" ]; then
                TARGET_IDE="vscode"
            else
                TARGET_IDE="multi"
            fi
            echo "🔍 Phát hiện nhiều dấu hiệu IDE (${DETECTED_IDES[*]}). Ưu tiên chọn: $TARGET_IDE"
        fi
    fi

    # --- PHƯƠNG PHÁP 4: Phân tích PATH & Dependency Fingerprinting ---
    if [ -z "$TARGET_IDE" ]; then
        if [[ "$PATH" == *"WebStorm"* ]] || [[ "$PATH" == *"IntelliJ"* ]] || [[ "$PATH" == *"PyCharm"* ]]; then
            TARGET_IDE="jetbrains"
            echo "🔍 Tự động nhận diện IDE (Path Analysis): JetBrains"
        elif [[ "$PATH" == *"Cursor"* ]]; then
            TARGET_IDE="cursor"
            echo "🔍 Tự động nhận diện IDE (Path Analysis): Cursor"
        elif [[ "$PATH" == *"VS Code"* ]] || [[ "$PATH" == *"vscode"* ]]; then
            TARGET_IDE="vscode"
            echo "🔍 Tự động nhận diện IDE (Path Analysis): VS Code"
        elif [ -f "package.json" ]; then
            if grep -q "jetbrains" package.json 2>/dev/null; then
                TARGET_IDE="jetbrains"
                echo "🔍 Tự động nhận diện IDE (Fingerprinting): JetBrains"
            elif grep -q "vscode" package.json 2>/dev/null; then
                TARGET_IDE="vscode"
                echo "🔍 Tự động nhận diện IDE (Fingerprinting): VS Code"
            fi
        fi
    fi

    # --- PHƯƠNG PHÁP 5: Window Title (macOS only) ---
    if [ -z "$TARGET_IDE" ] && [[ "$OSTYPE" == "darwin"* ]]; then
        FRONT_APP=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null | tr '[:upper:]' '[:lower:]')
        if [[ "$FRONT_APP" == *"webstorm"* ]] || [[ "$FRONT_APP" == *"idea"* ]] || [[ "$FRONT_APP" == *"pycharm"* ]]; then
            TARGET_IDE="jetbrains"
            echo "🔍 Tự động nhận diện IDE (Window Title): JetBrains"
        elif [[ "$FRONT_APP" == *"cursor"* ]]; then
            TARGET_IDE="cursor"
            echo "🔍 Tự động nhận diện IDE (Window Title): Cursor"
        elif [[ "$FRONT_APP" == *"code"* ]]; then
            TARGET_IDE="vscode"
            echo "🔍 Tự động nhận diện IDE (Window Title): VS Code"
        fi
    fi

    # 3. Thông báo nếu vẫn không tìm thấy
    if [ -z "$TARGET_IDE" ]; then
        echo "⚠️ Không tự động nhận diện được IDE của bạn (không có thư mục cấu hình hoặc biến môi trường đặc trưng)."
        echo "💡 Cách giải quyết:"
        echo "   1. Chạy trong terminal của IDE (ví dụ terminal trong WebStorm, Cursor...)"
        echo "   2. Hoặc chỉ định IDE cụ thể: npx minhck-dot-ai sync [jetbrains|cursor|vscode|claude|xcode|antigravity]"
        echo "   3. Hoặc dùng 'all' để tạo cho tất cả: npx minhck-dot-ai sync all"
        exit 0
    fi
fi

# --- 0. Kiểm tra và Sao lưu cấu hình AI hiện tại (Safety first!) ---
echo "🛡️ Đang kiểm tra và sao lưu các cấu hình AI hiện có cho IDE: $TARGET_IDE..."
BACKUP_ROOT=".ai_backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="$BACKUP_ROOT/backup_$TIMESTAMP"

ALL_TARGETS=(
    ".agent" ".cursor/rules" ".github/copilot-instructions.md" 
    ".claude-instructions.md" ".claude/" ".idea/ai-instructions.md" 
    ".idea/ai-agents/" ".idea/CLAUDE.md"
    "./INITIAL_SESSION.md" ".xcoderules"
)

# Lọc targets dựa trên IDE được chọn để sao lưu chính xác
if [ "$TARGET_IDE" == "jetbrains" ]; then
    IDE_TARGETS=(".idea/ai-instructions.md" ".idea/ai-agents/" ".idea/CLAUDE.md" "./INITIAL_SESSION.md")
elif [ "$TARGET_IDE" == "cursor" ]; then
    IDE_TARGETS=(".cursor/rules" "./INITIAL_SESSION.md")
elif [ "$TARGET_IDE" == "vscode" ]; then
    IDE_TARGETS=(".github/copilot-instructions.md" "./INITIAL_SESSION.md")
elif [ "$TARGET_IDE" == "claude" ]; then
    IDE_TARGETS=(".claude-instructions.md" ".claude/" "./INITIAL_SESSION.md")
elif [ "$TARGET_IDE" == "xcode" ]; then
    IDE_TARGETS=(".xcoderules" "./INITIAL_SESSION.md")
elif [ "$TARGET_IDE" == "antigravity" ]; then
    IDE_TARGETS=(".agent" "./INITIAL_SESSION.md")
elif [ "$TARGET_IDE" == "multi" ]; then
    # Lấy các targets tương ứng với những IDE đã được nhận diện
    IDE_TARGETS=("./INITIAL_SESSION.md")
    for ide in "${DETECTED_IDES[@]}"; do
        case $ide in
            "jetbrains") IDE_TARGETS+=(".idea/ai-instructions.md" ".idea/ai-agents/" ".idea/CLAUDE.md") ;;
            "cursor") IDE_TARGETS+=(".cursor/rules") ;;
            "vscode") IDE_TARGETS+=(".github/copilot-instructions.md") ;;
            "claude") IDE_TARGETS+=(".claude-instructions.md" ".claude/") ;;
            "xcode") IDE_TARGETS+=(".xcoderules") ;;
            "antigravity") IDE_TARGETS+=(".agent") ;;
        esac
    done
elif [ "$TARGET_IDE" == "all" ]; then
    IDE_TARGETS=("${ALL_TARGETS[@]}")
else
    # Nếu chỉ định qua tham số mà không khớp list trên
    IDE_TARGETS=("./INITIAL_SESSION.md")
    # Cố gắng tìm target khớp với tên IDE
    case $TARGET_IDE in
        "jetbrains") IDE_TARGETS+=(".idea/ai-instructions.md" ".idea/ai-agents/" ".idea/CLAUDE.md") ;;
        "cursor") IDE_TARGETS+=(".cursor/rules") ;;
        "vscode") IDE_TARGETS+=(".github/copilot-instructions.md") ;;
        "claude") IDE_TARGETS+=(".claude-instructions.md" ".claude/") ;;
        "xcode") IDE_TARGETS+=(".xcoderules") ;;
        "antigravity") IDE_TARGETS+=(".agent") ;;
    esac
fi

FOUND_OLD=false
for target in "${IDE_TARGETS[@]}"; do
    if [ -e "$target" ]; then
        if [ "$FOUND_OLD" = false ]; then
            mkdir -p "$BACKUP_PATH"
            FOUND_OLD=true
        fi
        echo "   📦 Sao lưu: $target"
        DIR_NAME=$(dirname "$target")
        if [ "$DIR_NAME" != "." ] && [ "$DIR_NAME" != "./" ]; then
            mkdir -p "$BACKUP_PATH/$DIR_NAME"
        fi
        cp -R "$target" "$BACKUP_PATH/$target" 2>/dev/null
    fi
done

if [ "$FOUND_OLD" = true ]; then
    echo "✅ Đã sao lưu các cấu hình cũ vào thư mục: $BACKUP_PATH"
else
    echo "✨ Không tìm thấy cấu hình AI cũ cần sao lưu."
fi

# Các hàm đồng bộ cho từng IDE

cleanup_others() {
    local EXCLUDE_IDE=$1
    echo "🧹 Đang dọn dẹp các cấu hình AI của các IDE khác để giữ dự án sạch sẽ..."
    
    # Danh sách tất cả các mục cấu hình AI có thể có
    # (Trừ IDE đang được đồng bộ)
    [ "$EXCLUDE_IDE" != "antigravity" ] && rm -rf .agent
    [ "$EXCLUDE_IDE" != "cursor" ] && rm -rf .cursor
    [ "$EXCLUDE_IDE" != "vscode" ] && rm -rf .github/copilot-instructions.md
    [ "$EXCLUDE_IDE" != "claude" ] && { rm -rf .claude-instructions.md .claude; }
    [ "$EXCLUDE_IDE" != "jetbrains" ] && { rm -rf .idea/ai-instructions.md .idea/ai-agents .idea/CLAUDE.md; }
    [ "$EXCLUDE_IDE" != "xcode" ] && rm -rf .xcoderules
    
    # Xóa các file rác của các IDE đã bị loại bỏ hoàn toàn
    rm -rf .continue .pearai .zed .aider.instructions.md .clinerules .traerules .windsurfrules
}

echo "🔄 Bắt đầu quá trình đồng bộ AI Agents cho: $TARGET_IDE..."

# Dọn dẹp rác của các IDE khác (nếu không phải mode 'all')
cleanup_others "$TARGET_IDE"

sync_antigravity() {
    echo "📂 Đồng bộ cho Antigravity (.agent)..."
    mkdir -p .agent/rules .agent/workflows .agent/skills .agent/hooks .agent/docs
    [ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .agent/rules/
    [ -d ".ai/workflows" ] && rsync -av --delete .ai/workflows/ .agent/workflows/
    [ -d ".ai/skills" ] && rsync -av --delete .ai/skills/ .agent/skills/
    [ -d ".ai/hooks" ] && rsync -av --delete .ai/hooks/ .agent/hooks/
    [ -d ".ai/docs" ] && rsync -av --delete .ai/docs/ .agent/docs/
    
    SKILL_PATH=".agent/skills/skills/project-context"
    mkdir -p "$SKILL_PATH"
    cat <<EOF > "$SKILL_PATH/README.md"
# Project Context Skill
Kỹ năng này cung cấp toàn bộ bối cảnh dự án, quy chuẩn coding, tri thức nghiệp vụ và các câu lệnh mẫu.

## Nội dung:
- Specifications: Quy chuẩn coding.
- Knowledge: Tech stack và Project Map.
- Memory: Các quyết định kiến trúc (ADR).
- Prompts: Thư viện câu lệnh mẫu.
EOF
    [ -d ".ai/specifications" ] && rsync -av --delete .ai/specifications/ "$SKILL_PATH/specifications/"
    [ -d ".ai/knowledge" ] && rsync -av --delete .ai/knowledge/ "$SKILL_PATH/knowledge/"
    [ -d ".ai/memory" ] && rsync -av --delete .ai/memory/ "$SKILL_PATH/memory/"
    [ -d ".ai/prompts" ] && rsync -av --delete .ai/prompts/ "$SKILL_PATH/prompts/"
    [ -d ".ai/mcp" ] && rsync -av --delete .ai/mcp/ "$SKILL_PATH/mcp/"
    [ -f ".ai/INITIAL_SESSION.md" ] && cp .ai/INITIAL_SESSION.md "$SKILL_PATH/"
}

sync_cursor() {
    echo "📂 Đồng bộ cho Cursor (.cursor/rules)..."
    mkdir -p .cursor/rules/agents .cursor/rules/specifications .cursor/rules/knowledge .cursor/rules/memory .cursor/rules/prompts .cursor/rules/skills .cursor/rules/docs .cursor/hooks
    [ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .cursor/rules/agents/
    [ -d ".ai/specifications" ] && rsync -av --delete .ai/specifications/ .cursor/rules/specifications/
    [ -d ".ai/knowledge" ] && rsync -av --delete .ai/knowledge/ .cursor/rules/knowledge/
    [ -d ".ai/memory" ] && rsync -av --delete .ai/memory/ .cursor/rules/memory/
    [ -d ".ai/prompts" ] && rsync -av --delete .ai/prompts/ .cursor/rules/prompts/
    [ -d ".ai/skills" ] && rsync -av --delete .ai/skills/ .cursor/rules/skills/
    [ -d ".ai/docs" ] && rsync -av --delete .ai/docs/ .cursor/rules/docs/
    [ -d ".ai/hooks" ] && rsync -av --delete .ai/hooks/ .cursor/hooks/
}

sync_vscode() {
    echo "📂 Đồng bộ cho VS Code / Copilot (.github/copilot-instructions.md)..."
    mkdir -p .github
    true > .github/copilot-instructions.md
    [ -d ".ai/agents" ] && cat .ai/agents/*.md >> .github/copilot-instructions.md
    echo -e "\n\n# Project Specifications\n" >> .github/copilot-instructions.md
    [ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .github/copilot-instructions.md
    echo -e "\n\n# Project Knowledge\n" >> .github/copilot-instructions.md
    [ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .github/copilot-instructions.md
    echo -e "\n\n# Project Memory\n" >> .github/copilot-instructions.md
    [ -d ".ai/memory" ] && cat .ai/memory/*.md >> .github/copilot-instructions.md
    echo -e "\n\n# Project Skills\n" >> .github/copilot-instructions.md
    [ -d ".ai/skills" ] && cat .ai/skills/*.md >> .github/copilot-instructions.md
    echo -e "\n\n# Project Documentation\n" >> .github/copilot-instructions.md
    [ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .github/copilot-instructions.md 2>/dev/null
    echo -e "\n\n# Project Hooks (Guardrails)\n" >> .github/copilot-instructions.md
    [ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .github/copilot-instructions.md
}

sync_claude() {
    echo "📂 Đồng bộ cho Claude IDE / Desktop & Claude Code CLI..."
    true > .claude-instructions.md
    [ -d ".ai/agents" ] && cat .ai/agents/*.md >> .claude-instructions.md
    echo -e "\n\n# Project Skills\n" >> .claude-instructions.md
    [ -d ".ai/skills" ] && cat .ai/skills/*.md >> .claude-instructions.md
    echo -e "\n\n# Project Specifications\n" >> .claude-instructions.md
    [ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .claude-instructions.md
    echo -e "\n\n# Project Documentation\n" >> .claude-instructions.md
    [ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .claude-instructions.md 2>/dev/null
    
    mkdir -p .claude/skills .claude/hooks .claude/docs
    [ -d ".ai/skills" ] && rsync -av --delete .ai/skills/ .claude/skills/
    [ -d ".ai/hooks" ] && rsync -av --delete .ai/hooks/ .claude/hooks/
    [ -d ".ai/docs" ] && rsync -av --delete .ai/docs/ .claude/docs/
    [ -f ".claude-instructions.md" ] && cp .claude-instructions.md .claude/CLAUDE.md
}

sync_jetbrains() {
    echo "📂 Đồng bộ cho JetBrains IDEs (.idea/ai-instructions.md)..."
    # Đảm bảo thư mục .idea tồn tại
    if [ ! -d ".idea" ]; then
        echo "📝 Đang khởi tạo cấu trúc thư mục .idea cho JetBrains..."
        mkdir -p .idea
    fi
    mkdir -p .idea/ai-agents/rules
    mkdir -p .idea/ai-agents/specifications
    mkdir -p .idea/ai-agents/knowledge
    mkdir -p .idea/ai-agents/memory
    mkdir -p .idea/ai-agents/skills
    mkdir -p .idea/ai-agents/docs
    mkdir -p .idea/ai-agents/hooks

    true > .idea/ai-instructions.md

    # 9.1 Đồng bộ file instructions tổng hợp
    [ -d ".ai/agents" ] && cat .ai/agents/*.md >> .idea/ai-instructions.md
    echo -e "\n\n# Project Skills\n" >> .idea/ai-instructions.md
    [ -d ".ai/skills" ] && cat .ai/skills/*.md >> .idea/ai-instructions.md
    echo -e "\n\n# Project Specifications\n" >> .idea/ai-instructions.md
    [ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .idea/ai-instructions.md
    echo -e "\n\n# Project Knowledge\n" >> .idea/ai-instructions.md
    [ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .idea/ai-instructions.md
    echo -e "\n\n# Project Memory\n" >> .idea/ai-instructions.md
    [ -d ".ai/memory" ] && cat .ai/memory/*.md >> .idea/ai-instructions.md
    echo -e "\n\n# Project Documentation\n" >> .idea/ai-instructions.md
    [ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .idea/ai-instructions.md 2>/dev/null
    echo -e "\n\n# Project Hooks (Guardrails)\n" >> .idea/ai-instructions.md
    [ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .idea/ai-instructions.md

    # 9.2 Đồng bộ cấu trúc thư mục (Cho các plugin hỗ trợ folder-based rules)
    [ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .idea/ai-agents/rules/
    [ -d ".ai/specifications" ] && rsync -av --delete .ai/specifications/ .idea/ai-agents/specifications/
    [ -d ".ai/knowledge" ] && rsync -av --delete .ai/knowledge/ .idea/ai-agents/knowledge/
    [ -d ".ai/memory" ] && rsync -av --delete .ai/memory/ .idea/ai-agents/memory/
    [ -d ".ai/skills" ] && rsync -av --delete .ai/skills/ .idea/ai-agents/skills/
    [ -d ".ai/docs" ] && rsync -av --delete .ai/docs/ .idea/ai-agents/docs/
    [ -d ".ai/hooks" ] && rsync -av --delete .ai/hooks/ .idea/ai-agents/hooks/
    
    # Một số plugin JetBrains dùng file CLAUDE.md hoặc .clinerules ngay trong .idea
    cp .idea/ai-instructions.md .idea/CLAUDE.md
}

sync_xcode() {
    echo "📂 Đồng bộ cho Xcode (.xcoderules)..."
    true > .xcoderules
    [ -d ".ai/agents" ] && cat .ai/agents/*.md >> .xcoderules
    echo -e "\n\n# Project Specifications\n" >> .xcoderules
    [ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .xcoderules
    echo -e "\n\n# Project Knowledge\n" >> .xcoderules
    [ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .xcoderules
    echo -e "\n\n# Project Memory\n" >> .xcoderules
    [ -d ".ai/memory" ] && cat .ai/memory/*.md >> .xcoderules
    echo -e "\n\n# Project Skills\n" >> .xcoderules
    [ -d ".ai/skills" ] && cat .ai/skills/*.md >> .xcoderules
    echo -e "\n\n# Project Documentation\n" >> .xcoderules
    [ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .xcoderules 2>/dev/null
    echo -e "\n\n# Project Hooks (Guardrails)\n" >> .xcoderules
    [ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .xcoderules
}

# Thực hiện đồng bộ dựa trên TARGET_IDE
case $TARGET_IDE in
    "jetbrains")
        sync_jetbrains
        ;;
    "cursor")
        sync_cursor
        ;;
    "vscode")
        sync_vscode
        ;;
    "claude")
        sync_claude
        ;;
    "xcode")
        sync_xcode
        ;;
    "antigravity")
        sync_antigravity
        ;;
    "multi")
        for ide in "${DETECTED_IDES[@]}"; do
            case $ide in
                "jetbrains") sync_jetbrains ;;
                "cursor") sync_cursor ;;
                "vscode") sync_vscode ;;
                "claude") sync_claude ;;
                "xcode") sync_xcode ;;
                "antigravity") sync_antigravity ;;
            esac
        done
        ;;
    "all")
        sync_antigravity
        sync_cursor
        sync_vscode
        sync_claude
        sync_jetbrains
        sync_xcode
        ;;
    *)
        echo "⚠️ Không nhận dạng được IDE: $TARGET_IDE."
        echo "💡 Vui lòng chỉ định một trong: jetbrains, cursor, vscode, claude, xcode, antigravity, all"
        exit 1
        ;;
esac

# Di chuyển hoặc cập nhật INITIAL_SESSION.md ra ngoài root để dễ truy cập
if [ -f ".ai/INITIAL_SESSION.md" ]; then
    echo "📄 Cập nhật INITIAL_SESSION.md tại thư mục gốc..."
    cp .ai/INITIAL_SESSION.md ./
fi

echo "✅ Đồng bộ thành công cho: $TARGET_IDE!"
echo "------------------------------------------------"
    if [ "$TARGET_IDE" == "multi" ]; then
        for ide in "${DETECTED_IDES[@]}"; do
            case $ide in
                "jetbrains") echo "📍 JetBrains:   .idea/ai-instructions.md & .idea/ai-agents/" ;;
                "cursor") echo "📍 Cursor:      .cursor/rules/" ;;
                "vscode") echo "📍 VS Code:     .github/copilot-instructions.md" ;;
                "claude") echo "📍 Claude IDE:  .claude-instructions.md & .claude/" ;;
                "antigravity") echo "📍 Antigravity: .agent/" ;;
                "xcode") echo "📍 Xcode:       .xcoderules" ;;
            esac
        done
    else
        if [ "$TARGET_IDE" == "all" ] || [ "$TARGET_IDE" == "antigravity" ]; then echo "📍 Antigravity: .agent/"; fi
        if [ "$TARGET_IDE" == "all" ] || [ "$TARGET_IDE" == "cursor" ]; then echo "📍 Cursor:      .cursor/rules/"; fi
        if [ "$TARGET_IDE" == "all" ] || [ "$TARGET_IDE" == "vscode" ]; then echo "📍 VS Code:     .github/copilot-instructions.md"; fi
        if [ "$TARGET_IDE" == "all" ] || [ "$TARGET_IDE" == "claude" ]; then echo "📍 Claude IDE:  .claude-instructions.md & .claude/"; fi
        if [ "$TARGET_IDE" == "all" ] || [ "$TARGET_IDE" == "jetbrains" ]; then echo "📍 JetBrains:   .idea/ai-instructions.md & .idea/ai-agents/"; fi
        if [ "$TARGET_IDE" == "all" ] || [ "$TARGET_IDE" == "xcode" ]; then echo "📍 Xcode:       .xcoderules"; fi
    fi
echo "📍 Khởi tạo:    ./INITIAL_SESSION.md"
echo "------------------------------------------------"

# Xóa thư mục .ai sau khi hoàn tất (chỉ khi có tham số --delete)
if [ "$FORCE_DELETE" == "--delete" ]; then
    echo "⚠️ Đang xóa thư mục gốc .ai theo yêu cầu..."
    rm -rf .ai
fi

# Xóa .ai_backups nếu có tham số --clean
if [ "$FORCE_CLEAN_BACKUP" == "--clean" ]; then
    echo "🧹 Đang dọn dẹp thư mục sao lưu .ai_backups..."
    rm -rf .ai_backups
fi

if [ "$FORCE_DELETE" == "--delete" ] || [ "$FORCE_CLEAN_BACKUP" == "--clean" ]; then
    echo "🚀 Hoàn tất và đã dọn dẹp!"
else
    echo "💡 Thư mục gốc .ai vẫn được giữ lại để bạn có thể đồng bộ cho IDE khác nếu cần."
    echo "🚀 Hoàn tất! Bạn có thể bắt đầu sử dụng AI Agent trong IDE của mình."
fi
