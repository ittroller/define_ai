# Coding Standards

Quy chuẩn viết code cho dự án nhằm đảm bảo tính đồng nhất và chất lượng mã nguồn.

## 1. Nguyên tắc chung
- Viết code sạch (Clean Code), dễ đọc, dễ hiểu.
- Cân bằng giữa sự rõ ràng và sự ngắn gọn (Concise but Expressive). Tránh các đoạn code quá dài dòng hoặc lồng nhau phức tạp.
- Tuân thủ TypeScript Strict Mode.

## 2. Các Nguyên lý & Design Patterns Phổ biến (Global Standards)
- **SOLID Principles**: Tuân thủ triệt để (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion).
- **Domain-Driven Design (DDD)**: Ưu tiên tư duy tập trung vào nghiệp vụ (Domain-centric). Phân tách rõ ràng Entities, Value Objects, Aggregates, Repositories và Domain Services.
- **Hexagonal Architecture (Ports and Adapters)**: Tách biệt logic nghiệp vụ khỏi các yếu tố hạ tầng (DB, Web, External Services) để dễ dàng kiểm thử và thay đổi.
- **CQRS (Command Query Responsibility Segregation)**: Tách biệt thao tác đọc và ghi cho các hệ thống có quy mô lớn hoặc yêu cầu hiệu năng cao.
- **Design Patterns (GoF)**: Sử dụng linh hoạt Singleton, Factory, Strategy, Observer, Decorator, Facade, v.v. để giải quyết các vấn đề cấu trúc phổ biến.
- **Atomic Design**: (Dành cho Frontend) Phân chia UI thành Atoms, Molecules, Organisms, Templates, và Pages để tối đa hóa tính tái sử dụng.

## 3. Nguyên tắc Tổ chức & Thiết kế (Organization & Design)
- **Folder-by-Purpose**: Thư mục phải thể hiện rõ chức năng và mục đích. Tránh các thư mục chứa quá nhiều thứ không liên quan.
- **High Reusability**: Luôn ưu tiên thiết kế các module/component có tính tái sử dụng cao. Trích xuất các logic dùng chung vào `common/` hoặc `shared/`.
- **Scalability & Upgradeability**: Cấu trúc module lỏng lẻo (Loose Coupling) để dễ dàng thay thế, nâng cấp các thành phần hoặc thư viện mà không phá vỡ hệ thống.
- **Maintainability**: Code ngắn gọn, súc tích nhưng phải dễ bảo trì. Mỗi hàm/class chỉ nên làm một việc (Single Responsibility).
- **KISS (Keep It Simple, Stupid)**: Không phức tạp hóa vấn đề. Ưu tiên các giải pháp đơn giản nhất mà vẫn đạt được mục tiêu.

## 3. Frontend (React / Vue / Next.js / Nuxt.js)
- **Framework-specific**: 
    - **React**: Sử dụng Functional Components và Hooks. Ưu tiên Server Components nếu dùng Next.js.
    - **Vue**: Sử dụng Composition API với `<script setup>`.
- **Naming**: PascalCase cho Component file và folder. kebab-case cho các file không phải component.
- **Styling**: Sử dụng Tailwind CSS là chính. Hạn chế sử dụng inline style.
- **Props**: Luôn định nghĩa Interface/Type cho Props.

## 3. Backend (Node.js & NestJS)
- **Architecture**: 
    - **NestJS**: Tuân thủ Controller-Service-Module pattern. Sử dụng Dependency Injection triệt để. 
    - **Module Design**: Phân tách rõ ràng giữa Static và Dynamic Modules. Hạn chế dùng Global Modules.
    - **Folder Structure**:
        ```text
        src/
        ├── common/          # Global decorators, filters, interceptors, pipes, utils
        ├── config/          # Configuration management (Environment)
        ├── modules/         # Business logic (Feature modules)
        │   └── <module>/
        │       ├── dto/     # <action>-<resource>.dto.ts (e.g., create-user.dto.ts)
        │       ├── entities/# Database entities/models
        │       ├── controllers/
        │       ├── services/
        │       └── <module>.module.ts
        ├── database/        # Database setup, migrations, seeds
        └── main.ts
        ```
- **Naming Convention**: 
    - **DTOs**: PascalCase cho Class name, kết thúc bằng `Dto`. File name dùng kebab-case: `<action>-<resource>.dto.ts`.
    - **Interfaces**: Bắt đầu bằng chữ `I` (e.g., `IUserService`).
- **Error Handling**: 
    - Sử dụng `CustomException` kế thừa `HttpException`.
    - Phải có `GlobalExceptionFilter` để chuẩn hóa Response lỗi.
- **Logging**:
    - Sử dụng `Logger` của NestJS. Cấu hình định dạng JSON cho Production (Structured Logging).
- **Transaction Management**:
    - Sử dụng `Transaction Interceptor` hoặc `ClsService` để quản lý Transaction xuyên suốt các Service layer mà không bị rò rỉ context.
- **Validation**: Sử dụng `class-validator` với `ValidationPipe` toàn cục.
- **Type-safety**: Tận dụng tối đa infer type từ Prisma/Zod/Drizzle, hạn chế dùng `any`.

## 4. Git Convention
- **Commit Message**: Tuân thủ [Conventional Commits](https://www.conventionalcommits.org/).
    - `feat:`: Tính năng mới.
    - `fix:`: Sửa lỗi.
    - `docs:`: Thay đổi tài liệu.
    - `style:`: Thay đổi format code (không thay đổi logic).
    - `refactor:`: Tái cấu trúc code.
