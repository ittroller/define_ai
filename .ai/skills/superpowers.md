# ⚡ Skill: Superpowers (Siêu năng lực AI)

## 🎯 Mục tiêu
Kích hoạt các công cụ và kỹ năng mở rộng (MCP tools) để hỗ trợ các tác vụ phức tạp ngoài khả năng suy luận cơ bản của LLM.

## 💬 Cách triệu hồi (Prompt)
- "@superpowers hãy tìm tài liệu mới nhất về [thư viện] cho tôi."
- "Sử dụng superpowers-mcp để debug lỗi này một cách bài bản."
- "Triệu hồi kỹ năng TDD từ superpowers để viết module mới này."

## 🚀 Các công cụ sẵn có (MCP Servers)
1.  **Context7**: Tìm kiếm tài liệu, thư viện và ví dụ thực tế.
2.  **Superpowers MCP**: Thư viện chuẩn hóa về workflow (TDD, Debugging, v.v.).

## 📝 Quy trình sử dụng
1.  **Xác định nhu cầu**: Bạn có cần thông tin từ bên ngoài (search) hay cần một quy trình chuẩn (workflow) không?
2.  **Lựa chọn Tool**: Chọn server MCP phù hợp trong cấu hình `.ai/mcp/mcp.json`.
3.  **Thực thi & Kiểm chứng**: Gọi tool, lấy kết quả và kiểm tra tính chính xác.

## ⚠️ Lưu ý
-   Luôn ưu tiên các "siêu năng lực" để lấy dữ liệu thực tế thay vì tự suy đoán (hallucination).
-   Sử dụng TDD workflow cho các module core để đảm bảo tính ổn định.
-   Khi dùng `context7`, hãy cung cấp tên thư viện hoặc vấn đề cụ thể nhất có thể.
