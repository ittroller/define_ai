# Project Map

Tài liệu này cung cấp cái nhìn tổng quan về cấu trúc thư mục và các file quan trọng trong dự án. AI sử dụng file này để hiểu vị trí của các component, logic và các module khác mà không cần quét toàn bộ hệ thống file.

## 1. Cấu trúc thư mục (Tóm tắt)

```text
.
├── public/                 # Tài sản tĩnh (Images, Fonts, SVGs)
├── src/
│   ├── app/                # Next.js App Router (Pages, Layouts)
│   │   ├── (dashboard)/    # Các trang thuộc Dashboard
│   │   ├── (marketing)/    # Các trang Landing Page, Marketing
│   │   └── users/          # Quản lý người dùng & Auth
│   ├── components/         # Các Reusable Components
│   │   ├── ui/             # Atomic components (Button, Card, Badge...)
│   │   ├── layout/         # Layout components (Header, Footer)
│   │   ├── sections/       # Các section lớn cho Marketing
│   │   └── dashboard/      # Các component đặc thù cho Dashboard
│   ├── lib/                # Thư viện dùng chung, Utilities
│   └── types/              # Định nghĩa TypeScript Types
├── next.config.ts          # Cấu hình Next.js
├── tailwind.config.ts      # Cấu hình Tailwind CSS
└── package.json            # Quản lý dependencies
```

## 2. Chi tiết hệ thống File (Cập nhật tự động)

```text
./src
./src/types
./src/app
./src/app/favicon.ico
./src/app/page.module.css
./src/app/(marketing)
./src/app/(marketing)/layout.tsx
./src/app/(marketing)/page.tsx
./src/app/layout.tsx
./src/app/users
./src/app/users/sign_in
./src/app/users/layout.tsx
./src/app/users/sign_up
./src/app/(dashboard)
./src/app/(dashboard)/detect
./src/app/(dashboard)/projects
./src/app/(dashboard)/voices
./src/app/(dashboard)/layout.tsx
./src/app/(dashboard)/hub
./src/app/globals.css
./src/app/login
./src/components
./src/components/ui
./src/components/ui/Banner.tsx
./src/components/ui/Card.tsx
./src/components/ui/Badge.tsx
./src/components/ui/Button.tsx
./src/components/sections
./src/components/sections/ProductGrid.tsx
./src/components/sections/CTASection.tsx
./src/components/sections/PressSection.tsx
./src/components/sections/TrustBar.tsx
./src/components/sections/DetectionSection.tsx
./src/components/sections/HeroSection.tsx
./src/components/sections/DeploymentSection.tsx
./src/components/sections/SecuritySection.tsx
./src/components/sections/VoiceShowcase.tsx
./src/components/auth
./src/components/layout
./src/components/layout/Footer.tsx
./src/components/layout/Header.tsx
./src/components/dashboard
./src/components/dashboard/HubToolbar.tsx
./src/components/dashboard/HubEditor.tsx
./src/components/dashboard/HubBanner.tsx
./src/components/dashboard/HubActionBar.tsx
./src/components/dashboard/SidebarNavItem.tsx
./src/components/dashboard/Header.tsx
./src/components/dashboard/Sidebar.tsx
./src/proxy.ts
./src/lib
./src/lib/utils.ts
```
