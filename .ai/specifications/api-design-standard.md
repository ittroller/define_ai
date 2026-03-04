# 🛣️ Specification: Thiết kế API (REST/GraphQL)

## 🎯 Nguyên tắc chung
Đảm bảo API được thiết kế theo chuẩn, dễ hiểu, bảo mật và hiệu năng cao.

## 📐 Quy chuẩn RESTful API
1.  **Endpoints**: Sử dụng danh từ số nhiều (e.g., `/users`, `/orders`).
2.  **Phương thức**:
    - `GET`: Lấy dữ liệu (Read-only).
    - `POST`: Tạo mới.
    - `PUT`: Cập nhật toàn bộ.
    - `PATCH`: Cập nhật một phần.
    - `DELETE`: Xóa.
3.  **Versioning**: Luôn có version trong URL (e.g., `/api/v1/...`).
4.  **Naming**: Sử dụng `kebab-case` cho URL.

## 📦 Request & Response
1.  **Status Codes**:
    - `200 OK`, `201 Created`.
    - `400 Bad Request`, `401 Unauthorized`, `403 Forbidden`, `404 Not Found`.
    - `500 Internal Server Error`.
2.  **Data Format**: Luôn trả về JSON object.
3.  **Pagination**: Sử dụng `limit` và `offset` hoặc cursor-based cho danh sách lớn.

## 🛡️ Bảo mật
- Luôn kiểm tra quyền truy cập (ACL/RBAC).
- Không trả về các thông tin nhạy cảm (Password hash, v.v.).
- Sử dụng Rate Limiting.
