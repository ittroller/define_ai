# 🐞 Workflow: Bug Fixing (Quy trình Sửa lỗi)

## 🎯 Mục tiêu
Xác định nguyên nhân gốc rễ (Root Cause), sửa lỗi triệt để và đảm bảo không gây ra lỗi phụ (Regression).

## 💬 Cách kích hoạt
"Có một lỗi ở trang Login (@tester.md), hãy thực hiện theo quy trình bug-fixing."

## 📝 Các bước thực hiện (01 -> 05)

### Bước 1: Tái hiện lỗi (Reproduce)
- Agent: `@tester.md`
- Hành động: Viết một test case hoặc script đơn giản để tái hiện lỗi. Ghi lại các bước cụ thể.

### Bước 2: Phân tích Nguyên nhân (Analyze)
- Agent: `@backend-node-dev.md` hoặc `@frontend-dev.md`
- Hành động: Đọc logs, kiểm tra code logic. Tìm file gây lỗi.

### Bước 3: Đề xuất phương án sửa lỗi (Plan)
- Agent: `@ai-orchestrator.md`
- Hành động: Trình người dùng bản kế hoạch sửa lỗi chi tiết. **Phải được người dùng duyệt mới làm tiếp.**

### Bước 4: Thực hiện sửa lỗi (Fix)
- Agent: Chuyên gia tương ứng (Backend/Frontend).
- Hành động: Viết code sửa lỗi. Đảm bảo tuân thủ `@coding-standards.md`.

### Bước 5: Kiểm tra & Đóng task (Verify)
- Agent: `@reviewer.md` & `@tester.md`
- Hành động: Chạy lại test case ở Bước 1. Chạy các `@hooks/` liên quan.

---
*Lưu ý: Luôn kiểm tra xem lỗi này có liên quan đến bảo mật (@security-expert.md) không.*
