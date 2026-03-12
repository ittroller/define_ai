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

# --- 0. Kiểm tra và Sao lưu cấu hình AI hiện tại (Safety first!) ---
echo "🛡️ Đang kiểm tra và sao lưu các cấu hình AI hiện có..."
BACKUP_ROOT=".ai_backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="$BACKUP_ROOT/backup_$TIMESTAMP"

TARGETS=(
    ".agent" ".cursor/rules" ".windsurfrules" ".clinerules" 
    ".pearai/rules" ".traerules" ".github/copilot-instructions.md" 
    ".claude-instructions.md" ".claude/" ".idea/ai-instructions.md" 
    ".idea/ai-agents/" ".zed/instructions.md" ".aider.instructions.md" 
    ".continue/rules" "./INITIAL_SESSION.md" ".ai_skills/" 
    ".ai_hooks/" ".ai_docs/" ".xcoderules"
)

FOUND_OLD=false
for target in "${TARGETS[@]}"; do
    if [ -e "$target" ]; then
        if [ "$FOUND_OLD" = false ]; then
            mkdir -p "$BACKUP_PATH"
            FOUND_OLD=true
        fi
        echo "   📦 Sao lưu: $target"
        # Tạo thư mục tương ứng trong backup để giữ cấu trúc
        DIR_NAME=$(dirname "$target")
        if [ "$DIR_NAME" != "." ] && [ "$DIR_NAME" != "./" ]; then
            mkdir -p "$BACKUP_PATH/$DIR_NAME"
        fi
        cp -R "$target" "$BACKUP_PATH/$target" 2>/dev/null
    fi
done

if [ "$FOUND_OLD" = true ]; then
    echo "✅ Đã sao lưu các cấu hình cũ vào thư mục: $BACKUP_PATH"
    echo "⚠️ Lưu ý: Quá trình đồng bộ sẽ ghi đè các file này để khớp với bộ khung .ai mới nhất."
else
    echo "✨ Không tìm thấy cấu hình AI cũ cần sao lưu."
fi

echo "🔄 Bắt đầu quá trình đồng bộ AI Agents..."

# --- 1. Antigravity (.agent) ---
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
[ -f ".ai/README.md" ] && cp .ai/README.md "$SKILL_PATH/"

# --- 2. Cursor (.cursor/rules) ---
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

# --- 3. Windsurf (.windsurfrules) ---
echo "📂 Đồng bộ cho Windsurf (.windsurfrules)..."
true > .windsurfrules
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .windsurfrules
echo -e "\n\n# Project Skills\n" >> .windsurfrules
[ -d ".ai/skills" ] && cat .ai/skills/*.md >> .windsurfrules
echo -e "\n\n# Project Specifications\n" >> .windsurfrules
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .windsurfrules
echo -e "\n\n# Project Knowledge\n" >> .windsurfrules
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .windsurfrules
echo -e "\n\n# Project Memory\n" >> .windsurfrules
[ -d ".ai/memory" ] && cat .ai/memory/*.md >> .windsurfrules
echo -e "\n\n# Project Documentation\n" >> .windsurfrules
[ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .windsurfrules 2>/dev/null
echo -e "\n\n# Project Hooks (Guardrails)\n" >> .windsurfrules
[ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .windsurfrules

# --- 4. Roo Code / Cline (.clinerules) ---
echo "📂 Đồng bộ cho Roo Code / Cline (.clinerules)..."
true > .clinerules
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .clinerules
echo -e "\n\n# Project Skills\n" >> .clinerules
[ -d ".ai/skills" ] && cat .ai/skills/*.md >> .clinerules
echo -e "\n\n# Project Specifications\n" >> .clinerules
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .clinerules
echo -e "\n\n# Project Knowledge\n" >> .clinerules
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .clinerules
echo -e "\n\n# Project Memory\n" >> .clinerules
[ -d ".ai/memory" ] && cat .ai/memory/*.md >> .clinerules
echo -e "\n\n# Project Documentation\n" >> .clinerules
[ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .clinerules 2>/dev/null
echo -e "\n\n# Project Hooks (Guardrails)\n" >> .clinerules
[ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .clinerules

# --- 5. PearAI (.pearai/rules) ---
echo "📂 Đồng bộ cho PearAI (.pearai/rules)..."
mkdir -p .pearai/rules/agents .pearai/rules/specifications .pearai/rules/knowledge .pearai/rules/skills .pearai/rules/docs
[ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .pearai/rules/agents/
[ -d ".ai/specifications" ] && rsync -av --delete .ai/specifications/ .pearai/rules/specifications/
[ -d ".ai/knowledge" ] && rsync -av --delete .ai/knowledge/ .pearai/rules/knowledge/
[ -d ".ai/skills" ] && rsync -av --delete .ai/skills/ .pearai/rules/skills/
[ -d ".ai/docs" ] && rsync -av --delete .ai/docs/ .pearai/rules/docs/

# --- 6. Trae (.traerules) ---
echo "📂 Đồng bộ cho Trae (.traerules)..."
true > .traerules
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .traerules
echo -e "\n\n# Project Specifications\n" >> .traerules
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .traerules
echo -e "\n\n# Project Knowledge\n" >> .traerules
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .traerules
echo -e "\n\n# Project Memory\n" >> .traerules
[ -d ".ai/memory" ] && cat .ai/memory/*.md >> .traerules
echo -e "\n\n# Project Skills\n" >> .traerules
[ -d ".ai/skills" ] && cat .ai/skills/*.md >> .traerules
echo -e "\n\n# Project Documentation\n" >> .traerules
[ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .traerules 2>/dev/null
echo -e "\n\n# Project Hooks (Guardrails)\n" >> .traerules
[ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .traerules

# --- 7. VS Code / Copilot (.github/copilot-instructions.md) ---
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

# --- 8. Claude IDE / Desktop & Claude Code CLI (.claude/) ---
echo "📂 Đồng bộ cho Claude IDE / Desktop & Claude Code CLI..."
true > .claude-instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .claude-instructions.md
echo -e "\n\n# Project Skills\n" >> .claude-instructions.md
[ -d ".ai/skills" ] && cat .ai/skills/*.md >> .claude-instructions.md
echo -e "\n\n# Project Specifications\n" >> .claude-instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .claude-instructions.md
echo -e "\n\n# Project Documentation\n" >> .claude-instructions.md
[ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .claude-instructions.md 2>/dev/null

# Hỗ trợ Claude Code (CLI) với cấu trúc thư mục
mkdir -p .claude/skills .claude/hooks .claude/docs
[ -d ".ai/skills" ] && rsync -av --delete .ai/skills/ .claude/skills/
[ -d ".ai/hooks" ] && rsync -av --delete .ai/hooks/ .claude/hooks/
[ -d ".ai/docs" ] && rsync -av --delete .ai/docs/ .claude/docs/
[ -f ".claude-instructions.md" ] && cp .claude-instructions.md .claude/CLAUDE.md

# --- 9. JetBrains IDEs (WebStorm, PyCharm, IntelliJ...) ---
echo "📂 Đồng bộ cho JetBrains IDEs (.idea/ai-instructions.md)..."
mkdir -p .idea/ai-agents
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

# --- 10. Zed (.zed/instructions.md) ---
echo "📂 Đồng bộ cho Zed (.zed/instructions.md)..."
mkdir -p .zed
true > .zed/instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .zed/instructions.md
echo -e "\n\n# Project Specifications\n" >> .zed/instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .zed/instructions.md
echo -e "\n\n# Project Knowledge\n" >> .zed/instructions.md
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .zed/instructions.md
echo -e "\n\n# Project Memory\n" >> .zed/instructions.md
[ -d ".ai/memory" ] && cat .ai/memory/*.md >> .zed/instructions.md
echo -e "\n\n# Project Skills\n" >> .zed/instructions.md
[ -d ".ai/skills" ] && cat .ai/skills/*.md >> .zed/instructions.md
echo -e "\n\n# Project Documentation\n" >> .zed/instructions.md
[ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .zed/instructions.md 2>/dev/null
echo -e "\n\n# Project Hooks (Guardrails)\n" >> .zed/instructions.md
[ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .zed/instructions.md

# --- 11. Aider (.aider.instructions.md) ---
echo "📂 Đồng bộ cho Aider (.aider.instructions.md)..."
true > .aider.instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .aider.instructions.md
echo -e "\n\n# Project Specifications\n" >> .aider.instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .aider.instructions.md
echo -e "\n\n# Project Knowledge\n" >> .aider.instructions.md
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .aider.instructions.md
echo -e "\n\n# Project Memory\n" >> .aider.instructions.md
[ -d ".ai/memory" ] && cat .ai/memory/*.md >> .aider.instructions.md
echo -e "\n\n# Project Skills\n" >> .aider.instructions.md
[ -d ".ai/skills" ] && cat .ai/skills/*.md >> .aider.instructions.md
echo -e "\n\n# Project Documentation\n" >> .aider.instructions.md
[ -d ".ai/docs" ] && grep -r "" .ai/docs | grep ".md" | xargs cat >> .aider.instructions.md 2>/dev/null
echo -e "\n\n# Project Hooks (Guardrails)\n" >> .aider.instructions.md
[ -d ".ai/hooks" ] && cat .ai/hooks/*.md 2>/dev/null >> .aider.instructions.md

# --- 12. Continue (.continue/rules) ---
echo "📂 Đồng bộ cho Continue (.continue/rules/)..."
mkdir -p .continue/rules/agents .continue/rules/specifications .continue/rules/knowledge .continue/rules/skills .continue/rules/docs
[ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .continue/rules/agents/
[ -d ".ai/specifications" ] && rsync -av --delete .ai/specifications/ .continue/rules/specifications/
[ -d ".ai/knowledge" ] && rsync -av --delete .ai/knowledge/ .continue/rules/knowledge/
[ -d ".ai/skills" ] && rsync -av --delete .ai/skills/ .continue/rules/skills/
[ -d ".ai/docs" ] && rsync -av --delete .ai/docs/ .continue/rules/docs/

# --- 13. Xcode (.xcoderules) ---
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

# Di chuyển INITIAL_SESSION.md ra ngoài root để dễ truy cập
if [ -f ".ai/INITIAL_SESSION.md" ]; then
    echo "📄 Di chuyển INITIAL_SESSION.md ra thư mục gốc..."
    cp .ai/INITIAL_SESSION.md ./
fi

echo "✅ Đồng bộ thành công cho các IDE!"
echo "------------------------------------------------"
echo "📍 Antigravity: .agent/"
echo "📍 Cursor:      .cursor/rules/"
echo "📍 Windsurf:    .windsurfrules"
echo "📍 Roo Code:    .clinerules"
echo "📍 PearAI:      .pearai/rules/"
echo "📍 Trae:        .traerules"
echo "📍 VS Code:     .github/copilot-instructions.md"
echo "📍 Claude IDE:  .claude-instructions.md & .claude/"
echo "📍 JetBrains:   .idea/ai-instructions.md & .idea/ai-agents/"
echo "📍 Zed:         .zed/instructions.md"
echo "📍 Aider (CLI): .aider.instructions.md"
echo "📍 Continue:    .continue/rules/"
echo "📍 Xcode:       .xcoderules"
echo "📍 Khởi tạo:    ./INITIAL_SESSION.md"
echo "------------------------------------------------"

# Xóa thư mục .ai sau khi hoàn tất
echo "⚠️ Đang xóa thư mục gốc .ai..."
rm -rf .ai

echo "🚀 Hoàn tất! Bạn có thể bắt đầu sử dụng AI Agent trong IDE của mình."
