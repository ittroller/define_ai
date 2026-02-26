# QA Testing Strategy (Template)

Tài liệu này định nghĩa cách thức đảm bảo chất lượng cho dự án. Hỗ trợ cho **QA Tester Agent**.

## 1. Testing Pyramid
- **Unit Tests**: [Mục tiêu coverage, ví dụ: 80%]
- **Integration Tests**: [Tập trung vào API và DB]
- **E2E Tests**: [Các luồng nghiệp vụ chính]

## 2. Quy trình Test
- **Regression**: Chạy lại bộ test sau mỗi lần Merge.
- **Manual**: Các kịch bản test giao diện phức tạp.

## 3. Quản lý lỗi (Bugs)
- Cách báo cáo lỗi (Format: Steps to Reproduce, Expected, Actual).
- Mức độ ưu tiên (Low, Medium, High, Critical).

---
*Ghi chú cho AI: Trước khi submit code, hãy tự động đề xuất một danh sách các Unit Test cần viết cho logic đó.*
