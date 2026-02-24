---
description: Chức năng authentication ở landing page
---

Yêu cầu:

- Luôn sử dụng Context7 MCP khi cần tài liệu về thư viện/API, tạo mã, các bước thiết lập hoặc cấu hình mà không cần phải yêu cầu một cách rõ ràng.

## Quy trình thực hiện
1. **Lập kế hoạch**: Phân tích yêu cầu làm UI chức năng sign in / sign up ở https://www.resemble.ai/. **Lập kế hoạch thực hiện chi tiết (Plan) và trình người dùng review. BẮT BUỘC phải được người dùng đồng ý mới được thực hiện.**
2. **Thực hiện**: 
    - Khi click button sign in ở top menu sẽ điều hướng tới https://app.resemble.ai/users/sign_in và tự động mở modal login.
    - Bám sát router theo yêu cầu.
    - Chỉ clone giao diện.
    - Không cần animation phức tạp.
    - Tuân thủ cách điều hướng.
    - Áp dụng các style đã phân tích vào code.
3. **Kiểm tra**: Chạy test UI.
