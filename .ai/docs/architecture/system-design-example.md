# 🏰 System Design Example: Clean Architecture

## 🏢 Tổng quan
Dự án này áp dụng Clean Architecture để phân tách rõ ràng giữa Business Logic và Framework-dependent code.

## ⚙️ Các lớp kiến trúc (Layers)

### 1. Entities (Enterprise Business Rules)
- **Vị trí**: `src/domain/entities`
- **Nội dung**: Các class/interface đại diện cho thực thể nghiệp vụ (User, Order...). Không phụ thuộc vào bất kỳ thư viện nào.

### 2. Use Cases (Application Business Rules)
- **Vị trí**: `src/application/use-cases`
- **Nội dung**: Chứa logic luồng công việc. Nhận request, phối hợp các Entities và gọi Interface.

### 3. Interface Adapters
- **Controllers**: `src/interfaces/controllers` (Express/NestJS).
- **Repositories**: `src/infrastructure/repositories` (Thực thi truy vấn DB).

### 4. Frameworks & Drivers
- **Database**: PostgreSQL (Prisma).
- **Web Framework**: Next.js.

## 🔄 Luồng dữ liệu (Data Flow)
`Request -> Controller -> Use Case -> Entity -> Repository -> Response`

---
*Ví dụ này giúp AI hiểu cấu trúc phân lớp để khi tạo file mới sẽ đặt đúng folder.*
