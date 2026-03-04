# 🧪 Skill: Testing (Kiểm thử phần mềm)

## 🎯 Mục tiêu
Viết test hiệu quả, độ bao phủ (coverage) cao và đảm bảo không có lỗi hồi quy (regression).

## 💬 Cách triệu hồi (Prompt)
- "@tester viết unit test cho file service này, chú ý các edge cases."
- "Tạo E2E test cho luồng checkout của người dùng (@automated-testing.md)."

## 📝 Quy trình
1.  **Phân tích Test Case**: (Happy paths, Edge cases, Negative cases).
2.  **Chọn loại Test phù hợp**:
    -   Unit Test: Từng hàm đơn lẻ.
    -   Integration Test: Phối hợp giữa các module.
    -   E2E Test: Toàn bộ luồng từ người dùng.
3.  **Mocking/Stubbing**: Giả lập dữ liệu cho DB/API bên ngoài.
4.  **Kiểm tra Coverage**: Mục tiêu 80%+ (nếu dự án yêu cầu).

## ⚠️ Lưu ý
-   Đặt tên test case rõ ràng (theo dạng: `should [expected result] when [condition]`).
-   Test phải độc lập, không phụ thuộc vào kết quả của test trước đó.
-   Luôn clean up dữ liệu sau khi chạy test.
