# Khởi tạo phiên làm việc (Initial Session Prompt)

Sử dụng nội dung dưới đây để gửi cho AI mỗi khi bắt đầu một phiên làm việc mới hoặc khi AI có dấu hiệu quên ngữ cảnh dự án.

---

## Nội dung Prompt

"Chào bạn, tôi muốn bắt đầu một phiên làm việc mới cho dự án này. 

Nếu bạn hỗ trợ tính năng reference file (như @ hoặc #), hãy ưu tiên quét toàn bộ thư mục `.ai/` trước khi trả lời.

Trước khi thực hiện bất kỳ yêu cầu nào, hãy thực hiện các bước chuẩn bị sau:

1. **Đọc Hệ thống Agent**: Truy cập thư mục `.ai/agents/` để nắm rõ các vai trò. Khi tôi đưa ra một yêu cầu, hãy tự động nhập vai (adopt role) Agent phù hợp nhất để thực hiện. Nếu yêu cầu phức tạp, hãy phối hợp giữa các Agent.
2. **Nắm bắt Quy chuẩn & Quy trình**: 
   - Đọc `.ai/specifications/coding-standards.md`.
   - **Tham khảo `.ai/workflows/`**: Nếu tôi yêu cầu khởi tạo dự án hoặc thực hiện một tác vụ lớn, hãy kiểm tra thư mục này. Các file được đánh số thứ tự (01, 02...) để chỉ định trình tự thực hiện hoặc các module ưu tiên, hãy tuân thủ đúng thứ tự này.
3. **Kiểm tra Tech Stack & Nghiệp vụ**: 
   - Xem `.ai/knowledge/tech-stack.md`.
   - Xem `.ai/knowledge/business-logic.md` để nắm luồng nghiệp vụ.
   - (Nếu là UI/QA): Xem thêm `ux-ui-design-system.md` và `qa-testing-strategy.md`.
4. **Định vị Dự án**: Sử dụng `.ai/knowledge/project-map.md` để hiểu cấu trúc thư mục.
5. **Ghi nhớ Quyết định**: Đọc `.ai/memory/adr.md`.

**QUY TẮC QUAN TRỌNG NHẤT:** 
Đối với mọi yêu cầu thay đổi code hoặc thực hiện tác vụ phức tạp, bạn **BẮT BUỘC** phải:
- Bước 1: Phân tích yêu cầu.
- Bước 2: **Lập kế hoạch thực hiện chi tiết (Plan) và trình tôi review. Bạn chỉ được phép thực hiện các bước tiếp theo khi tôi đã xác nhận đồng ý với kế hoạch.**
- Bước 3: Thực hiện theo kế hoạch đã đề ra.

Xác nhận ngắn gọn rằng bạn đã sẵn sàng và hỏi tôi về tác vụ cần thực hiện. 

**Ngôn ngữ ưu tiên**: Tiếng Việt."
