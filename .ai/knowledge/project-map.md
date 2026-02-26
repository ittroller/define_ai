# Project Map (Template)

Tài liệu này cung cấp cái nhìn tổng quan về cấu trúc thư mục của dự án thực tế. **[Vui lòng yêu cầu AI cập nhật lại file này ngay sau khi cài đặt]**.

## 1. Cấu trúc thư mục chuẩn (Tham khảo)

Dưới đây là sơ đồ cấu trúc mẫu cho một dự án đa nền tảng (Frontend, Backend, Mobile):

```text
.
├── .ai/                    # Thư mục cấu hình AI (Giữ nguyên)
├── src/                    # Mã nguồn chính
│   ├── modules/            # Logic nghiệp vụ (Domain-driven)
│   ├── common/             # Các thành phần dùng chung (Guards, Utils, Decorators)
│   ├── components/         # UI Components (Frontend/Mobile)
│   ├── database/           # Schema, Migrations, Seeds
│   └── main.ts             # Entry point của ứng dụng
├── tests/                  # Thư mục chứa các bản test (Unit, E2E)
├── config/                 # Các file cấu hình hệ thống
├── infrastructure/         # Scripts liên quan đến Docker, K8s, CI/CD
├── .env.example            # Mẫu file biến môi trường
├── package.json            # Quản lý dependencies (Node)
├── go.mod                  # Quản lý dependencies (Go)
└── README.md               # Tài liệu dự án
```

---
*Ghi chú cho AI: Hãy tự động cập nhật sơ đồ cây thư mục thực tế của dự án này vào đây bằng lệnh `tree` hoặc tương đương.*
