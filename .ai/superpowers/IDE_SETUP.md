# 🛠️ Hướng dẫn Cài đặt Siêu năng lực (MCP Setup)

Tài liệu này cung cấp cấu hình chi tiết để bạn copy vào các IDE khác nhau.

## 1. Cursor (Khuyên dùng)
Cursor hỗ trợ MCP cực tốt. AI có thể tự động gọi tool ngay trong chat.

**Các bước thực hiện:**
1. Mở **Cursor Settings** (Phím tắt `Cmd + ,` hoặc nhấn vào icon bánh răng ở góc trên bên phải).
2. Chọn tab **Models** -> Cuộn xuống phần **MCP Servers**.
3. Nhấn **+ Add New MCP Server**.
4. Điền cấu hình cho từng server:

### Server: Context7 (Upstash)
- **Name**: `context7`
- **Type**: `command`
- **Command**: `npx -y @upstash/context7-mcp --api-key YOUR_API_KEY` (Thay `YOUR_API_KEY` bằng key từ Upstash).

### Server: Superpowers
- **Name**: `superpowers`
- **Type**: `command`
- **Command**: `npx -y superpowers-mcp`

---

## 2. VS Code (Dùng qua Roo Code / Cline)
VS Code mặc định chưa hỗ trợ MCP trực tiếp, bạn cần cài extension chuyên dụng.

**Các bước (Dùng Roo Code):**
1. Cài đặt extension **Roo Code** (hoặc **Cline**).
2. Mở tab **Roo Code** bên thanh bên trái.
3. Nhấn vào biểu tượng **Settings (Răng cưa)** trong cửa sổ Roo Code.
4. Tìm đến phần **MCP Servers**.
5. Nhấn **Add Server** hoặc chỉnh sửa file config của extension.

**Cấu hình JSON mẫu:**
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp", "--api-key", "YOUR_API_KEY"]
    },
    "superpowers": {
      "command": "npx",
      "args": ["-y", "superpowers-mcp"]
    }
  }
}
```

---

## 3. WebStorm / JetBrains IDEs
Cần cài đặt plugin bên thứ ba để kích hoạt MCP.

**Các bước:**
1. Mở **Settings** (`Cmd + ,`).
2. Vào phần **Plugins** -> Tìm và cài đặt plugin **"MCP Client"** (hoặc plugin tương đương hỗ trợ MCP).
3. Sau khi cài, vào **Settings** -> **Tools** -> **MCP Client**.
4. Nhấn **+** để thêm server mới.
5. Điền thông tin tương tự như phần Cursor (Command và Args).

---

## 4. Xcode
Xcode không hỗ trợ MCP trực tiếp. Bạn nên sử dụng AI Agent thông qua file rules tổng hợp.
**Cách sử dụng**:
1. AI sẽ tự động đọc file `.xcoderules` sau khi bạn chạy lệnh sync.
2. Bạn có thể yêu cầu AI thực hiện các workflow Superpowers (như TDD hoặc Debug) và nó sẽ hướng dẫn bạn thực hiện từng bước thủ công hoặc qua script.

---

## 5. Antigravity / Codex
Các IDE này hỗ trợ cấu hình thư mục rule rất tốt.
**Cách cài đặt MCP**:
1. Mở file cấu hình MCP của IDE (thường nằm trong settings hoặc thư mục `.agent/mcp/` / `.codex/mcp/`).
2. Copy nội dung từ file `.ai/mcp/mcp.json` vào file cấu hình của IDE.

---

## 6. Claude IDE / Desktop
Dành cho bạn nào dùng app Claude trực tiếp trên máy tính hoặc Claude Code CLI.

**Đường dẫn file cấu hình (Desktop):**
- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

**Nội dung file (Copy & Paste):**
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp", "--api-key", "YOUR_API_KEY"]
    },
    "superpowers": {
      "command": "npx",
      "args": ["-y", "superpowers-mcp"]
    }
  }
}
```

---

## 💡 Lưu ý quan trọng:
- **API Key**: Đừng quên thay `YOUR_API_KEY` bằng key thật của bạn từ Upstash (nếu dùng context7).
- **Restart**: Một số IDE cần khởi động lại hoặc nhấn nút "Refresh/Restart MCP Server" để nhận diện tool mới.
- **Yêu cầu AI**: Sau khi cài xong, hãy thử hỏi: *"Bạn có thấy tool context7 và superpowers không? Hãy liệt kê các chức năng của chúng."*
