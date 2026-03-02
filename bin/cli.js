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
        
        // Cập nhật .gitignore
        await updateGitignore();
        
        console.log('👉 Bây giờ bạn có thể bắt đầu bằng cách mở .ai/INITIAL_SESSION.md');
    } catch (err) {
        console.error('❌ Lỗi khi cài đặt:', err);
    }
}

async function updateGitignore() {
    const gitignorePath = path.join(process.cwd(), '.gitignore');
    const entry = '.ai';
    
    try {
        if (await fs.pathExists(gitignorePath)) {
            const content = await fs.readFile(gitignorePath, 'utf8');
            const lines = content.split(/\r?\n/).map(line => line.trim());
            
            if (!lines.includes(entry)) {
                const newContent = content.endsWith('\n') ? content + entry + '\n' : content + '\n' + entry + '\n';
                await fs.writeFile(gitignorePath, newContent);
                console.log('📝 Đã bổ sung .ai vào .gitignore');
            }
        } else {
            await fs.writeFile(gitignorePath, entry + '\n');
            console.log('📝 Đã tạo .gitignore và thêm .ai');
        }
    } catch (err) {
        console.error('⚠️ Không thể cập nhật .gitignore:', err);
    }
}

install();
