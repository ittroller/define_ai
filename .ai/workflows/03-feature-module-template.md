# 📦 Workflow: Create Standard Feature Module (NestJS)

Mục tiêu: Tạo một Feature Module hoàn chỉnh tuân thủ các quy chuẩn thiết kế (Module design, DTO naming, Provider scope).

---

## 🏗️ Bước 1: Cấu trúc Thư mục chuẩn (Domain-centric / DDD)
Tạo thư mục cho module mới trong `src/modules/<module-name>`. Ưu tiên phân tách các tầng theo kiến trúc Hexagonal hoặc Clean Architecture:

```text
src/modules/<module-name>/
├── controllers/          # Nhận Request & Trả Response (Adapter)
│   └── <module-name>.controller.ts
├── services/             # Application Services (Điều phối nghiệp vụ)
│   └── <module-name>.service.ts
├── repositories/         # Tầng truy xuất dữ liệu (Data Access Layer)
│   └── <module-name>.repository.ts
├── dto/                  # Data Transfer Objects
├── entities/             # Database Entities
├── domains/              # Core Domain logic (nếu module phức tạp)
└── <module-name>.module.ts
```

## 🧩 Bước 2: Module Design & SOLID Patterns

### Repository Pattern
Tách biệt logic truy vấn DB khỏi Service để dễ dàng thay đổi ORM hoặc unit test.
```typescript
@Injectable()
export class UsersRepository {
  constructor(private prisma: PrismaService) {}
  // Logic truy vấn DB nằm ở đây
}
```

### Dependency Inversion (SOLID)
Sử dụng Interface cho Service/Repository để giảm sự phụ thuộc trực tiếp.

## 💉 Bước 3: Provider Scopes & Design Patterns
- **Strategy Pattern**: Dùng để xử lý nhiều loại logic khác nhau (e.g., nhiều phương thức thanh toán).
- **Factory Pattern**: Dùng để khởi tạo các đối tượng phức tạp.
- **Provider Scopes**: 
    - **Singleton**: Mặc định.
    - **Request**: Dùng cho multi-tenancy.

**Lưu ý**: Kiểm tra Dependency Graph để tránh Circular Dependency bằng cách sử dụng `forwardRef()`.

## 📜 Bước 4: DTO & Validation Rule
- File name: `kebab-case`.
- Class name: `PascalCase` + `Dto`.
- Sử dụng `class-validator` và `swagger` decorators.

```typescript
export class CreateUserDto {
  @ApiProperty()
  @IsString()
  @MinLength(3)
  username: string;
}
```

## 🛡️ Bước 5: Error Handling & Transaction Pattern
- Ném lỗi sử dụng các built-in exceptions: `BadRequestException`, `NotFoundException`, v.v. hoặc `CustomException`.
- Sử dụng Transaction khi thực hiện nhiều thao tác ghi vào DB.

```typescript
// Transaction Example (Prisma)
async createOrder(data: any) {
  return this.prisma.$transaction(async (tx) => {
    const order = await tx.order.create({ data });
    await tx.inventory.update({ ... });
    return order;
  });
}
```

---

**AI Agent Note**: Luôn sử dụng `nest generate` (nếu có thể) để tạo khung, sau đó tổ chức lại theo folder structure chuẩn trên.
