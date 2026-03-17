# ⚡ Superpowers AI Framework

Đây là bộ khung "Siêu năng lực" tích hợp cho AI Agent của bạn, lấy cảm hứng từ `superpowers-ai` và giao thức MCP (Model Context Protocol).

## 🚀 Các Siêu năng lực hiện có

1.  **Context7 (Upstash)**: Tra cứu tài liệu và tìm kiếm giải pháp thực tế theo thời gian thực (MCP Server).
2.  **Superpowers MCP**: Thư viện kỹ năng thực thi chuẩn hóa (MCP Server). Các keyword (Tool names) chính bao gồm:
    -   `tdd`: Quy trình phát triển hướng kiểm thử tự động (Test-Driven Development).
    -   `advanced-debug` / `debug`: Phân tích và xử lý lỗi sâu qua 5 bước.
    -   `refactor`: Cải thiện cấu trúc mã nguồn theo chuẩn Clean Code/SOLID.
    -   `review`: Rà soát chất lượng code, tìm lỗi tiềm ẩn và logic.
    -   `doc`: Tự động viết hoặc cập nhật tài liệu kỹ thuật (README, API, JSDoc).
    -   `plan`: Lập kế hoạch thực hiện các tác vụ phức tạp theo từng giai đoạn.
    -   `optimize`: Tối ưu hóa hiệu năng và tài nguyên hệ thống.
    -   `security`: Kiểm tra các lỗ hổng bảo mật phổ biến (OWASP).
    -   `best-practices`: Kiểm tra sự tuân thủ các quy chuẩn phát triển tốt nhất.
    -   `collaborate`: Phối hợp đa Agent hoặc giữa người và máy cho các task lớn.
3.  **Project Context Awareness**: Tự động nhận diện cấu trúc và nghiệp vụ dự án qua thư mục `.ai/` (File-based Instructions).

## 💡 Sự khác biệt

| Đặc điểm | Context7 | Superpowers MCP |
| :--- | :--- | :--- |
| **Vai trò** | Thư viện tri thức (Knowledge) | Bộ kỹ năng thực thi (Skills) |
| **Nhiệm vụ chính** | Tra cứu Docs, tìm kiếm Best Practices | Chạy test, debug lỗi, viết code chuẩn |
| **Ví dụ câu lệnh** | "Tìm doc của Prisma bản mới nhất" | "Chạy quy trình TDD cho hàm đăng ký" |

Bạn có thể thêm các "Siêu năng lực" mới vào file `.ai/mcp/mcp.json` theo định dạng của MCP Server.

Ví dụ thêm Google Search:
```json
"google-search": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-google-search"]
}
```

## 📖 Hướng dẫn sử dụng cho Agent

Agent có thể truy cập các siêu năng lực này thông qua:
1.  **Tool Calling (Auto)**: AI sẽ tự động kích hoạt Context7 hoặc Superpowers MCP khi đang đóng vai Agent (@) hoặc chạy Workflow (/) nếu nhiệm vụ yêu cầu.
2.  **Instruction Files**: Các file hướng dẫn tại `.ai/skills/` và `.ai/superpowers/` quy định cách thức phối hợp.
