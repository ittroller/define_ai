# 🚀 Ví dụ thực tế sử dụng Superpowers (Context7 & MCP)

Dưới đây là các kịch bản cụ thể để bạn tận dụng tối đa "Siêu năng lực" của AI ngay trong quá trình viết code.

---

## 1. 🔍 Tra cứu tài liệu (Context7)
Thay vì thoát ra trình duyệt để search, hãy yêu cầu AI search ngay trong chat.

**Kịch bản**: Bạn muốn dùng thư viện `Zod` để validate dữ liệu nhưng quên mất cú pháp `discriminatedUnion`.

- **Câu lệnh**: `@backend-node-dev dùng context7 search "zod discriminatedUnion example" và viết cho tôi schema validate cho User với role là ADMIN hoặc USER.`
- **Kết quả**: AI sẽ dùng `context7` để lấy doc mới nhất và viết code chính xác, tránh dùng code cũ lỗi thời.

---

## 2. 🧪 Viết code theo chuẩn TDD (Superpowers MCP)
Sử dụng workflow TDD để đảm bảo code chạy đúng ngay từ đầu.

**Kịch bản**: Bạn cần viết hàm tính tổng tiền giỏ hàng (Cart) có tính thuế và giảm giá.

- **Câu lệnh**: `/tdd-workflow viết hàm calculateTotal cho Cart. Yêu cầu: Viết unit test trước bằng Vitest, sau đó mới viết logic hàm.`
- **Kết quả**: AI sẽ dùng tool `superpowers` kích hoạt workflow TDD:
  1. Tạo file test `cart.spec.ts`.
  2. Chạy test (thất bại).
  3. Viết code trong `cart.ts`.
  4. Chạy test lại (thành công).

---

## 3. 🐞 Debug lỗi "khó nhằn" (Advanced Debugging)
Khi gặp lỗi logic hoặc lỗi mờ ám (như race condition, memory leak).

**Kịch bản**: API trả về 500 nhưng log không rõ ràng.

- **Câu lệnh**: `@reviewer hãy dùng superpowers advanced-debug để phân tích lỗi 500 tại endpoint /api/payment. Đây là log lỗi hiện tại: [dán log vào]`
- **Kết quả**: AI sẽ thực hiện quy trình 5 bước:
  1. Tái hiện lỗi.
  2. Thu thập thêm ngữ cảnh (quét các file liên quan).
  3. Đưa ra các giả thuyết.
  4. Thử nghiệm giải pháp.
  5. Kiểm chứng lại.

---

## 4. 🏗️ Thiết kế kiến trúc (System Architect + Context7)
Khi bắt đầu một module mới và muốn tham khảo kiến trúc tốt nhất.

**Kịch bản**: Cần thiết kế module Real-time Chat dùng Socket.io với NestJS.

- **Câu lệnh**: `@system-architect dùng context7 search "nestjs socket.io best practices 2024" và thiết kế cấu trúc module chat cho dự án này.`
- **Kết quả**: AI sẽ tìm kiếm các kiến trúc microservices hoặc event-driven mới nhất và đề xuất cấu trúc thư mục phù hợp với dự án hiện tại.

---

## 5. ♻️ Refactor code (Reviewer + Superpowers)
Nâng cấp code cũ lên chuẩn mới.

**Kịch bản**: File `auth.service.ts` quá dài và rối rắm.

- **Câu lệnh**: `@reviewer dùng superpowers refactor file này theo nguyên tắc SOLID và Clean Code. Nhớ dùng context7 check xem có pattern nào mới cho Auth trong Next.js không.`
- **Kết quả**: AI sẽ phân tách các class, áp dụng Dependency Injection và cập nhật các thư viện auth mới nhất.

---

## 6. 🛡️ Kiểm tra bảo mật (Security Audit)
**Kịch bản**: Bạn vừa viết xong module xử lý File Upload và muốn đảm bảo nó an toàn.
- **Câu lệnh**: `@security-expert dùng superpowers security kiểm tra module upload file này. Đặc biệt chú ý đến Path Traversal và SQL Injection.`
- **Kết quả**: AI sẽ dùng "siêu năng lực" bảo mật để quét qua code và cảnh báo các lỗ hổng tiềm ẩn.

---

## 7. ⚡ Tối ưu hiệu năng (Performance Optimization)
**Kịch bản**: Hàm xử lý dữ liệu lớn đang chạy chậm.
- **Câu lệnh**: `@performance-expert dùng superpowers optimize hàm xử lý dữ liệu này để tăng tốc độ thực thi.`
- **Kết quả**: AI sẽ áp dụng các kỹ thuật như caching, parallel processing (worker threads) hoặc tối ưu thuật toán.

---

## 8. 📅 Lập kế hoạch phức tạp (Task Planning)
**Kịch bản**: Bạn cần xây dựng một hệ thống Notifications (Email, Push, SMS).
- **Câu lệnh**: `@system-architect dùng superpowers plan thiết kế và lập kế hoạch triển khai hệ thống thông báo đa kênh.`
- **Kết quả**: AI sẽ phác thảo kiến trúc và chia nhỏ các giai đoạn thực hiện (Phase 1, 2, 3...) kèm theo các bước chi tiết.
