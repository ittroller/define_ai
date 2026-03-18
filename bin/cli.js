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
        case 'clean':
            await clean();
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

  sync      [ide] [--keep] [--clean] [--backup]
            Đồng bộ cấu hình từ .ai sang các IDE.
            Script sẽ tự động nhận diện IDE qua terminal hoặc thư mục dự án.
            Các IDE hỗ trợ: jetbrains, pycharm, intellij, webstorm, cursor, vscode, claude, xcode, antigravity, codex, continue, zed, pearai, cline, trae, windsurf, aider, all.
            Options:
              --keep, -k    Giữ lại thư mục .ai sau khi đồng bộ (Mặc định là xóa)
              --clean, -c   Xóa thư mục .ai_backups sau khi đồng bộ xong
              --backup, -b  Sao lưu cấu hình hiện tại trước khi đồng bộ

  backup    Tạo bản sao lưu cho cấu hình AI hiện tại
  clean     Dọn dẹp các thư mục AI generated (.ai_backups, INITIAL_SESSION.md...)
  help      Hiển thị hướng dẫn này

Ví dụ:
  npx minhck-dot-ai sync jetbrains
  npx minhck-dot-ai sync cursor --keep
  npx minhck-dot-ai sync codex
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
        // Đảm bảo script có quyền thực thi
        const syncScript = path.join(destDir, 'sync-to-agent.sh');
        if (fs.existsSync(syncScript)) {
            fs.chmodSync(syncScript, '755');
        }
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

    // Lấy tất cả tham số truyền vào từ command sync: npx minhck-dot-ai sync [args...]
    const syncArgs = process.argv.slice(3);
    
    try {
        console.log(`🔄 Đang bắt đầu đồng bộ...`);
        // Truyền các tham số trực tiếp cho bash script xử lý
        execSync(`bash "${syncScript}" ${syncArgs.join(' ')}`, { stdio: 'inherit' });
    } catch (err) {
        // Lỗi thường đã được in ra bởi stdio: inherit, ở đây chỉ catch để không crash
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

async function clean() {
    const foldersToClean = [
        '.ai_backups',
        'INITIAL_SESSION.md',
        '.agent',
        '.cursor',
        '.claude',
        '.claude-instructions.md',
        '.xcoderules',
        '.xcode',
        '.ide',
        '.idea/ai-instructions.md',
        '.idea/ai-agents',
        '.idea/CLAUDE.md',
        '.continue',
        '.pearai',
        '.zed',
        '.aider.instructions.md',
        '.aider',
        '.clinerules',
        '.cline',
        '.traerules',
        '.trae',
        '.windsurfrules',
        '.windsurf',
        '.codex'
    ];

    console.log('🧹 Đang dọn dẹp các thư mục AI generated...');
    
    let cleanedCount = 0;
    for (const item of foldersToClean) {
        const itemPath = path.join(process.cwd(), item);
        if (fs.existsSync(itemPath)) {
            try {
                await fs.remove(itemPath);
                console.log(`   🗑️ Đã xóa: ${item}`);
                cleanedCount++;
            } catch (err) {
                console.error(`   ❌ Lỗi khi xóa ${item}:`, err.message);
            }
        }
    }

    if (cleanedCount === 0) {
        console.log('✨ Không tìm thấy thư mục nào cần dọn dẹp.');
    } else {
        console.log(`✅ Đã dọn dẹp xong ${cleanedCount} mục!`);
    }
}

async function updateGitignore() {
    const gitignorePath = path.join(process.cwd(), '.gitignore');
    const entries = ['.ai', '.ai_backups'];
    try {
        if (await fs.pathExists(gitignorePath)) {
            let content = await fs.readFile(gitignorePath, 'utf8');
            let updated = false;
            
            for (const entry of entries) {
                if (!content.includes(entry)) {
                    content += `\n${entry}\n`;
                    updated = true;
                    console.log(`📝 Đã bổ sung ${entry} vào .gitignore`);
                }
            }
            
            if (updated) {
                await fs.writeFile(gitignorePath, content);
            }
        } else if (command === 'init') {
            // Chỉ tạo .gitignore mới nếu đang chạy lệnh init
            await fs.writeFile(gitignorePath, entries.join('\n') + '\n');
            console.log('📝 Đã tạo .gitignore');
        }
    } catch (err) {
        console.error('⚠️ Lỗi .gitignore:', err.message);
    }
}

main();
