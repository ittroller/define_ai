# 🤖 MinhCK Dot AI - AI Agent Framework

Bộ khung cấu hình AI Agent chuyên nghiệp cho dự án của bạn. Giúp biến AI (GitHub Copilot, Cursor, Roo Code) thành các chuyên gia thực thụ trong dự án.

---

## 🚀 1. Hướng dẫn Cài đặt (Dành cho người dùng)

Để cài đặt bộ khung `.ai` vào dự án mới, bạn chỉ cần mở terminal tại thư mục dự án đó và chạy lệnh:

```bash
npx minhck-dot-ai
```

**Lệnh này sẽ làm gì?**
- Tự động tải bộ framework này về.
- Copy thư mục cấu hình `.ai` vào dự án của bạn.
- Sau khi chạy xong, bạn sẽ thấy thư mục `.ai` xuất hiện trong dự án.

---

## 🛠 2. Việc cần làm ngay sau khi cài đặt

Sau khi cài đặt thành công, hãy thực hiện các bước sau để AI hoạt động chính xác:

1.  **Mồi ngữ cảnh:** Mở file `.ai/INITIAL_SESSION.md`, copy nội dung và gửi cho AI của bạn (Cursor Chat, Copilot Chat).
2.  **Cập nhật thông tin dự án:** Chỉnh sửa file `.ai/knowledge/tech-stack.md` để AI biết dự án của bạn dùng công nghệ gì (React, Node.js, v.v.).
3.  **Quét cấu trúc dự án:** Yêu cầu AI đọc cấu trúc thư mục và cập nhật vào `.ai/knowledge/project-map.md`.

---

## 🔨 3. Quy trình Thay đổi & Cập nhật Package (Dành cho Maintainer)

Mỗi khi bạn muốn thay đổi nội dung trong thư mục `.ai` hoặc cập nhật code của CLI, hãy thực hiện theo đúng các bước sau:

### Bước 1: Chỉnh sửa Nội dung
- Thực hiện các thay đổi trong thư mục `.ai/` (ví dụ: sửa file prompts, agents).
- Hoặc chỉnh sửa logic copy trong `bin/cli.js`.

### Bước 2: Tăng phiên bản (Version Bumping)
Mở file `package.json` và thay đổi dòng `"version"`. Đây là bước **BẮT BUỘC** để npm chấp nhận bản đẩy mới:
- Nếu sửa lỗi nhỏ: `1.0.0` -> `1.0.1`
- Nếu thêm tính năng mới: `1.0.0` -> `1.1.0`

### Bước 3: Đẩy Code lên GitHub (Lưu trữ mã nguồn)
Để lưu lại các thay đổi của bạn trên GitHub:
```bash
git add .
git commit -m "Mô tả các thay đổi bạn đã thực hiện"
git push origin master
```

### Bước 4: Publish lên NPM (Cập nhật cho người dùng)
Để người dùng (những người chạy lệnh `npx`) nhận được bản cập nhật mới nhất:
1.  **Chạy lệnh publish:**
    ```bash
    npm publish
    ```
2.  **Xác thực 2FA:** 
    - Với các bản npm hiện đại, Terminal sẽ tự động mở trình duyệt hoặc hiển thị một thông báo yêu cầu bạn xác thực trên máy tính/điện thoại.
    - Bạn chỉ cần thực hiện theo hướng dẫn trên màn hình là xong.
    - *Nếu Terminal không tự điều hướng, bạn có thể dùng phương án dự phòng:* `npm publish --otp=XXXXXX`.
    - OTP code có thể lấy từ các app như Authy, Google Authenticator, Microsoft Authenticator, ... nếu các app đó đã quét tài khoản Github của bạn vào.

---

## 🔍 5. Quy trình Đẩy Code & Bảo trì Dự án (Tóm tắt)

Để quản lý dự án một cách chuyên nghiệp, bạn hãy tuân thủ 4 bước này:

1.  **Sửa code**: Thay đổi nội dung trong `.ai/` hoặc `bin/cli.js`.
2.  **Tăng version**: Sửa file `package.json` (ví dụ từ `1.3.1` lên `1.3.2`).
3.  **Lưu & Merge**: Đẩy code lên Git -> Tạo Pull Request -> Merge vào `master`.
4.  **Publish**: Checkout sang `master`, kéo code mới nhất về (`git pull`) và chạy `npm publish`.

- ✅ **NÊN**: Cập nhật các file `.md` trong `.ai/agents/` để AI thông minh hơn.
- ✅ **NÊN**: Thêm các workflow mới vào `.ai/workflows/`.
- ❌ **KHÔNG NÊN**: Xóa file `index.js` (Làm hỏng package).
- ❌ **KHÔNG NÊN**: Đổi cấu trúc thư mục `.ai/` mà không cập nhật lại đường dẫn trong `bin/cli.js`.
- ❌ **KHÔNG NÊN**: Để lộ các file nhạy cảm (như `.env`) - hãy kiểm tra file `.npmignore`.

---

## 🆘 7. Xử lý sự cố (Troubleshooting)

### Lỗi: "Thư mục .ai đã tồn tại"
Khi bạn chạy `npx minhck-dot-ai` và nhận được thông báo thư mục đã tồn tại, bạn có 2 cách để giải quyết:

**Cách 1: Cập nhật bằng lệnh --force (Khuyên dùng)**
Nếu bạn muốn cập nhật bộ khung lên bản mới nhất mà không muốn xóa thư mục bằng tay:
```bash
npx minhck-dot-ai --force
```
*(Lưu ý: Lệnh này sẽ ghi đè toàn bộ nội dung trong thư mục `.ai` hiện tại của bạn).*

**Cách 2: Xóa thủ công**
1.  **Xóa thư mục `.ai` cũ:**
    ```bash
    rm -rf .ai
    ```
2.  **Chạy lại lệnh cài đặt:**
    ```bash
    npx minhck-dot-ai
    ```

### Lỗi: "Command not found: define-ai"
Nếu bạn cài đặt toàn cục (`npm install -g`) mà không chạy được lệnh:
- Hãy thử dùng `npx minhck-dot-ai` (không cần cài đặt, luôn là bản mới nhất).
- Hoặc kiểm tra lại biến môi trường PATH của npm.

---

**Phát triển bởi MinhCK**
