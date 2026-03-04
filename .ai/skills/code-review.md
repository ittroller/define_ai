# 🛠️ Skill: Review Code (Kiểm duyệt mã nguồn)

## 🎯 Mục tiêu
Đảm bảo chất lượng code, tuân thủ quy chuẩn dự án và phát hiện lỗi logic/bảo mật sớm.

## 💬 Cách triệu hồi (Prompt)
- "@reviewer hãy review file này giúp tôi, đối chiếu với quy chuẩn coding-standards."
- "Kiểm tra bảo mật và logic cho module auth này (@code-review.md)."

## 📝 Quy trình
1.  **Phân tích thay đổi**: Đọc toàn bộ diff của các file liên quan.
2.  **Kiểm tra Quy chuẩn**: Đối chiếu với `.ai/specifications/coding-standards.md`.
3.  **Kiểm tra Logic**: Đảm bảo không có lỗi logic, xử lý ngoại lệ (error handling) đầy đủ.
4.  **Tối ưu**: Đề xuất cách viết ngắn gọn hơn hoặc hiệu năng cao hơn nếu có.
5.  **Bảo mật**: Kiểm tra các lỗ hổng phổ biến (SQL injection, XSS, Hardcoded secrets...).

## 📤 Output mẫu
- **Điểm tốt**: (Ghi nhận những gì đã làm tốt)
- **Cần cải thiện**: (Liệt kê các điểm cần sửa kèm lý do và đoạn code gợi ý)
- **Câu hỏi**: (Đặt câu hỏi nếu có phần logic chưa rõ ràng)
- **Kết luận**: (Đạt/Không đạt/Đạt sau khi sửa)
