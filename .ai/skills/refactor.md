# 🔄 Skill: Refactor & Optimize (Cải thiện mã nguồn)

## 🎯 Mục tiêu
Nâng cao tính dễ đọc, bảo trì và hiệu năng mà không thay đổi hành vi (behavior) của hệ thống.

## 💬 Cách triệu hồi (Prompt)
- "@refactor hãy tối ưu lại hàm này cho ngắn gọn và dễ hiểu hơn."
- "Tìm các code smells trong folder này và đề xuất hướng refactor (@refactor.md)."

## 📝 Quy trình
1.  **Xác định Code Smell**: (Duplicate code, Long functions, Magic numbers, Deep nesting...).
2.  **Đánh giá rủi ro**: Kiểm tra xem file hiện tại đã có bộ test nào chưa. Nếu chưa, hãy tạo test trước.
3.  **Áp dụng Clean Code**:
    -   Tên biến/hàm tường minh (Expressive names).
    -   Single Responsibility (Mỗi hàm chỉ làm một việc).
    -   Tách logic phức tạp thành các hàm nhỏ.
4.  **Tối ưu hiệu năng**:
    -   Giảm bớt các vòng lặp thừa.
    -   Caching kết quả tính toán nếu cần.
    -   Lazy loading/Batching data.

## ⚠️ Lưu ý
-   Luôn thực hiện refactor từng bước nhỏ (Incremental changes).
-   Sau mỗi bước, hãy đảm bảo hệ thống vẫn chạy ổn định (kiểm tra qua tests hoặc linter).
