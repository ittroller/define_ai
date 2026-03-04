# ⚙️ Runbook Example: Local Setup Guide

## 🎯 Mục tiêu
Hướng dẫn lập trình viên mới cài đặt môi trường và chạy dự án lần đầu tiên.

## 🛠️ Yêu cầu hệ thống (Prerequisites)
- **Node.js**: v18.x trở lên.
- **Docker**: Cho PostgreSQL (nếu không cài trực tiếp).
- **Package Manager**: `npm` hoặc `pnpm`.

## 📝 Các bước thực hiện

### 1. Clone & Install Dependencies
```bash
git clone [repository-url]
cd [project-folder]
npm install
```

### 2. Cấu hình môi trường (.env)
Copy file `.env.example` thành `.env` và cập nhật các tham số sau:
- `DATABASE_URL`: Đường dẫn tới DB.
- `JWT_SECRET`: Khóa bí mật cho session.

### 3. Khởi tạo Database
```bash
npx prisma migrate dev
npx prisma db seed
```

### 4. Chạy ứng dụng
```bash
npm run dev
```
Truy cập: `http://localhost:3000`

## 🧪 Chạy Tests
```bash
npm test
```

---
*Ví dụ này giúp AI hiểu quy trình chạy dự án để hỗ trợ fix lỗi setup.*
