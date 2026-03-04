# 🚀 Mẫu: Khởi tạo tính năng mới (New Feature Starter)

Sử dụng mẫu này khi bạn muốn bắt đầu một tính năng mới từ con số 0 (chưa có UI, DB hay Logic).

---

## 💬 Nội dung Prompt mẫu

"Chào **@ai-orchestrator.md**, tôi muốn phát triển một tính năng mới: **[TÊN TÍNH NĂNG - Ví dụ: Đăng ký/Đăng nhập]**.

Hiện tại hệ thống chưa có gì cho tính năng này (chưa có DB, UI, Backend). Hãy giúp tôi thực hiện theo quy trình **`workflows/05-feature-dev.md`**:

**Yêu cầu cụ thể:**
- **Mục tiêu**: [Ví dụ: Cho phép người dùng đăng ký bằng email/mật khẩu, xác thực qua JWT].
- **Tech Stack**: [Tham khảo @tech-stack.md - Ví dụ: NestJS + Prisma + PostgreSQL].
- **Giao diện**: [Ví dụ: Theo phong cách Shadcn/UI, tối giản].

**Bước 1 (Thiết kế & Phân tích):**
Hãy triệu hồi **@system-architect.md** và **@ui-analyst.md** để:
1. Phân tích các màn hình cần thiết (UI Flow).
2. Đề xuất luồng nghiệp vụ (Business Logic).

**Bước 2 (Cơ sở hạ tầng):**
Hãy triệu hồi **@database-expert.md** và **@api-designer.md** để:
1. Thiết kế Schema Database (Prisma schema hoặc SQL).
2. Thiết kế danh sách REST API endpoints (Swagger/OpenAPI).

**Lưu ý:** Hãy trình tôi xem **Kế hoạch chi tiết (Plan)** sau khi hoàn thành thiết kế, TRƯỚC khi bắt đầu viết bất kỳ dòng code nào."

---

## 💡 Tại sao dùng mẫu này?
- **Tránh code lỗi**: Ép AI phải thiết kế trước khi code.
- **Tiết kiệm Token**: AI chỉ tập trung vào các Agent thiết kế ở giai đoạn đầu.
- **Dễ kiểm soát**: Bạn có thể duyệt qua Schema DB và API trước khi AI tạo ra hàng loạt file.
