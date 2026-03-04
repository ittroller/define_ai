# 🧩 Module Context (Ngữ cảnh cục bộ) - [Tên Module]

> **HƯỚNG DẪN**: Hãy copy file này vào từng thư mục module lớn (như `src/api`, `src/ui`) và đổi tên thành `CLAUDE.md` hoặc `.ai-context.md`. Điều này giúp AI hiểu sâu hơn về module đó.

## 🎯 Mục tiêu Module
(Ví dụ: Module này quản lý xác thực người dùng và phân quyền RBAC).

## 📂 Cấu trúc quan trọng
- `/services`: Chứa logic xử lý nghiệp vụ.
- `/controllers`: Chứa logic điều phối API.
- `/schemas`: Chứa các Zod schemas cho validation.

## 📜 Quy định đặc thù
- Luôn sử dụng `async/await`.
- Tất cả các lỗi phải được trả về qua `AppError` class.
- (Thêm các quy định riêng cho module này...)

## 🧪 Cách chạy Test module này
```bash
npm test [đường dẫn tới thư mục này]
```

---
*File này giúp AI không bị "loãng" context khi làm việc trong các thư mục lớn.*
