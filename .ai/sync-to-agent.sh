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

echo "🔄 Bắt đầu quá trình đồng bộ AI Agents..."

# --- 1. Antigravity (.agent) ---
echo "📂 Đồng bộ cho Antigravity (.agent)..."
mkdir -p .agent/rules .agent/workflows
[ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .agent/rules/
[ -d ".ai/workflows" ] && rsync -av --delete .ai/workflows/ .agent/workflows/

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
mkdir -p .cursor/rules
[ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .cursor/rules/
[ -d ".ai/specifications" ] && cp .ai/specifications/*.md .cursor/rules/ 2>/dev/null
[ -d ".ai/knowledge" ] && cp .ai/knowledge/*.md .cursor/rules/ 2>/dev/null
[ -d ".ai/memory" ] && cp .ai/memory/*.md .cursor/rules/ 2>/dev/null
[ -d ".ai/prompts" ] && cp .ai/prompts/*.md .cursor/rules/ 2>/dev/null

# --- 3. Windsurf (.windsurfrules) ---
echo "📂 Đồng bộ cho Windsurf (.windsurfrules)..."
true > .windsurfrules
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .windsurfrules
echo -e "\n\n# Project Specifications\n" >> .windsurfrules
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .windsurfrules
echo -e "\n\n# Project Knowledge\n" >> .windsurfrules
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .windsurfrules
echo -e "\n\n# Project Memory\n" >> .windsurfrules
[ -d ".ai/memory" ] && cat .ai/memory/*.md >> .windsurfrules

# --- 4. Roo Code / Cline (.clinerules) ---
echo "📂 Đồng bộ cho Roo Code / Cline (.clinerules)..."
true > .clinerules
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .clinerules
echo -e "\n\n# Project Specifications\n" >> .clinerules
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .clinerules
echo -e "\n\n# Project Knowledge\n" >> .clinerules
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .clinerules
echo -e "\n\n# Project Memory\n" >> .clinerules
[ -d ".ai/memory" ] && cat .ai/memory/*.md >> .clinerules

# --- 5. PearAI (.pearai/rules) ---
echo "📂 Đồng bộ cho PearAI (.pearai/rules)..."
mkdir -p .pearai/rules
[ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .pearai/rules/
[ -d ".ai/specifications" ] && cp .ai/specifications/*.md .pearai/rules/ 2>/dev/null
[ -d ".ai/knowledge" ] && cp .ai/knowledge/*.md .pearai/rules/ 2>/dev/null

# --- 6. Trae (.traerules) ---
echo "📂 Đồng bộ cho Trae (.traerules)..."
true > .traerules
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .traerules
echo -e "\n\n# Project Specifications\n" >> .traerules
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .traerules
echo -e "\n\n# Project Knowledge\n" >> .traerules
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .traerules

# --- 7. VS Code / Copilot (.github/copilot-instructions.md) ---
echo "📂 Đồng bộ cho VS Code / Copilot (.github/copilot-instructions.md)..."
mkdir -p .github
true > .github/copilot-instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .github/copilot-instructions.md
echo -e "\n\n# Project Specifications\n" >> .github/copilot-instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .github/copilot-instructions.md

# --- 8. Claude IDE / Desktop (.claude-instructions.md) ---
echo "📂 Đồng bộ cho Claude IDE / Desktop (.claude-instructions.md)..."
true > .claude-instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .claude-instructions.md
echo -e "\n\n# Project Specifications\n" >> .claude-instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .claude-instructions.md

# --- 9. JetBrains / WebStorm (.idea/ai-instructions.md) ---
echo "📂 Đồng bộ cho JetBrains / WebStorm (.idea/ai-instructions.md)..."
mkdir -p .idea
true > .idea/ai-instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .idea/ai-instructions.md
echo -e "\n\n# Project Specifications\n" >> .idea/ai-instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .idea/ai-instructions.md

# --- 10. Zed (.zed/instructions.md) ---
echo "📂 Đồng bộ cho Zed (.zed/instructions.md)..."
mkdir -p .zed
true > .zed/instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .zed/instructions.md
echo -e "\n\n# Project Specifications\n" >> .zed/instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .zed/instructions.md
echo -e "\n\n# Project Knowledge\n" >> .zed/instructions.md
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .zed/instructions.md

# --- 11. Aider (.aider.instructions.md) ---
echo "📂 Đồng bộ cho Aider (.aider.instructions.md)..."
true > .aider.instructions.md
[ -d ".ai/agents" ] && cat .ai/agents/*.md >> .aider.instructions.md
echo -e "\n\n# Project Specifications\n" >> .aider.instructions.md
[ -d ".ai/specifications" ] && cat .ai/specifications/*.md >> .aider.instructions.md
echo -e "\n\n# Project Knowledge\n" >> .aider.instructions.md
[ -d ".ai/knowledge" ] && cat .ai/knowledge/*.md >> .aider.instructions.md

# --- 12. Continue (.continue/rules) ---
echo "📂 Đồng bộ cho Continue (.continue/rules/)..."
mkdir -p .continue/rules
[ -d ".ai/agents" ] && rsync -av --delete .ai/agents/ .continue/rules/
[ -d ".ai/specifications" ] && cp .ai/specifications/*.md .continue/rules/ 2>/dev/null
[ -d ".ai/knowledge" ] && cp .ai/knowledge/*.md .continue/rules/ 2>/dev/null

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
echo "📍 Claude IDE:  .claude-instructions.md & .clinerules"
echo "📍 WebStorm:    .idea/ai-instructions.md"
echo "📍 Zed:         .zed/instructions.md"
echo "📍 Aider (CLI): .aider.instructions.md"
echo "📍 Continue:    .continue/rules/"
echo "📍 Khởi tạo:    ./INITIAL_SESSION.md"
echo "------------------------------------------------"

# Xóa thư mục .ai sau khi hoàn tất
echo "⚠️ Đang xóa thư mục gốc .ai..."
rm -rf .ai

echo "🚀 Hoàn tất! Bạn có thể bắt đầu sử dụng AI Agent trong IDE của mình."
