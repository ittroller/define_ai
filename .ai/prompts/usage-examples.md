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

- **Cursor**: `Dùng quy trình @[05-feature-dev.md] kết hợp với @[api-designer.md], hãy thiết kế API cho tính năng Đăng ký.`
- **Claude Code CLI**: `Sử dụng workflows/05-feature-dev.md, hãy phân tích UI flow cho module Auth.`
- **VS Code (Copilot)**: `#file:05-feature-dev.md Hãy lập kế hoạch cho tính năng Giỏ hàng.`

---

## 🛠️ 3. Sửa lỗi (Bug Fixing)
**Mục tiêu**: Sử dụng Agent chuyên gia để tìm và sửa bug.

- **Mọi IDE**: `Triệu hồi @[reviewer.md] và @[tester.md], hãy kiểm tra lỗi logic trong file AuthController.ts này.`
- **Windsurf**: `Dựa trên @[04-bug-fixing.md], hãy tìm nguyên nhân lỗi không nhận token ở Header.`

---

## 🎨 4. Sử dụng Ngữ cảnh cục bộ (Local Context)
**Mục tiêu**: AI chỉ tập trung vào module hiện tại.

- **Trong folder module** (ví dụ `src/modules/auth/`): `Đọc @[CLAUDE.md] (hoặc .ai-context.md) trong folder này để nắm quy chuẩn riêng của module Auth trước khi sửa code.`

---

## 🛡️ 5. Chốt chặn an toàn (Guardrails)
**Mục tiêu**: Kiểm tra code trước khi hoàn tất.

- **Mẫu lệnh**: `Trước khi kết thúc task, hãy chạy @[pre-finish-check.sh] (hoặc hooks/) để đảm bảo code không lỗi lint và pass toàn bộ test.`

---

## 💡 Mẹo nhỏ (Pro-tips):
1.  **Luôn dùng `@`**: Nếu IDE của bạn hỗ trợ (Cursor, PearAI, Continue), hãy luôn dùng `@` để trỏ thẳng vào Agent hoặc Workflow bạn muốn.
2.  **Lập kế hoạch trước (Plan first)**: Luôn ra lệnh *"Hãy lập kế hoạch (Plan) và trình tôi duyệt trước khi viết code"* để tránh AI làm sai ý.
3.  **Hỏi Agent**: Nếu không biết dùng Agent nào, hãy hỏi: *"@ai-orchestrator.md hãy phân tích yêu cầu này và chỉ định Agent phù hợp."*
