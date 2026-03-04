# ⚙️ Business Logic: Authentication & Authorization

## 1. Đăng ký (Register)
- Kiểm tra tính duy nhất (Unique) của email.
- **Băm mật khẩu (Hash Password)**: Sử dụng `bcrypt` với ít nhất 10 rounds.
- Tạo một đối tượng `User` với quyền mặc định là `USER`.
- (Tùy chọn): Gửi email kích hoạt.

## 2. Đăng nhập (Login)
- Tìm người dùng dựa trên email.
- So khớp mật khẩu băm.
- **Xác thực qua JWT**:
    - `accessToken`: Hết hạn sau 15-60 phút.
    - `refreshToken`: Hết hạn sau 7-30 ngày.
- Trả về payload bao gồm user info (trừ password) và tokens.

## 3. Quên mật khẩu (Forgot Password)
- Tạo một token reset mật khẩu ngắn hạn (ví dụ 15 phút).
- Gửi email chứa liên kết tới màn hình Reset.
- Sau khi reset, vô hiệu hóa toàn bộ session cũ của người dùng.

---
*Dựa trên đề xuất của @system-architect.md*
