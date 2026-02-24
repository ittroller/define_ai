# Architecture Decision Records (ADR)

Tài liệu này ghi lại các quyết định kiến trúc quan trọng trong dự án để AI và Team có thể hiểu lý do đằng sau các lựa chọn kỹ thuật.

## ADR 001: Sử dụng Next.js App Router
- **Ngày**: 2026-01-29
- **Trạng thái**: Đã quyết định
- **Bối cảnh**: Cần một framework React mạnh mẽ hỗ trợ Server Components để tối ưu hiệu năng.
- **Quyết định**: Sử dụng Next.js App Router thay vì Pages Router.
- **Hệ quả**: Cần quản lý Client/Server components cẩn thận.

## ADR 002: Tích hợp Clerk cho Authentication
- **Ngày**: 2026-01-29
- **Trạng thái**: Đã quyết định
- **Bối cảnh**: Cần giải pháp xác thực nhanh, bảo mật và hỗ trợ tốt cho Next.js.
- **Quyết định**: Sử dụng Clerk thay vì tự xây dựng hệ thống xác thực.
- **Hệ quả**: Phụ thuộc vào service bên thứ ba, nhưng tiết kiệm thời gian phát triển.
