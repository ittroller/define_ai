#!/usr/bin/env node

const fs = require('fs-extra');
const path = require('path');

async function install() {
  const sourceDir = path.join(__dirname, '../.ai');
  const destDir = path.join(process.cwd(), '.ai');

  if (fs.existsSync(destDir)) {
    console.log('❌ Thư mục .ai đã tồn tại trong dự án này.');
    return;
  }

  try {
    await fs.copy(sourceDir, destDir);
    console.log('✅ Đã cài đặt bộ khung AI Agent (.ai) thành công!');
    console.log('👉 Bây giờ bạn có thể bắt đầu bằng cách mở .ai/INITIAL_SESSION.md');
  } catch (err) {
    console.error('❌ Lỗi khi cài đặt:', err);
  }
}

install();
