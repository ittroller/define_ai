# ⚡ Workflow: Khởi tạo Base NextJS (App Router)

Mục tiêu: Tạo một dự án NextJS hiện đại, sử dụng App Router, cấu trúc sạch sẽ cho cả frontend và backend logic.

---

## 🚀 Bước 1: Khởi tạo Project bằng Next CLI

Chạy lệnh sau:

```bash
npx create-next-app@latest <tên-dự-án> --typescript --tailwind --eslint
```

## 📂 Bước 2: Cấu trúc Thư mục Đề xuất (src/)

```text
src/
├── app/                 # Routes, Layouts, Server Components
├── components/          # React Components
│   ├── ui/              # Base UI (Shadcn/UI)
│   ├── common/          # Shared components
│   └── modules/         # Components cho tính năng cụ thể
├── hooks/               # Custom React Hooks
├── lib/                 # Shared utilities, client-side config
├── services/            # API calls, business logic (Server/Client)
├── store/               # State management (Zustand/Context)
├── types/               # TypeScript interfaces & types
└── styles/              # Global CSS, Tailwind config
```

## 🛠️ Bước 3: Thiết lập Cơ bản

1.  **UI Library**: Cài đặt Shadcn/UI (khuyên dùng).
2.  **API Client**: Sử dụng Fetch hoặc Axios, tổ chức trong `services/`.
3.  **Authentication**: Thiết lập NextAuth.js hoặc Clerk (tùy nhu cầu).
4.  **SEO**: Cấu hình Metadata API trong `layout.tsx`.

## 📈 Bước 4: Nguyên tắc Mở rộng

- **Server Components**: Ưu tiên sử dụng React Server Components để tối ưu hiệu năng.
- **Client Components**: Chỉ dùng khi cần tương tác người dùng hoặc hooks (`useState`, `useEffect`).
- **Feature-based folders**: Nếu project lớn, hãy nhóm components theo từng tính năng (Feature-based).
- **Zod**: Sử dụng Zod để validation dữ liệu từ API hoặc Forms.

---

**AI Agent Note**: Luôn tuân thủ quy tắc đặt tên file (lowercase-kebab-case cho pages/routes, PascalCase cho components).
