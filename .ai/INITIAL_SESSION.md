# Khởi tạo phiên làm việc (Initial Session Prompt)

Sử dụng nội dung dưới đây để gửi cho AI mỗi khi bắt đầu một phiên làm việc mới hoặc khi AI có dấu hiệu quên ngữ cảnh dự án.

---

## Nội dung Prompt

"Chào bạn, tôi muốn bắt đầu một phiên làm việc mới cho dự án này. 

Nếu bạn hỗ trợ tính năng reference file (như @ hoặc #), hãy ưu tiên quét toàn bộ thư mục cấu hình AI của dự án (như `.ai/`, `.agent/`, `.cursor/rules/` hoặc `.claude/` tùy theo IDE đang dùng) trước khi trả lời.

Trước khi thực hiện bất kỳ yêu cầu nào, hãy thực hiện các bước chuẩn bị sau:

1. **Đọc Hệ thống Agent & Kỹ năng**: Truy cập thư mục `agents/` và `skills/` (trong thư mục cấu hình AI) để nắm rõ các vai trò và các kỹ năng chuyên sâu của mình.
2. **Nắm bắt Quy chuẩn, Quy trình & Tài liệu**: 
   - Đọc file `coding-standards.md`.
   - **Tham khảo thư mục `workflows/`**: Tuân thủ thứ tự thực hiện (01, 02...).
   - **Đọc thư mục `docs/`**: Hiểu kiến trúc hệ thống (`architecture/`) và hướng dẫn vận hành (`runbooks/`).
3. **Kiểm tra Tech Stack & Nghiệp vụ**: 
   - Xem file `tech-stack.md`.
   - Xem file `business-logic.md` để nắm luồng nghiệp vụ.
4. **Định vị Dự án & Trí nhớ**: 
   - Sử dụng file `project-map.md` để hiểu cấu trúc.
   - Đọc file `adr.md` hoặc thư mục `docs/decisions/` để nắm lịch sử quyết định.
5. **Kích hoạt Guardrails**: Kiểm tra thư mục `hooks/`. Trước khi hoàn tất tác vụ, hãy tự động chạy các script kiểm tra nếu có (ví dụ `pre-finish-check.sh`).

**QUY TẮC QUAN TRỌNG NHẤT:** 
Đối với mọi yêu cầu thay đổi code hoặc thực hiện tác vụ phức tạp, bạn **BẮT BUỘC** phải:
- Bước 1: Phân tích yêu cầu.
- Bước 2: **Lập kế hoạch thực hiện chi tiết (Plan) và trình tôi review. Bạn chỉ được phép thực hiện các bước tiếp theo khi tôi đã xác nhận đồng ý với kế hoạch.**
- Bước 3: Thực hiện theo kế hoạch đã đề ra.

Xác nhận ngắn gọn rằng bạn đã sẵn sàng và hỏi tôi về tác vụ cần thực hiện. 

**Ngôn ngữ ưu tiên**: Tiếng Việt."
