# 🗄️ Database Schema: User & Auth Tables

## 🏗️ Bảng: `users`
- `id`: Int @id @default(autoincrement())
- `email`: String @unique
- `password`: String
- `fullName`: String?
- `role`: Role @default(USER)
- `createdAt`: DateTime @default(now())
- `updatedAt`: DateTime @updatedAt

## 🏗️ Bảng: `sessions` (Tùy chọn)
- `id`: String @id @default(uuid())
- `userId`: Int
- `refreshToken`: String @unique
- `expiredAt`: DateTime
- `userAgent`: String?
- `ip`: String?

## 🧩 Enums
- `Role`: { ADMIN, USER, MODERATOR }

---
*Dựa trên thiết kế của @database-expert.md*
