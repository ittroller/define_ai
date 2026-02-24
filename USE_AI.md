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

## 2. Danh sách 11 Agent Chuyên gia

Hệ thống của bạn có 11 Agent với các vai trò khác nhau (xem chi tiết tại `.ai/agents/README.md`):

1.  **System Architect**: Kiến trúc sư trưởng.
2.  **API Designer**: Thiết kế API.
3.  **Database Expert**: Thiết kế & Tối ưu DB.
4.  **UI Analyst**: Phân tích giao diện.
5.  **Frontend Developer**: Triển khai React (Next.js), Vue (Nuxt.js).
6.  **Backend Developer**: Triển khai Node.js & NestJS (Next.js là phụ).
7.  **Security Expert**: Rà soát bảo mật.
8.  **Performance Expert**: Tối ưu hiệu năng.
9.  **Reviewer & Refactor**: Kiểm soát chất lượng code.
10. **Tester**: Kiểm thử tự động.
11. **DevOps & SRE**: Hạ tầng, CI/CD, Docker.

---

## 3. Quy trình làm việc BẮT BUỘC (Plan-First)

Để tránh sai sót, tất cả các Agent đều tuân thủ quy trình 3 bước:
1.  **Bước 1: Phân tích**: AI nhận yêu cầu và bóc tách vấn đề.
2.  **Bước 2: Lập kế hoạch (PLAN)**: AI đưa ra các bước thực hiện chi tiết. **Bạn cần Review và Đồng ý với kế hoạch này trước khi AI thực hiện.**
3.  **Bước 3: Thực thi**: AI tiến hành viết code hoặc thay đổi cấu hình theo kế hoạch đã duyệt.

---

## 4. Hướng dẫn Đồng bộ (Dành cho Antigravity IDE)

Nếu bạn dùng Antigravity, bạn cần đồng bộ bộ não `.ai` vào thư mục `.agent` của IDE:
1.  Mở terminal tại thư mục gốc dự án.
2.  Chạy lệnh: `bash .ai/sync-to-agent.sh`
3.  Kiểm tra thư mục `.agent` để đảm bảo các quy tắc đã được cập nhật.

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

**Lời khuyên**: Hãy luôn bắt đầu bằng `INITIAL_SESSION.md`. Đó là nút "Khởi động" để chuyển AI từ chế độ "AI chung chung" sang "AI chuyên gia của riêng dự án này".