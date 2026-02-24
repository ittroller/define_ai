#!/bin/bash

# =================================================================
# Script: Sync .ai (Portable) to .agent (Antigravity)
# Mục đích: Đảm bảo các cấu hình trong .ai được áp dụng cho Antigravity
# =================================================================

# 1. Đồng bộ Agents (Agents -> Rules)
echo "🔄 Đồng bộ Agents..."
mkdir -p .agent/rules
rsync -av --delete .ai/agents/ .agent/rules/

# 2. Đồng bộ Workflows
echo "🔄 Đồng bộ Workflows..."
mkdir -p .agent/workflows
rsync -av --delete .ai/workflows/ .agent/workflows/

# 3. Đồng bộ Tri thức dự án vào Skills (Specifications, Knowledge, Memory, Prompts)
echo "🔄 Đồng bộ Project Context vào Skills (Specifications, Knowledge, Memory, Prompts)..."
SKILL_PATH=".agent/skills/skills/project-context"
mkdir -p "$SKILL_PATH"

# Tạo file README cho skill này để Antigravity nhận diện tốt hơn
cat <<EOF > "$SKILL_PATH/README.md"
# Project Context Skill
Kỹ năng này cung cấp toàn bộ bối cảnh dự án, quy chuẩn coding, tri thức nghiệp vụ và các câu lệnh mẫu.

## Nội dung:
- Specifications: Quy chuẩn coding.
- Knowledge: Tech stack và Project Map.
- Memory: Các quyết định kiến trúc (ADR).
- Prompts: Thư viện câu lệnh mẫu.
EOF

rsync -av --delete .ai/specifications/ "$SKILL_PATH/specifications/"
rsync -av --delete .ai/knowledge/ "$SKILL_PATH/knowledge/"
rsync -av --delete .ai/memory/ "$SKILL_PATH/memory/"
rsync -av --delete .ai/prompts/ "$SKILL_PATH/prompts/"

# 4. Đồng bộ MCP Config (nếu có)
if [ -d ".ai/mcp" ]; then
    echo "🔄 Đồng bộ MCP Config..."
    mkdir -p "$SKILL_PATH/mcp"
    rsync -av --delete .ai/mcp/ "$SKILL_PATH/mcp/"
fi

cp .ai/INITIAL_SESSION.md "$SKILL_PATH/"
cp .ai/README.md "$SKILL_PATH/"

echo "✅ Đã đồng bộ toàn bộ hệ thống .ai sang .agent!"
echo "------------------------------------------------"
echo "📍 Agents        -> .agent/rules/"
echo "📍 Workflows     -> .agent/workflows/"
echo "📍 Context & More -> .agent/skills/skills/project-context/"
echo "------------------------------------------------"
