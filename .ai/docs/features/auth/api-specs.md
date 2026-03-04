# 🛣️ API Specifications: Authentication

## 1. Đăng ký (Register)
- **Method**: `POST`
- **Path**: `/api/v1/auth/register`
- **Request Body**:
    - `email`: String (email)
    - `password`: String (min 8 chars)
    - `fullName`: String?
- **Response**: `201 Created`
- **Error**: `400 Bad Request` (Email already exists).

## 2. Đăng nhập (Login)
- **Method**: `POST`
- **Path**: `/api/v1/auth/login`
- **Request Body**:
    - `email`: String
    - `password`: String
- **Response**: `200 OK`
    - `accessToken`: String
    - `refreshToken`: String
    - `user`: UserObject (trừ mật khẩu)
- **Error**: `401 Unauthorized` (Invalid credentials).

## 3. Profile (Me)
- **Method**: `GET`
- **Path**: `/api/v1/auth/me`
- **Header**: `Authorization: Bearer <accessToken>`
- **Response**: `200 OK` (Current User Info).
- **Error**: `401 Unauthorized`.

---
*Dựa trên thiết kế của @api-designer.md*
