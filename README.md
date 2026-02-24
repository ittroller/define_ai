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
1.  Lấy mã OTP từ app Authenticator trên điện thoại.
2.  Chạy lệnh:
    ```bash
    npm publish --otp=XXXXXX
    ```

---

## 🔍 5. Kiểm tra trước khi Push/Publish

Trước khi thực hiện Bước 4, bạn có thể chạy lệnh này để xem thử gói hàng (package) gửi đi sẽ trông như thế nào:
```bash
npm pack --dry-run
```
**Hãy đảm bảo:**
- `total files` là khoảng **32** (chứa đầy đủ các file trong thư mục `.ai`).
- Không có các file rác như `.DS_Store` hay thư mục `.idea` trong danh sách (đã được cấu hình trong `.npmignore`).

---

## 📝 6. Những thứ CẦN và KHÔNG NÊN sửa

- ✅ **NÊN**: Cập nhật các file `.md` trong `.ai/agents/` để AI thông minh hơn.
- ✅ **NÊN**: Thêm các workflow mới vào `.ai/workflows/`.
- ❌ **KHÔNG NÊN**: Xóa file `index.js` (Làm hỏng package).
- ❌ **KHÔNG NÊN**: Đổi cấu trúc thư mục `.ai/` mà không cập nhật lại đường dẫn trong `bin/cli.js`.
- ❌ **KHÔNG NÊN**: Để lộ các file nhạy cảm (như `.env`) - hãy kiểm tra file `.npmignore`.

---

**Phát triển bởi MinhCK**
