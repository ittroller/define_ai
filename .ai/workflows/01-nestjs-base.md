# 🏗️ Workflow: Khởi tạo Base NestJS (Clean Architecture & DDD)

Mục tiêu: Tạo một dự án NestJS sạch, áp dụng Clean Architecture và Domain-Driven Design (DDD), có cấu trúc module hóa, dễ dàng mở rộng và bảo trì theo các pattern nổi trội toàn cầu.

---

## 🚀 Bước 1: Khởi tạo Project bằng Nest CLI

Chạy lệnh sau để tạo project:

```bash
nest new <tên-dự-án> --package-manager npm
```

## 📂 Bước 2: Cấu trúc Thư mục Domain-centric (Domain-driven Structure)

Sau khi khởi tạo, hãy tổ chức lại thư mục `src` theo chuẩn "Folder-by-Purpose" và "Domain-centric" (DDD) để đảm bảo tính tái sử dụng và dễ dàng nâng cấp:

```text
src/
├── common/              # Global utilities, filters, interceptors, decorators, constants
├── shared/              # Shared infrastructure modules (Mailer, Logger, Database setup)
├── config/              # Configuration management (Env vars)
├── database/            # Global database connection, migrations, seeds
├── domains/             # Core business logic (Entities, Value Objects, Domain Services) - DDD
├── modules/             # Feature modules (Controllers, Application Services, Repositories)
│   ├── auth/
│   ├── users/
│   └── ...
├── app.module.ts
└── main.ts
```

## 🛠️ Bước 3: Thiết lập Cơ bản (Global Standards)

1.  **ConfigModule**: Cài đặt `@nestjs/config` và thiết lập trong `AppModule`.
2.  **Validation**: Thiết lập `ValidationPipe` toàn cục trong `main.ts` với `whitelist: true`.
3.  **Swagger**: Thiết lập tài liệu API tự động tại `/api-docs`.
4.  **Error Handling**: Triển khai `GlobalExceptionFilter` để chuẩn hóa response lỗi.
5.  **Logging**: Sử dụng Winston/Pino cho Structured Logging.
6.  **CQRS (Optional)**: Cài đặt `@nestjs/cqrs` nếu dự án có quy mô lớn và logic phức tạp.

## 📈 Bước 4: Nguyên tắc Mở rộng & Design Patterns

- **SOLID & Clean Code**: Áp dụng triệt để nguyên lý SOLID trong mọi thành phần.
- **Repository Pattern**: Sử dụng repositories để tách biệt tầng truy cập dữ liệu (Data Access) và nghiệp vụ (Business Logic).
- **Module-based**: Mỗi domain nghiệp vụ phải nằm trong một module riêng biệt.
- **DTOs & Entities**: Phân tách rõ ràng giữa Data Transfer Objects (vận chuyển) và Entities (nghiệp vụ).
- **Dependency Injection**: Tận dụng tối đa DI của NestJS để đạt được Loose Coupling.

---

**AI Agent Note**: Hãy luôn bám sát NestJS Best Practices và đảm bảo tính nhất quán trong cách đặt tên (kebab-case cho files).
