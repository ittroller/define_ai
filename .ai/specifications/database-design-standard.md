# 🗄️ Specification: Thiết kế Cơ sở dữ liệu (Database Design)

## 🎯 Nguyên tắc chung
Đảm bảo tính toàn vẹn của dữ liệu (Integrity), hiệu năng truy vấn (Performance) và khả năng mở rộng (Scalability).

## 📐 Quy tắc đặt tên (Naming Conventions)
1.  **Bảng (Tables)**:
    - Sử dụng danh từ số nhiều (e.g., `users`, `products`).
    - Sử dụng `snake_case`.
2.  **Cột (Columns)**:
    - Sử dụng `snake_case` (e.g., `first_name`).
    - Khóa chính luôn là `id` (UUID hoặc BigInt).
    - Khóa ngoại: `<table_singular>_id` (e.g., `user_id`).
3.  **Audit Columns**: Luôn có `created_at` và `updated_at`.

## 📦 Thiết kế quan hệ
1.  **Normalization**: Ưu tiên 3NF để tránh dư thừa dữ liệu.
2.  **Indexes**: Đánh index cho các cột thường xuyên tìm kiếm hoặc dùng để JOIN.
3.  **Soft Delete**: Sử dụng cột `deleted_at` thay vì xóa vật lý dữ liệu quan trọng.

## ⚙️ Các quy chuẩn thực thi (Prisma / SQL)
- Khi dùng Prisma, hãy đảm bảo các `@relation` được định nghĩa rõ ràng.
- Sử dụng Enums cho các cột có giá trị cố định (e.g., `Role`, `Status`).
- Luôn mô tả các bảng và cột bằng comments.
