# 💡 Mẫu câu lệnh (Usage Examples) sau khi Sync

Tài liệu này cung cấp các ví dụ thực tế về cách ra lệnh cho AI trong các IDE khác nhau sau khi bạn đã chạy lệnh `sync-to-agent.sh`.

---

## 🚀 1. Khởi tạo phiên làm việc (Session Start)
**Mục tiêu**: Nạp toàn bộ "não bộ" của Framework vào AI ngay khi mở dự án.

- **Mọi IDE**: Mở file `INITIAL_SESSION.md`, copy nội dung và dán vào ô chat.
- **Cursor**: `@[INITIAL_SESSION.md] hãy đọc file này và nạp context.`
- **Claude Code**: `/read INITIAL_SESSION.md` sau đó yêu cầu nó làm theo các bước trong đó.

---

## 🏗️ 2. Phát triển Tính năng mới (New Feature)
**Mục tiêu**: Sử dụng quy trình chuẩn để tạo tính năng.

- **Câu lệnh mẫu**: `Dựa trên @05-feature-dev.md, hãy thiết kế module Auth với JWT theo phong cách NestJS.`
- **Phân tích UI**: `Hãy phân tích UI Figma tại link này [link figma] và triệu hồi @ui-analyst.md để bóc tách các components cần thiết.`
- **Code Backend**: `Triệu hồi @backend-node-dev.md, hãy tạo một API GET /users để lấy danh sách người dùng, sử dụng Prisma.`

---

## 🐞 3. Sửa lỗi & Debug (Bug Fixing & Debugging)
**Mục tiêu**: Sử dụng Agent chuyên gia để tìm và sửa bug.

- **Phân tích lỗi**: `Tôi đang gặp lỗi [mô tả lỗi]. Triệu hồi @reviewer.md hãy phân tích file [tên file] và tìm nguyên nhân.`
- **Theo Workflow**: `Hãy chạy workflow @04-bug-fixing.md để xử lý lỗi crash khi nhấn nút Đăng ký.`
- **Trace log**: `Dựa trên lỗi log này [copy log vào đây], hãy tìm file nào gây ra lỗi và đề xuất cách sửa.`

---

## ♻️ 4. Refactor & Tối ưu (Refactoring & Optimization)
**Mục tiêu**: Nâng cao chất lượng code và hiệu năng.

- **Tối ưu SQL**: `Triệu hồi @performance-expert.md, hãy tối ưu truy vấn SQL trong hàm getOrders này.`
- **Refactor chuẩn**: `Dựa trên @coding-standards.md, hãy refactor file [tên file] để code sạch và dễ bảo trì hơn.`
- **Check SOLID**: `Hãy kiểm tra file [tên file] có vi phạm nguyên tắc SOLID nào không và sửa lại giúp tôi.`

---

## 🧪 5. Viết Test (Testing)
**Mục tiêu**: Đảm bảo code chạy đúng và không bị regression.

- **Unit Test**: `Triệu hồi @tester.md, hãy viết Unit Test cho hàm calculatePrice, đảm bảo độ bao phủ (coverage) 100%.`
- **E2E Test**: `Hãy tạo script E2E test cho luồng thanh toán bằng Playwright dựa trên @docs/flows/checkout.md.`
- **Run Test**: `Hãy chạy test module Auth và báo cáo kết quả cho tôi.`

---

## 📚 6. Viết Tài liệu (Documentation)
**Mục tiêu**: Giúp dự án dễ hiểu và dễ bảo trì.

- **README**: `Hãy viết tài liệu README.md cho module này, bao gồm cách cài đặt và sử dụng.`
- **Project Map**: `Hãy cập nhật file @project-map.md dựa trên cấu trúc thư mục hiện tại.`
- **ADR Summary**: `Hãy tóm tắt lịch sử quyết định trong dự án dựa trên thư mục @memory/adr/.`

---

## 🛡️ 7. Chốt chặn an toàn (Guardrails)
**Mục tiêu**: Kiểm tra code trước khi hoàn tất.

- **Mẫu lệnh**: `Trước khi kết thúc task, hãy chạy @pre-finish-check.sh (hoặc hooks/) để đảm bảo code không lỗi lint và pass toàn bộ test.`

---

## 💡 Mẹo nhỏ (Pro-tips):
1.  **Luôn dùng `@`**: Nếu IDE của bạn hỗ trợ (Cursor, PearAI, Continue, WebStorm), hãy luôn dùng `@` để trỏ thẳng vào Agent hoặc Workflow bạn muốn.
2.  **Lập kế hoạch trước (Plan first)**: Luôn ra lệnh *"Hãy lập kế hoạch (Plan) và trình tôi duyệt trước khi viết code"* để tránh AI làm sai ý.
3.  **Hỏi Agent**: Nếu không biết dùng Agent nào, hãy hỏi: *"@ai-orchestrator.md hãy phân tích yêu cầu này và chỉ định Agent phù hợp."*
