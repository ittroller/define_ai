# Workflow: Khởi tạo Source Base Dự án

Workflow này mô tả các bước để bắt đầu một dự án mới từ con số 0, đảm bảo cấu trúc chuẩn và tối ưu ngay từ đầu.

## Các giai đoạn thực hiện

### 1. Phân tích & Lập kế hoạch (Agent: UI Analyst)
- **Nhiệm vụ**: Xác định yêu cầu, chọn Tech Stack (Next.js/NestJS), và định nghĩa Design System sơ bộ.
- **Quy trình bắt buộc**: Lập kế hoạch thực hiện chi tiết (Plan) và trình người dùng review. BẮT BUỘC phải được người dùng đồng ý mới được thực hiện các bước tiếp theo.
- **Công cụ**: `context7` để tìm template dự án phù hợp.
- **Output**: File `architecture-decision.md` mô tả các công nghệ sẽ dùng.

### 2. Thiết lập Cấu trúc Thư mục (Agent: Backend Dev & Frontend Dev)
- **Nhiệm vụ**: 
    - Khởi tạo project (e.g., `npx create-next-app` hoặc `nest new`).
    - Cấu hình ESLint, Prettier, TypeScript.
    - Thiết lập folder structure (Atomic Design cho FE, Clean Architecture cho BE).
- **Output**: Base source code có thể chạy được (Hello World).

### 3. Cấu hình Hạ tầng & Database (Agent: Backend Dev)
- **Nhiệm vụ**:
    - Cấu hình Docker Compose (DB, Redis).
    - Khởi tạo ORM (Prisma/TypeORM).
    - Tạo các bảng (tables) cơ bản ban đầu (User, Session).
- **Output**: File `schema.prisma` hoặc các file entity.

### 4. Xây dựng Layout & Theme (Agent: Frontend Dev)
- **Nhiệm vụ**:
    - Cấu hình Tailwind CSS/Theme.
    - Tạo Shared Components (Button, Input, Card).
    - Tạo Layout chung (Navbar, Sidebar, Footer).
- **Output**: Các component UI cơ bản.

### 5. Kiểm tra & Bàn giao (Agent: Reviewer & Tester)
- **Nhiệm vụ**:
    - Review cấu trúc thư mục và Code Quality (Reviewer).
    - Viết và chạy bộ test suite (Tester).
    - Kiểm tra tính nhất quán của code.
    - Chạy thử lệnh build.
- **Output**: Báo cáo Review/Test và xác nhận Project sẵn sàng để phát triển tính năng.

---

## Cách kích hoạt Workflow
Sử dụng lệnh điều phối agents theo thứ tự trên. Mỗi agent sau khi hoàn thành output sẽ bàn giao context cho agent tiếp theo.
