# 🏗️ Workflow: Khởi tạo Base NestJS (Clean Architecture)

Mục tiêu: Tạo một dự án NestJS sạch, có cấu trúc module hóa, dễ dàng mở rộng và bảo trì.

---

## 🚀 Bước 1: Khởi tạo Project bằng Nest CLI

Chạy lệnh sau để tạo project (AI có thể yêu cầu user thực hiện hoặc tự thực hiện nếu có quyền):

```bash
nest new <tên-dự-án> --package-manager npm
```

## 📂 Bước 2: Cấu trúc Thư mục Đề xuất

Sau khi khởi tạo, hãy tổ chức lại thư mục `src` như sau:

```text
src/
├── common/              # Các utilities, filters, interceptors dùng chung
│   ├── decorators/
│   ├── filters/
│   ├── guards/
│   ├── interceptors/
│   └── pipes/
├── config/              # Cấu hình hệ thống (Environment variables)
├── database/            # Cấu hình DB, migrations, seeds
├── modules/             # Chứa các Module nghiệp vụ (Core logic)
│   ├── auth/
│   ├── users/
│   └── ...
├── app.module.ts
└── main.ts
```

## 🛠️ Bước 3: Thiết lập Cơ bản

1.  **ConfigModule**: Cài đặt `@nestjs/config` và thiết lập trong `AppModule`.
2.  **Validation**: Thiết lập `ValidationPipe` toàn cục trong `main.ts`.
3.  **Swagger**: Thiết lập tài liệu API tự động.

## 📈 Bước 4: Nguyên tắc Mở rộng

- **Module-based**: Mỗi tính năng mới phải nằm trong một module riêng biệt trong thư mục `modules/`.
- **DTOs**: Sử dụng `class-validator` cho tất cả dữ liệu đầu vào.
- **Entities**: Định nghĩa rõ ràng các entities/models.
- **Interfaces**: Sử dụng interfaces cho các services để dễ dàng unit test.

---

**AI Agent Note**: Hãy luôn bám sát NestJS Best Practices và đảm bảo tính nhất quán trong cách đặt tên (kebab-case cho files).
