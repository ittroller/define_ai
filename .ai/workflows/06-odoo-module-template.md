# 📦 Workflow: Create Standard Odoo Module

Mục tiêu: Tạo một Odoo Module hoàn chỉnh tuân thủ các quy chuẩn thiết kế của Odoo (Model, View, Security, Data).

---

## 🏗️ Bước 1: Cấu trúc Thư mục chuẩn (Odoo Standard)
Tạo thư mục cho module mới trong `custom_addons/<module_name>`. Cấu trúc thư mục phải tuân thủ tiêu chuẩn của Odoo:

```text
<module_name>/
├── __init__.py
├── __manifest__.py
├── models/              # Định nghĩa các Business Models
│   ├── __init__.py
│   └── <model_name>.py
├── views/               # Định nghĩa giao diện (XML)
│   ├── <model_name>_views.xml
│   └── menus.xml
├── security/            # Phân quyền (CSV & XML)
│   ├── ir.model.access.csv
│   └── <model_name>_security.xml
├── data/                # Dữ liệu mặc định (XML/CSV)
│   └── <model_name>_data.xml
├── controllers/         # Web Controllers (nếu có)
│   ├── __init__.py
│   └── main.py
├── static/              # Assets (JS, CSS, IMG)
│   └── src/
│       ├── js/
│       ├── xml/
│       └── scss/
└── wizard/              # Wizards (Transient Models)
    ├── __init__.py
    └── <wizard_name>.py
```

## 🧩 Bước 2: Model Design & Odoo ORM

### Định nghĩa Model
Tận dụng Odoo ORM để định nghĩa các fields và business logic.
```python
from odoo import models, fields, api

class MyModel(models.Model):
    _name = 'my.module.model'
    _description = 'Mô tả module'

    name = fields.Char(string='Tên', required=True)
    description = fields.Text(string='Mô tả')
    state = fields.Selection([
        ('draft', 'Nháp'),
        ('confirm', 'Xác nhận'),
        ('done', 'Hoàn thành'),
    ], string='Trạng thái', default='draft')
```

### Business Logic
Sử dụng các decorators như `@api.depends`, `@api.onchange`, `@api.constrains`.

## 🎨 Bước 3: View & UI Design
- **Form View**: Thiết kế giao diện nhập liệu chi tiết.
- **Tree/List View**: Thiết kế giao diện danh sách.
- **Search View**: Định nghĩa các bộ lọc (filters) và nhóm (groups).
- **OWL Components**: Phát triển các components JS hiện đại trong `static/src/`.

```xml
<record id="view_my_model_form" model="ir.ui.view">
    <field name="name">my.model.form</field>
    <field name="model">my.module.model</field>
    <field name="arch" type="xml">
        <form>
            <header>
                <button name="action_confirm" string="Xác nhận" type="object" class="oe_highlight" states="draft"/>
                <field name="state" widget="statusbar"/>
            </header>
            <sheet>
                <group>
                    <field name="name"/>
                    <field name="description"/>
                </group>
            </sheet>
        </form>
    </field>
</record>
```

### OWL Component Example
Tạo file `static/src/js/my_component.js`:
```javascript
/** @odoo-module **/
import { Component, useState } from "@odoo/owl";

export class MyComponent extends Component {
    setup() {
        this.state = useState({ value: 0 });
    }
    increment() {
        this.state.value++;
    }
}
MyComponent.template = "my_module.MyComponent";
```

## 🛡️ Bước 4: Security & Access Rights
- Luôn định nghĩa quyền truy cập trong `ir.model.access.csv`.
- Sử dụng Record Rules để giới hạn dữ liệu theo người dùng/nhóm.

## 📜 Bước 5: Manifest & Assets Registration
- Khai báo đầy đủ các dependencies (`depends`) và file dữ liệu (`data`) trong `__manifest__.py`.
- Đăng ký assets (JS/XML/CSS) cho OWL Components:

```python
'depends': ['base', 'web'],
'data': [
    'security/ir.model.access.csv',
    'views/my_model_views.xml',
    'views/menus.xml',
],
'assets': {
    'web.assets_backend': [
        'my_module/static/src/js/my_component.js',
        'my_module/static/src/xml/my_component.xml',
        'my_module/static/src/scss/my_component.scss',
    ],
},
```

---

**AI Agent Note**: Luôn sử dụng `odoo-bin scaffold` để tạo khung module ban đầu nếu có thể, sau đó tùy chỉnh theo cấu trúc trên.
