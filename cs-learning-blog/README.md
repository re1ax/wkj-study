# 计算机学习日志

一个用于记录计算机学习的全栈博客项目。

## 技术栈

- 前端：React + Vite + react-markdown
- 后端：Node.js + Express + JWT
- 数据库：MySQL

## 目录结构

```text
cs-learning-blog/
  client/      React 前端
  server/      Express 后端
  database/    MySQL 初始化脚本
```

## 快速开始

1. 安装依赖：

```bash
npm install
npm run install:all
```

2. 创建环境变量：

```bash
cp .env.example .env
```

然后编辑 `.env`，填入你的 MySQL 用户名和密码。当前机器的 MySQL 配置显示端口是 `6406`，如果你的服务使用标准端口再改回 `3306`。

3. 初始化数据库：

```bash
mysql -u你的用户 -p < database/schema.sql
```

4. 写入默认管理员和示例文章：

```bash
npm run seed --prefix server
```

默认管理员账号：

```text
用户名：admin
密码：admin123
```

5. 启动开发服务：

```bash
npm run dev
```

前端地址：http://localhost:5173

后端地址：http://localhost:3001

## API 概览

- `POST /api/auth/login`
- `GET /api/posts`
- `GET /api/posts/:id`
- `GET /api/admin/posts`
- `POST /api/admin/posts`
- `PUT /api/admin/posts/:id`
- `DELETE /api/admin/posts/:id`

管理接口需要在请求头中带上 `Authorization: Bearer <token>`。
