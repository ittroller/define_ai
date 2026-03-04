# 🤖 Hệ thống AI Architect Portable

> **BẮT ĐẦU TẠI ĐÂY**: Để AI có thể hỗ trợ bạn tốt nhất, hãy mở file **[INITIAL_SESSION.md](./INITIAL_SESSION.md)** và copy nội dung Prompt vào ô chat với AI ngay khi bắt đầu phiên làm việc mới.

---

Hệ thống này được thiết kế để hoạt động trên mọi IDE (Cursor, VSCode, WebStorm, Antigravity) bằng cách sử dụng các file cấu hình Markdown tiêu chuẩn.

## 🚀 Hướng dẫn Quick Start cho IDE mới (VS Code, Cursor, ...)

Khi bạn mở dự án này ở một IDE mới, hãy thực hiện các bước sau để "kích hoạt" bộ não AI:

### Bước 1: Mở trình Chat của AI
Sử dụng công cụ AI bạn đang dùng (GitHub Copilot Chat, Cursor Chat, Roo Code, Claude Dev, v.v...).

### Bước 2: Gửi lệnh khởi tạo
Mở file **`.ai/INITIAL_SESSION.md`**, copy toàn bộ nội dung trong phần **"Nội dung Prompt"** và gửi cho AI.

### Bước 3: Tận dụng tính năng Reference (Nếu có)
- **Nếu dùng Cursor/Copilot**: Gõ `@` và chọn thư mục `.ai` hoặc các file cụ thể trong đó để AI có context tốt nhất.
- **Nếu dùng Roo Code/Cline**: AI sẽ tự động đọc các file nếu bạn yêu cầu nó "Read .ai folder to understand project rules".

### Bước 4: Cách triệu hồi Agent & Workflow trong câu lệnh
Sau khi đã nạp context, bạn có thể ra lệnh cho Agent một cách tự nhiên:
- **Tự động**: "Hãy tạo cho tôi trang Login" -> AI tự đọc file `agents/frontend-dev.md` và nhập vai.
- **Chỉ định (Cursor/PearAI)**: Gõ `@` và chọn file agent: "Với vai trò @frontend-dev.md, hãy tối ưu lại component này..."
- **Theo quy trình**: "Dùng @05-feature-dev.md hãy lập kế hoạch cho tính năng XYZ."
- **Xem thêm ví dụ**: **[.ai/prompts/usage-examples.md](./prompts/usage-examples.md)**

---

## 🛠️ CLI: npx minhck-dot-ai

Bạn có thể quản lý bộ khung AI Agent bằng các lệnh CLI sau:

- `npx minhck-dot-ai init`: Cài đặt thư mục `.ai` vào dự án mới.
- `npx minhck-dot-ai sync`: Đồng bộ cấu hình từ `.ai` sang các IDE (thay thế việc chạy bash thủ công).
- `npx minhck-dot-ai backup`: Sao lưu thủ công thư mục `.ai`.

---

## 📂 Cấu trúc thư mục tối ưu cho AI
Hệ thống được tổ chức để cung cấp đầy đủ Vai trò, Quy trình, Tri thức và Trí nhớ cho AI:

- **[INITIAL_SESSION.md](./INITIAL_SESSION.md)**: 🚀 Điểm bắt đầu cho mọi phiên làm việc.
- `.ai/agents/`: Định nghĩa Vai trò (Ai làm?). ✨ **Bổ sung ai-orchestrator.md**
- `.ai/skills/`: Định nghĩa Kỹ năng chuyên sâu (Làm được gì?).
- `.ai/workflows/`: Định nghĩa Quy trình phối hợp (Làm lúc nào?). ✨ **Bổ sung Bug-fixing, Feature-dev**
- `.ai/hooks/`: Định nghĩa Các chốt chặn/kiểm tra tự động (Làm sao để an toàn?).
- `.ai/specifications/`: Định nghĩa Quy chuẩn kỹ thuật (Làm thế nào cho đúng?).
- `.ai/knowledge/`: Định nghĩa Tri thức dự án & Tech Stack (Làm về cái gì?).
- `.ai/docs/`: Định nghĩa Tài liệu kiến trúc & vận hành (Hệ thống ra sao?).
- `.ai/memory/`: Định nghĩa Trí nhớ kiến trúc/ADR (Tại sao lại làm như vậy?).
- `.ai/prompts/`: Thư viện câu lệnh mẫu tối ưu.
- `.ai/mcp/`: Cấu hình công cụ bổ trợ (Dùng gì để làm?).

## 🧠 Core Agent: AI Orchestrator
Trong phiên bản này, chúng tôi giới thiệu **AI Orchestrator** (`.ai/agents/ai-orchestrator.md`). Đây là Agent quan trọng nhất:
1. Nó điều phối các Agent khác (Frontend, Backend, Tester...).
2. Nó quản lý và bảo trì chính hệ thống `.ai` này.
3. Nó giúp bạn lập kế hoạch (Plan) trước khi thực hiện các task phức tạp.

## 👥 Danh sách Agent

Xem chi tiết tại: **[.ai/agents/README.md](./agents/README.md)**

Hệ thống bao gồm 19 Agent chuyên gia phối hợp chặt chẽ:

### Core & Web
1. **[System Architect](./agents/system-architect.md)**: Kiến trúc sư trưởng.
2. **[API Designer](./agents/api-designer.md)**: Thiết kế REST/GraphQL API.
3. **[Database Expert](./agents/database-expert.md)**: Chuyên gia DB & Prisma Expert.
4. **[UI Analyst](./agents/ui-analyst.md)**: Phân tích giao diện & Figma Expert.
5. **[Frontend Developer](./agents/frontend-dev.md)**: React (Next.js), Vue (Nuxt.js).
6. **[Backend Node Developer](./agents/backend-node-dev.md)**: Node.js & NestJS Expert.
7. **[Backend Python Developer](./agents/backend-python-dev.md)**: FastAPI, Django Expert.
8. **[Backend Go Developer](./agents/backend-go-dev.md)**: Golang Microservices Expert.

### Mobile
9. **[Mobile RN Developer](./agents/mobile-rn-dev.md)**: React Native (Cross-platform).
10. **[Mobile Flutter Developer](./agents/mobile-flutter-dev.md)**: Flutter (Cross-platform).
11. **[Mobile Swift Developer](./agents/mobile-swift-dev.md)**: Native iOS (Swift).
12. **[Mobile Kotlin Developer](./agents/mobile-kotlin-dev.md)**: Native Android (Kotlin).
13. **[Mobile Java Developer](./agents/mobile-java-dev.md)**: Native Android/Legacy (Java).
14. **[Mobile Obj-C Developer](./agents/mobile-objc-dev.md)**: Native iOS/Legacy (Objective-C).

### Quality & Ops
15. **[Security Expert](./agents/security-expert.md)**: Rà soát bảo mật.
16. **[Performance Expert](./agents/performance-expert.md)**: Tối ưu hiệu năng.
17. **[Reviewer & Refactor](./agents/reviewer.md)**: Kiểm soát chất lượng code.
18. **[Tester](./agents/tester.md)**: Kiểm thử tự động.
19. **[DevOps & SRE](./agents/devops-sre.md)**: Hạ tầng, CI/CD, Docker.

## 🔄 Hướng dẫn Đồng bộ (Sync) cho các IDE (QUAN TRỌNG)

Để AI có thể hoạt động hiệu quả nhất, bạn cần đồng bộ toàn bộ nội dung trong thư mục `.ai` vào cấu hình chuẩn của IDE bạn đang sử dụng. 

**Chạy lệnh sau từ thư mục gốc của dự án để tự động thực hiện:**
```bash
bash .ai/sync-to-agent.sh
```

### Sau khi chạy script này:
1.  **Tự động Sao lưu**: Script sẽ phát hiện và sao lưu toàn bộ cấu hình AI cũ của bạn (nếu có) vào thư mục `.ai_backups/` để đảm bảo an toàn.
2.  **Thư mục `.ai` sẽ được xóa bỏ** để giữ dự án sạch sẽ.
3.  **Toàn bộ cấu hình (Agents, Specifications, Knowledge, Memory, Prompts) sẽ được chuyển vào các thư mục tương ứng:**
    -   **Antigravity**: Chuyển vào `.agent/` (Đầy đủ thư mục)
    -   **Cursor**: Chuyển vào `.cursor/rules/` & `.cursor/hooks/`
    -   **Windsurf**: Tổng hợp vào `.windsurfrules`
    -   **Roo Code / Cline**: Tổng hợp vào `.clinerules`
    -   **PearAI**: Chuyển vào `.pearai/rules/`
    -   **Trae**: Tổng hợp vào `.traerules`
    -   **VS Code**: Tổng hợp vào `.github/copilot-instructions.md`
    -   **Claude IDE / Desktop**: Tổng hợp vào `.claude-instructions.md`
    -   **Claude Code (CLI)**: Chuyển vào thư mục `.claude/` (gồm `skills`, `hooks`, `docs` và `CLAUDE.md`)
    -   **WebStorm / JetBrains**: Tổng hợp vào `.idea/ai-instructions.md`
    -   **Zed**: Tổng hợp vào `.zed/instructions.md`
    -   **Aider (CLI)**: Tổng hợp vào `.aider.instructions.md`
    -   **Continue**: Chuyển vào `.continue/rules/`
3.  **File `INITIAL_SESSION.md`** sẽ được đưa ra thư mục gốc để bạn dễ dàng bắt đầu phiên làm việc.

### 📊 So sánh cơ chế đồng bộ (Sync Strategy)

Tùy thuộc vào khả năng của từng IDE, hệ thống sẽ tự động chọn cách tổ chức file phù hợp nhất:

| Loại IDE | Cấu trúc sau khi Sync | Đặc điểm |
| :--- | :--- | :--- |
| **Folder-based** (Antigravity, Cursor, Claude Code, PearAI, Continue) | Có thư mục con (`skills/`, `docs/`, `agents/`, `hooks/`) | Giữ nguyên sự ngăn nắp của Framework. AI dễ dàng tìm kiếm context theo phân loại. |
| **File-based** (Windsurf, Roo Code, Trae, Copilot, Zed, JetBrains) | Đóng gói tất cả vào 1 file instructions duy nhất | Tối ưu cho các công cụ chỉ hỗ trợ một file rules tổng hợp. Đảm bảo AI luôn mang theo toàn bộ tri thức trong một file. |

---

## 🛠️ Hỗ trợ các IDE khác & Neovim
- **Neovim (Avante.nvim / CodeCompanion)**: Các plugin này thường tự động nhận diện file `.cursorrules` hoặc `.clinerules` đã được tạo trong quá trình đồng bộ.
- **Android Studio**: Sử dụng chung cấu hình với WebStorm (`.idea/ai-instructions.md`).
- **Visual Studio**: Bạn có thể tham chiếu trực tiếp đến các file trong thư mục `.agent/` sau khi đồng bộ.

---

## 🧩 Tính năng: Ngữ cảnh cục bộ (Local Context)

Để AI hoạt động tốt nhất trong các module lớn, bạn nên áp dụng chiến thuật "Context Scoping":
1. Copy file mẫu `.ai/prompts/module-context-template.md` vào thư mục module bạn muốn (ví dụ `src/features/auth/`).
2. Đổi tên thành `CLAUDE.md` (nếu dùng Claude Code) hoặc `.ai-context.md`.
3. Cập nhật nội dung đặc thù cho module đó.
AI sẽ ưu tiên đọc các file này khi bạn làm việc bên trong thư mục đó.

---
`context7` là công cụ mạnh mẽ để mở rộng tri thức của AI ngoài dữ liệu huấn luyện cục bộ.

### 1. Tìm kiếm tài liệu tối ưu
Thay vì yêu cầu AI tự đoán, hãy cung cấp context đúng:
- **Cú pháp**: `context7 search [keywords]` hoặc `context7 doc [library]`.
- **Ví dụ**: `context7 search shadcn/ui installation with nextjs app router`.

### 2. Tìm kiếm thư viện & Best Practices
Để code luôn hiện đại và tối ưu:
- **Ví dụ**: `context7 search best practices for state management in large scale react apps 2024`.

### 3. Tối ưu hóa Context gửi cho Agent
- **Nguyên tắc**: Chỉ gửi những gì cần thiết.
- **Sử dụng lệnh**: `context7 list files` để xem cấu trúc và chọn file liên quan trước khi đọc toàn bộ.
- **Tập trung**: Khi nhờ `Frontend Dev` sửa bug UI, hãy cung cấp context của file component đó và file style liên quan, thay vì toàn bộ source base.

## Cách tích hợp vào IDE
- **Cursor/VSCode**: Mở thư mục này và chỉ định AI đọc các file trong `.ai/agents` làm Rule/Instruction.
- **WebStorm/Antigravity**: Sử dụng plugin hỗ trợ AI và trỏ context vào thư mục `.ai`.

---

## 🚀 Hướng dẫn Di chuyển (Portability Checklist)

Khi bạn copy thư mục `.ai` này sang một dự án khác, hãy thực hiện các bước sau để "tái hòa nhập" bộ não AI với dự án mới:

1.  **Cập nhật Project Map**: Xóa nội dung trong `.ai/knowledge/project-map.md` và nhờ AI quét cấu trúc thư mục mới để cập nhật lại.
2.  **Cấu hình Tech Stack**: Cập nhật các công nghệ, thư viện đang dùng của dự án mới vào `.ai/knowledge/tech-stack.md`.
3.  **Làm sạch Trí nhớ (Memory) & Tài liệu (Docs)**: 
    - Xóa các file ADR cũ trong `.ai/memory/`.
    - Cập nhật hoặc xóa nội dung trong `.ai/docs/architecture/` và `runbooks/` để tránh AI nhầm lẫn với dự án cũ.
4.  **Cấu hình Hooks (Quan trọng)**: Kiểm tra các script trong `.ai/hooks/`. Đảm bảo các lệnh như `npm test`, `npm run lint` khớp với script trong `package.json` của dự án mới.
5.  **Kiểm tra Quy chuẩn (Specifications)**: Chỉnh sửa `.ai/specifications/coding-standards.md` nếu dự án mới có quy định viết code khác.
6.  **Review Skills & Prompts**: Hầu hết là dùng chung được, nhưng hãy kiểm tra nếu có skill nào cần dùng tool đặc thù của dự án.
7.  **Cấu hình MCP (Nếu có)**: Cập nhật API key cho `context7` trong `.ai/mcp/mcp.json` nếu cần.
8.  **Đồng bộ lại**: Chạy lại lệnh `bash .ai/sync-to-agent.sh`.

---
*Tài liệu này được soạn thảo bởi AI Architect nhằm tối ưu hóa quy trình làm việc cho Javascript Developers.*
