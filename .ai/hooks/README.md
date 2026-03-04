# 🪝 AI Hooks & Guardrails (Kiểm soát tự động)

## 📌 Khái niệm
Hooks là các script hoặc quy trình tự động chạy trước (Pre) hoặc sau (Post) khi AI thực hiện một hành động.
Guardrails là các rào cản ngăn AI thực hiện các hành động nguy hiểm hoặc sai quy chuẩn.

## 📝 Các ví dụ phổ biến
- **Pre-commit Linter**: Chạy `npm run lint` sau khi AI sửa code để đảm bảo style đúng.
- **Unit Test Guard**: Yêu cầu AI chạy `npm test` trước khi hoàn tất task.
- **Security Scanner**: Quét code mới bằng tool bảo mật (Snyk/SonarQube) sau khi AI commit.

## ⚙️ Cách cấu hình (Gợi ý)
Người dùng có thể tạo các script trong thư mục này và hướng dẫn AI:
"Trước khi hoàn thành bất kỳ task nào, hãy chạy script `.ai/hooks/pre-finish-check.sh`."

---
*Thư mục này dùng để chứa các script kiểm tra tự động cho dự án của bạn.*
