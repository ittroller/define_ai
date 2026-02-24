# Coding Standards

Quy chuẩn viết code cho dự án nhằm đảm bảo tính đồng nhất và chất lượng mã nguồn.

## 1. Nguyên tắc chung
- Viết code sạch (Clean Code), dễ đọc, dễ hiểu.
- Ưu tiên sự rõ ràng hơn là sự ngắn gọn.
- Tuân thủ TypeScript Strict Mode.

## 2. Frontend (React / Vue / Next.js / Nuxt.js)
- **Framework-specific**: 
    - **React**: Sử dụng Functional Components và Hooks. Ưu tiên Server Components nếu dùng Next.js.
    - **Vue**: Sử dụng Composition API với `<script setup>`.
- **Naming**: PascalCase cho Component file và folder. kebab-case cho các file không phải component.
- **Styling**: Sử dụng Tailwind CSS là chính. Hạn chế sử dụng inline style.
- **Props**: Luôn định nghĩa Interface/Type cho Props.

## 3. Backend (Node.js & NestJS)
- **Architecture**: 
    - **NestJS**: Tuân thủ Controller-Service-Module pattern. Sử dụng Dependency Injection triệt để.
    - **General Node.js**: Tuân thủ Controller-Service-Repository pattern hoặc Clean Architecture.
- **Next.js (Secondary)**: Sử dụng Server Actions/API Routes cho các logic gắn liền với UI hoặc quy mô nhỏ. Phải có error handling rõ ràng và validation ở đầu function.
- **Validation**: Sử dụng Zod hoặc class-validator cho DTO/Schemas.
- **Type-safety**: Tận dụng tối đa infer type từ Prisma/Zod/Drizzle, hạn chế dùng `any`.
- **Error Handling**: Sử dụng Exception Filters (NestJS) hoặc Wrapper functions (Next.js) để thống nhất cấu trúc lỗi.
- **Async Code**: Luôn sử dụng `async/await` thay vì `.then()/.catch()` truyền thống.

## 4. Git Convention
- **Commit Message**: Tuân thủ [Conventional Commits](https://www.conventionalcommits.org/).
    - `feat:`: Tính năng mới.
    - `fix:`: Sửa lỗi.
    - `docs:`: Thay đổi tài liệu.
    - `style:`: Thay đổi format code (không thay đổi logic).
    - `refactor:`: Tái cấu trúc code.
