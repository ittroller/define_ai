# 👥 Danh sách Agent (.ai/agents)

Thư mục này chứa các định nghĩa vai trò (Roles) cho hệ thống AI Agent của dự án. Mỗi file Markdown mô tả hồ sơ, trách nhiệm và quy trình làm việc của một chuyên gia cụ thể.

---

## 🏗️ Chi tiết các Agent

Hệ thống bao gồm 11 Agent phối hợp chặt chẽ:

### 1. 🏛️ System Architect ([system-architect.md](./system-architect.md))
*   **Vai trò**: Kiến trúc sư trưởng.
*   **Nhiệm vụ**: Quản lý quyết định kiến trúc (ADR), cấu trúc thư mục, tiêu chuẩn kỹ thuật và lộ trình phát triển.

### 2. 🛣️ API Designer ([api-designer.md](./api-designer.md))
*   **Vai trò**: Chuyên gia thiết kế API.
*   **Nhiệm vụ**: Định nghĩa Endpoint, DTO, Request/Response, tài liệu API (OpenAPI/Swagger) và cơ chế Auth.

### 3. 🗄️ Database Expert ([database-expert.md](./database-expert.md))
*   **Vai trò**: Chuyên gia Cơ sở dữ liệu.
*   **Nhiệm vụ**: Thiết kế Schema (Prisma), tối ưu hóa câu lệnh truy vấn, quản lý Migration và đảm bảo hiệu năng DB.

### 4. 🎨 UI Analyst ([ui-analyst.md](./ui-analyst.md))
*   **Vai trò**: Chuyên gia phân tích giao diện.
*   **Nhiệm vụ**: Bóc tách component (Atomic Design), xác định Design System và quy trình tương tác người dùng.

### 5. 💻 Frontend Developer ([frontend-dev.md](./frontend-dev.md))
*   **Vai trò**: Senior Frontend Engineer (Multi-Framework Specialist).
*   **Nhiệm vụ**: Triển khai UI/UX trên React (Next.js), Vue (Nuxt.js), quản lý State, kết nối API và tối ưu hiệu năng phía Client.

### 6. ⚙️ Backend Developer ([backend-dev.md](./backend-dev.md))
*   **Vai trò**: Senior Backend Developer (Node.js & NestJS Expert).
*   **Nhiệm vụ**: Triển khai logic nghiệp vụ chuyên sâu trên NestJS/Node.js, tối ưu Performance hệ thống và đảm bảo Type-safety (Next.js là phụ trợ).

### 7. 🛡️ Security & Privacy Expert ([security-expert.md](./security-expert.md))
*   **Vai trò**: Chuyên gia Bảo mật.
*   **Nhiệm vụ**: Rà soát mã nguồn (Audit), bảo mật dữ liệu, thiết kế luồng Auth an toàn và kiểm tra Dependency.

### 8. ⚡ Performance & Scaling Expert ([performance-expert.md](./performance-expert.md))
*   **Vai trò**: Chuyên gia Hiệu năng & Mở rộng.
*   **Nhiệm vụ**: Tối ưu hóa Response Time, thiết kế hệ thống Caching, quản lý Tải (Queue) và Profiling.

### 9. 🔍 Reviewer & Refactor ([reviewer.md](./reviewer.md))
*   **Vai trò**: Chuyên gia kiểm soát chất lượng & Tái cấu trúc.
*   **Nhiệm vụ**: Review mã nguồn theo chuẩn Clean Code, thực hiện refactoring và đảm bảo tính nhất quán của project.

### 10. 🧪 Tester ([tester.md](./tester.md))
*   **Vai trò**: Kỹ sư kiểm thử tự động.
*   **Nhiệm vụ**: Viết Unit test, Integration test, E2E và kiểm tra các kịch bản lỗi (Edge cases).

### 11. 🚀 DevOps & SRE ([devops-sre.md](./devops-sre.md))
*   **Vai trò**: Chuyên gia Hạ tầng & Triển khai.
*   **Nhiệm vụ**: Quản lý Docker, CI/CD, cấu hình môi trường, bảo mật hạ tầng và giám sát (Sentry).

---

## 🛠️ Cách sử dụng

1.  **Trong IDE hỗ trợ Reference (Cursor/Copilot)**: Gõ `@` và chọn file agent tương ứng để nạp ngữ cảnh.
2.  **Trong các AI Chat khác**: Yêu cầu AI đọc file trong thư mục này để hiểu vai trò trước khi thực hiện tác vụ.
3.  **Triệu hồi**: "Với vai trò @frontend-dev.md, hãy tạo một component..."

---
*Tài liệu này là trung tâm điều khiển vai trò AI cho dự án.*
