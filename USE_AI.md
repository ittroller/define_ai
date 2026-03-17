# 🤖 Hướng dẫn sử dụng AI Agent (.ai)

Tài liệu này hướng dẫn bạn cách kích hoạt và tận dụng tối đa "bộ não AI" đã được cấu hình sẵn trong thư mục `.ai` của dự án này.

---

## 1. Khởi động AI (Mồi ngữ cảnh)

Khi bạn sử dụng một IDE mới (VS Code, Cursor, WebStorm) hoặc bắt đầu một phiên làm việc mới, hãy thực hiện các bước sau để AI nắm rõ "luật chơi":

### Bước 1: Mở trình Chat AI
Dùng GitHub Copilot Chat, Cursor Chat, hoặc các extension như Roo Code, Cline.

### Bước 2: Gửi Prompt khởi tạo
Mở file **`.ai/INITIAL_SESSION.md`**, sao chép toàn bộ nội dung trong phần **"Nội dung Prompt"** và gửi cho AI.

### Bước 3: Tận dụng Reference (Nếu có)
Nếu IDE hỗ trợ (như Cursor/Copilot), hãy dùng ký hiệu `@` hoặc `#` để chỉ định file trực tiếp:
- `@.ai`: Đưa toàn bộ cấu hình vào context.
- `@coding-standards.md`: Yêu cầu AI kiểm tra code theo chuẩn.

---

## 2. Danh sách 19 Agent Chuyên gia

Hệ thống của bạn có các Agent với vai trò khác nhau (xem chi tiết tại `.ai/agents/README.md`):

### Core & Web
1.  **System Architect**: Kiến trúc sư trưởng.
2.  **API Designer**: Thiết kế REST/GraphQL API.
3.  **Database Expert**: Thiết kế DB & Prisma Expert.
4.  **UI Analyst**: Phân tích giao diện & Figma Expert.
5.  **Frontend Developer**: React (Next.js), Vue (Nuxt.js).
6.  **Backend Node Developer**: Node.js & NestJS Expert.
7.  **Backend Python Developer**: FastAPI, Django, Odoo Expert.
8.  **Backend Go Developer**: Golang Microservices Expert.

### Mobile Development
9.  **Mobile RN Developer**: React Native (Cross-platform).
10. **Mobile Flutter Developer**: Flutter (Cross-platform).
11. **Mobile Swift Developer**: Native iOS (Swift).
12. **Mobile Kotlin Developer**: Native Android (Kotlin).
13. **Mobile Java Developer**: Native Android/Legacy (Java).
14. **Mobile Obj-C Developer**: Native iOS/Legacy (Objective-C).

### Quality & Operations
15. **Security Expert**: Rà soát bảo mật.
16. **Performance Expert**: Tối ưu hiệu năng.
17. **Reviewer & Refactor**: Kiểm soát chất lượng code.
18. **Tester**: Kiểm thử tự động.
19. **DevOps & SRE**: Hạ tầng, CI/CD, Docker.

---

## 3. Quy trình làm việc BẮT BUỘC (Plan-First)

Để tránh sai sót, tất cả các Agent đều tuân thủ quy trình 3 bước:
1.  **Bước 1: Phân tích**: AI nhận yêu cầu và bóc tách vấn đề.
2.  **Bước 2: Lập kế hoạch (PLAN)**: AI đưa ra các bước thực hiện chi tiết. **Bạn cần Review và Đồng ý với kế hoạch này trước khi AI thực hiện.**
3.  **Bước 3: Thực thi**: AI tiến hành viết code hoặc thay đổi cấu hình theo kế hoạch đã duyệt.

---

## 4. 🔄 Hướng dẫn Đồng bộ cho các IDE (QUAN TRỌNG)

Dự án này sử dụng cấu hình AI "di động" trong thư mục `.ai`. Để IDE của bạn nhận diện được toàn bộ nội dung (Agents, Specifications, Knowledge, Memory, Prompts), bạn cần thực hiện đồng bộ một lần duy nhất:

1.  Mở terminal tại thư mục gốc dự án.
2.  Chạy lệnh: `bash .ai/sync-to-agent.sh`
3.  **Sao lưu an toàn**: Script sẽ tự động tìm và sao lưu các cấu hình AI hiện có vào thư mục `.ai_backups/` trước khi thực hiện đồng bộ.
4.  **Thư mục `.ai` sẽ được giữ lại** sau khi đồng bộ để bạn có thể tiếp tục chỉnh sửa cấu hình gốc:
    -   **Antigravity**: `.agent/`
    -   **Codex**: `.codex/`
    -   **Cursor**: `.cursor/rules/`
    -   **VS Code / Copilot**: `.github/copilot-instructions.md` (Tổng hợp)
    -   **Claude IDE / Desktop**: `.claude-instructions.md` (Tổng hợp)
    -   **WebStorm / JetBrains**: `.idea/ai-agents/` và `.idea/ai-instructions.md` (Tổng hợp)
    -   **Xcode**: `.xcoderules` (Tổng hợp)
5.  **Khởi tạo**: Sau khi đồng bộ, file `INITIAL_SESSION.md` sẽ xuất hiện ở thư mục gốc. Hãy mở nó để bắt đầu phiên chat với AI.
6.  **Ví dụ cụ thể**: Xem thêm các ví dụ thực tế sử dụng Superpowers tại `.ai/prompts/usage-examples.md`.

---

## 5. Sử dụng Công cụ Context7 (Upstash)

AI có khả năng tra cứu tài liệu thực tế thông qua `context7`:
- Tìm tài liệu thư viện: `context7 doc [tên thư viện]`
- Tìm giải pháp/best practices: `context7 search [vấn đề]`

---

## 6. Portability Checklist (Mang bộ .ai sang dự án khác)

Khi bạn copy thư mục `.ai` này sang dự án khác, hãy cập nhật:
1.  **`.ai/knowledge/project-map.md`**: Xóa nội dung cũ và nhờ AI quét lại cấu trúc thư mục mới.
2.  **`.ai/knowledge/tech-stack.md`**: Cập nhật các công nghệ dự án mới đang dùng.
3.  **`.ai/memory/adr.md`**: Ghi lại các quyết định kiến trúc của dự án mới.

---

## 7. 🚀 Hướng dẫn sử dụng cho WebStorm & JetBrains AI

Để WebStorm AI nhận diện và sử dụng đúng Agent (ví dụ: `backend-python-dev`), hãy thực hiện các bước sau sau khi đã chạy lệnh `sync`:

1.  **Mồi ngữ cảnh (BẮT BUỘC)**:
    - Mở file `INITIAL_SESSION.md` tại thư mục gốc.
    - Copy nội dung phần **"Nội dung Prompt"**.
    - Dán vào ô chat của **JetBrains AI Assistant**.
2.  **Chỉ định Agent cụ thể**:
    - **Highlight/Nhấn mạnh**: Để AI đóng vai chính xác, hãy thêm câu lệnh: 
      > *"Hãy đóng vai `backend-python-dev` từ file `.idea/ai-agents/rules/backend-python-dev.md` để hỗ trợ tôi."*
3.  **Sử dụng tính năng Mention (@)**:
    - Gõ `@` trong ô chat và chọn file agent tương ứng trong thư mục `.idea/ai-agents/rules/` để AI đọc trực tiếp chỉ dẫn.

---

## 8. 🛠️ Thư viện câu lệnh thực thi (Actionable Command Library)

Dưới đây là một số ví dụ câu lệnh bạn có thể copy và gửi cho AI để thực hiện các tác vụ cụ thể.

### 🏗️ Phát triển tính năng (Feature Development)
- `Triệu hồi @backend-node-dev.md, hãy tạo một API GET /users để lấy danh sách người dùng, sử dụng Prisma.`
- `Dựa trên @05-feature-dev.md, hãy thiết kế module Auth với JWT theo phong cách NestJS.`
- `Hãy phân tích UI Figma tại link này [link figma] và triệu hồi @ui-analyst.md để bóc tách các components cần thiết.`

### 🐞 Sửa lỗi & Debug (Bug Fixing & Debugging)
- `Tôi đang gặp lỗi [mô tả lỗi]. Triệu hồi @reviewer.md hãy phân tích file [tên file] và tìm nguyên nhân.`
- `Hãy chạy workflow @04-bug-fixing.md để xử lý lỗi crash khi nhấn nút Đăng ký.`
- `Dựa trên lỗi log này [copy log vào đây], hãy tìm file nào gây ra lỗi và đề xuất cách sửa.`

### ♻️ Refactor & Tối ưu (Refactoring & Optimization)
- `Triệu hồi @performance-expert.md, hãy tối ưu truy vấn SQL trong hàm getOrders này.`
- `Dựa trên @coding-standards.md, hãy refactor file [tên file] để code sạch và dễ bảo trì hơn.`
- `Hãy kiểm tra file [tên file] có vi phạm nguyên tắc SOLID nào không và sửa lại giúp tôi.`

### 🧪 Viết Test (Testing)
- `Triệu hồi @tester.md, hãy viết Unit Test cho hàm calculatePrice, đảm bảo độ bao phủ (coverage) 100%.`
- `Hãy tạo script E2E test cho luồng thanh toán bằng Playwright dựa trên @docs/flows/checkout.md.`
- `Hãy chạy test module Auth và báo cáo kết quả cho tôi.`

### 📚 Viết Tài liệu (Documentation)
- `Hãy viết tài liệu README.md cho module này, bao gồm cách cài đặt và sử dụng.`
- `Hãy cập nhật file @project-map.md dựa trên cấu trúc thư mục hiện tại.`
- `Hãy tóm tắt lịch sử quyết định trong dự án dựa trên thư mục @memory/adr/.`

---

---

## 9. ⚡ Kích hoạt Superpowers (Siêu năng lực AI)

Hệ thống của bạn tích hợp framework Superpowers thông qua giao thức MCP (Model Context Protocol).

#### Sự kết hợp giữa `@`, `/` và MCP Tools:
- **`@` (Reference)**: Dùng để triệu hồi một **Chuyên gia (Agent)**. Khi bạn `@agent-name`, AI sẽ đóng vai chuyên gia đó. **Quan trọng**: Các chuyên gia này đã được huấn luyện để chủ động sử dụng MCP Tools (Context7/Superpowers) khi họ cần thêm thông tin hoặc thực hiện các quy trình chuẩn.
- **`/` (Slash Commands)**: Dùng để kích hoạt nhanh một **Quy trình (Workflow)**. Nếu quy trình đó yêu cầu tìm kiếm tài liệu hoặc chạy test, AI sẽ tự động gọi MCP tương ứng.
- **MCP Tools (Superpowers/Context7)**: Đây là **"Cơ bắp" thực thi**. Dù bạn đang dùng Agent nào hay Workflow nào, AI đều có thể lấy các công cụ này ra dùng để bổ trợ cho nhiệm vụ đang làm.

### Hướng dẫn Cài đặt nhanh (Setup):
Để kích hoạt các công cụ này, bạn cần cấu hình server MCP trong IDE của mình. Xem hướng dẫn chi tiết từng bước cho từng IDE tại:
👉 **[.ai/superpowers/IDE_SETUP.md](.ai/superpowers/IDE_SETUP.md)**

### Cách sử dụng các công cụ (Tools):
1.  **Cursor / Claude Desktop / Antigravity / Codex**: Các IDE này sẽ tự động nhận diện các server MCP trong file cấu hình. Bạn chỉ cần yêu cầu AI sử dụng tool.
    - *Ví dụ*: "Hãy dùng `context7` tìm tài liệu về thư viện Zod."
    - *Ví dụ*: "Hãy dùng `superpowers` chạy workflow TDD cho tính năng Login."
2.  **WebStorm / VS Code**: Bạn cần cài đặt các plugin hỗ trợ MCP (như **MCP Client** cho WebStorm, **Roo Code / Cline** cho VS Code) và cấu hình server MCP theo hướng dẫn.

### Các Siêu năng lực sẵn có:
-   **Context7 (Upstash)**: MCP Server chuyên về **Kiến thức (Knowledge/RAG)**. Tra cứu tài liệu và giải pháp thực tế.
-   **Superpowers (MCP)**: MCP Server chuyên về **Kỹ năng thực thi (Skills/Actions)**. Bao gồm TDD, Advanced Debugging, và các quy trình code chuẩn.

---

**Lời khuyên**: Hãy luôn bắt đầu bằng `INITIAL_SESSION.md`. Đó là nút "Khởi động" để chuyển AI từ chế độ "AI chung chung" sang "AI chuyên gia của riêng dự án này".
>,search: