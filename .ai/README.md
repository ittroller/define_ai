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

### Bước 4: Cách triệu hồi Agent trong câu lệnh
Sau khi đã nạp context, bạn có thể ra lệnh cho Agent một cách tự nhiên:
- **Tự động**: "Hãy tạo cho tôi trang Login" -> AI tự đọc file `agents/frontend-dev.md` và nhập vai.
- **Chỉ định**: "Với vai trò @frontend-dev.md, hãy tối ưu lại component này..."
- **Phối hợp**: "Hãy phân tích UI này (@ui-analyst.md) sau đó viết code (@frontend-dev.md) cho tôi."

---

## 📂 Cấu trúc thư mục tối ưu cho AI
Hệ thống được tổ chức để cung cấp đầy đủ Vai trò, Quy trình, Tri thức và Trí nhớ cho AI:

- **[INITIAL_SESSION.md](./INITIAL_SESSION.md)**: 🚀 Điểm bắt đầu cho mọi phiên làm việc.
- `.ai/agents/`: Định nghĩa Vai trò (Ai làm?).
- `.ai/workflows/`: Định nghĩa Quy trình phối hợp (Làm lúc nào?).
- `.ai/specifications/`: Định nghĩa Quy chuẩn kỹ thuật (Làm thế nào cho đúng?).
- `.ai/knowledge/`: Định nghĩa Tri thức dự án & Tech Stack (Làm về cái gì?).
- `.ai/memory/`: Định nghĩa Trí nhớ kiến trúc/ADR (Tại sao lại làm như vậy?).
- `.ai/prompts/`: Thư viện câu lệnh mẫu tối ưu.
- `.ai/mcp/`: Cấu hình công cụ bổ trợ (Dùng gì để làm?).

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

## Hướng dẫn đồng bộ (Sync)
Nếu bạn đang sử dụng **Antigravity IDE**, bạn cần đồng bộ thư mục `.ai` vào thư mục `.agent` để IDE có thể nhận diện các Agent và Workflow.

### Cách thực hiện:
Chạy lệnh sau từ thư mục gốc của dự án:
```bash
./.ai/sync-to-agent.sh
```

### Script này sẽ làm gì?
1. Copy toàn bộ Agent từ `.ai/agents/` vào `.agent/rules/`.
2. Copy toàn bộ Workflow từ `.ai/workflows/` vào `.agent/workflows/`.
3. Tạo một Skill mới tên là `project-context` trong `.agent/skills/` chứa toàn bộ:
    - **Specifications**: Quy chuẩn coding.
    - **Knowledge**: Tri thức dự án.
    - **Memory**: Trí nhớ kiến trúc.
    - **Prompts**: Câu lệnh mẫu.
    - **MCP**: Cấu hình công cụ.

---

## Hướng dẫn sử dụng Context7
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
3.  **Làm sạch Trí nhớ (Memory)**: Xóa các file ADR cũ trong `.ai/memory/` hoặc ghi đè bằng các quyết định kiến trúc của dự án mới.
4.  **Kiểm tra Quy chuẩn (Specifications)**: Chỉnh sửa `.ai/specifications/coding-standards.md` nếu dự án mới có quy định viết code khác.
5.  **Cấu hình MCP (Nếu có)**: Cập nhật API key cho `context7` trong `.ai/mcp/mcp.json` nếu cần.
6.  **Đồng bộ lại**: Nếu dùng Antigravity, hãy chạy lại `./.ai/sync-to-agent.sh`.

---
*Tài liệu này được soạn thảo bởi AI Architect nhằm tối ưu hóa quy trình làm việc cho Javascript Developers.*
