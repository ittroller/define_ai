#!/usr/bin/env node

const fs = require('fs-extra');
const path = require('path');
const { execSync } = require('child_process');

const args = process.argv.slice(2);
const command = args[0] || 'init';

async function main() {
    switch (command) {
        case 'init':
            await install(args.includes('--force') || args.includes('-f'));
            break;
        case 'sync':
            await sync();
            break;
        case 'backup':
            await backup();
            break;
        case 'help':
        case '--help':
        case '-h':
            showHelp();
            break;
        default:
            console.log(`❌ Lệnh không hợp lệ: ${command}`);
            showHelp();
            break;
    }
}

function showHelp() {
    console.log(`
🤖 MinhCK AI Agent Framework CLI
--------------------------------
Cách dùng:
  npx minhck-dot-ai <command> [options]

Các lệnh:
  init      Cài đặt bộ khung .ai vào dự án (Mặc định)
            Options: --force, -f  Ghi đè nếu đã tồn tại
  sync      Đồng bộ cấu hình từ .ai sang các IDE (Cursor, Claude, ...)
  backup    Tạo bản sao lưu cho cấu hình AI hiện tại
  help      Hiển thị hướng dẫn này
    `);
}

async function install(force) {
    const sourceDir = path.join(__dirname, '../.ai');
    const destDir = path.join(process.cwd(), '.ai');

    if (fs.existsSync(destDir) && !force) {
        console.log('❌ Thư mục .ai đã tồn tại trong dự án này.');
        console.log('👉 Để cập nhật, chạy: npx minhck-dot-ai init --force');
        return;
    }

    try {
        await fs.copy(sourceDir, destDir, { overwrite: true });
        console.log(force ? '🔄 Đã cập nhật (ghi đè) .ai thành công!' : '✅ Đã cài đặt .ai thành công!');
        await updateGitignore();
        console.log('👉 Bắt đầu tại: .ai/INITIAL_SESSION.md');
    } catch (err) {
        console.error('❌ Lỗi khi cài đặt:', err);
    }
}

async function sync() {
    const syncScript = path.join(process.cwd(), '.ai/sync-to-agent.sh');
    if (!fs.existsSync(syncScript)) {
        console.log('❌ Không tìm thấy script đồng bộ tại .ai/sync-to-agent.sh');
        console.log('👉 Hãy chạy npx minhck-dot-ai init trước.');
        return;
    }

    try {
        console.log('🔄 Đang bắt đầu đồng bộ...');
        execSync(`bash "${syncScript}"`, { stdio: 'inherit' });
    } catch (err) {
        console.error('❌ Lỗi khi đồng bộ:', err.message);
    }
}

async function backup() {
    const syncScript = path.join(process.cwd(), '.ai/sync-to-agent.sh');
    // Tận dụng logic backup trong script sync nhưng chỉ chạy phần backup nếu có thể, 
    // hoặc đơn giản là copy .ai ra một folder backup.
    const backupDir = path.join(process.cwd(), '.ai_backups', `manual_${Date.now()}`);
    
    try {
        if (fs.existsSync('.ai')) {
            await fs.copy('.ai', path.join(backupDir, '.ai'));
            console.log(`✅ Đã sao lưu .ai vào ${backupDir}`);
        } else {
            console.log('❌ Không tìm thấy thư mục .ai để sao lưu.');
        }
    } catch (err) {
        console.error('❌ Lỗi khi sao lưu:', err);
    }
}

async function updateGitignore() {
    const gitignorePath = path.join(process.cwd(), '.gitignore');
    const entry = '.ai';
    try {
        if (await fs.pathExists(gitignorePath)) {
            const content = await fs.readFile(gitignorePath, 'utf8');
            if (!content.includes(entry)) {
                await fs.appendFile(gitignorePath, `\n${entry}\n`);
                console.log('📝 Đã bổ sung .ai vào .gitignore');
            }
        } else {
            await fs.writeFile(gitignorePath, `${entry}\n`);
            console.log('📝 Đã tạo .gitignore');
        }
    } catch (err) {
        console.error('⚠️ Lỗi .gitignore:', err.message);
    }
}

main();
