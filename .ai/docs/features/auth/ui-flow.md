# 🎨 UI Flow & Screens: Authentication Feature

## 1. Màn hình Đăng ký (Register Screen)
- **Fields**:
    - `Email` (Required, Format email)
    - `Password` (Required, Min 8 characters, Strong password)
    - `Full Name` (Optional)
- **Actions**:
    - Nút "Đăng ký": Gửi yêu cầu tới `/api/v1/auth/register`.
    - Liên kết "Đã có tài khoản? Đăng nhập ngay".
- **States**:
    - Loading, Error (User already exists), Success (Redirect to Login or Home).

## 2. Màn hình Đăng nhập (Login Screen)
- **Fields**:
    - `Email`
    - `Password`
- **Actions**:
    - Nút "Đăng nhập": Gửi yêu cầu tới `/api/v1/auth/login`.
    - Liên kết "Quên mật khẩu?".
- **States**:
    - Loading, Error (Invalid credentials), Success (Store JWT & Redirect).

## 3. Màn hình Quên mật khẩu (Forgot Password)
- **Fields**: `Email`
- **Actions**: Nút "Gửi yêu cầu reset": Gửi yêu cầu tới `/api/v1/auth/forgot-password`.
- **States**: Success message "Check your email for instructions".

---
*Dựa trên phân tích của @ui-analyst.md*
