#!/usr/bin/env node

const fs = require('fs-extra');
const path = require('path');

async function install() {
    const args = process.argv.slice(2);
    const force = args.includes('--force') || args.includes('-f');
    
    const sourceDir = path.join(__dirname, '../.ai');
    const destDir = path.join(process.cwd(), '.ai');

    if (fs.existsSync(destDir) && !force) {
        console.log('❌ Thư mục .ai đã tồn tại trong dự án này.');
        console.log('👉 Để cập nhật bản mới nhất mà không cần xóa, hãy chạy:');
        console.log('   npx minhck-dot-ai --force');
        console.log('👉 Hoặc xóa thủ công bằng lệnh: rm -rf .ai và sau đó chạy lại lệnh: npx minhck-dot-ai');
        return;
    }

    try {
        await fs.copy(sourceDir, destDir, { overwrite: true });
        console.log(force ? '🔄 Đã cập nhật (ghi đè) bộ khung AI Agent (.ai) thành công!' : '✅ Đã cài đặt bộ khung AI Agent (.ai) thành công!');
        console.log('👉 Bây giờ bạn có thể bắt đầu bằng cách mở .ai/INITIAL_SESSION.md');
    } catch (err) {
        console.error('❌ Lỗi khi cài đặt:', err);
    }
}

install();
