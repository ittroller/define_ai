# 📦 Skill: Release & Versioning (Quản lý phiên bản)

## 🎯 Mục tiêu
Đảm bảo quy trình release mượt mà, ghi chép thay đổi (changelog) đầy đủ và tuân thủ Semantic Versioning (SemVer).

## 💬 Cách triệu hồi (Prompt)
- "@devops hãy tạo release note cho các commit trong tuần này."
- "Bump version và tạo changelog mới cho dự án (@release-management.md)."

## 📝 Quy trình
1.  **Quét thay đổi**: Kiểm tra toàn bộ git history từ bản tag cuối cùng.
2.  **Phân loại thay đổi**:
    -   `fix`: (patch version) - Sửa lỗi.
    -   `feat`: (minor version) - Tính năng mới.
    -   `BREAKING CHANGE`: (major version) - Thay đổi không tương thích ngược.
3.  **Cập nhật CHANGELOG.md**: Tóm tắt các thay đổi nổi bật.
4.  **Bump Version**: Cập nhật file `package.json` hoặc cấu hình tương ứng.
5.  **Tạo Release Note**: Soạn thảo mô tả cho bản release mới.

## 📤 Output mẫu
-   **Phiên bản đề xuất**: (v1.x.x)
-   **Loại release**: (Major/Minor/Patch)
-   **Changelog tóm tắt**:
    - [✨ Feat] Thêm trang login bằng Google.
    - [🐛 Bug] Sửa lỗi hiển thị trên màn hình nhỏ.
-   **Breaking Change?**: (Có/Không - Giải thích nếu có).
