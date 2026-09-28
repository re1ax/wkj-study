import bcrypt from "bcryptjs";
import { pool } from "./db.js";

const passwordHash = await bcrypt.hash("admin123", 10);

await pool.execute(
  `INSERT INTO users (username, password_hash)
   VALUES (?, ?)
   ON DUPLICATE KEY UPDATE password_hash = VALUES(password_hash)`,
  ["admin", passwordHash]
);

const posts = [
  {
    title: "从缓存策略理解数据结构",
    summary: "用 LRU 和 LFU 缓存作为切入口，复习链表、哈希表和频率统计的组合设计。",
    category: "数据结构",
    tags: ["LRU", "LFU", "哈希表"],
    content:
      "# 从缓存策略理解数据结构\n\n缓存策略是学习数据结构的好入口。\n\n## LRU\n\nLRU 常用哈希表加双向链表，让查询和移动节点都保持 O(1)。\n\n## LFU\n\nLFU 需要额外维护访问频率，重点是想清楚频率桶和淘汰顺序。",
    readingMinutes: 4,
    status: "published"
  },
  {
    title: "Python 数据分析复习路线",
    summary: "围绕 NumPy、Pandas 和可视化整理一条适合反复复盘的学习路线。",
    category: "Python",
    tags: ["NumPy", "Pandas", "学习路线"],
    content:
      "# Python 数据分析复习路线\n\n先巩固数组和表格数据，再进入可视化和项目练习。\n\n- NumPy: 数组、广播、索引\n- Pandas: Series、DataFrame、分组聚合\n- 项目: 清洗一份真实数据并写复盘",
    readingMinutes: 3,
    status: "published"
  },
  {
    title: "操作系统学习笔记模板",
    summary: "建立一套固定模板，记录进程、内存、文件系统和网络相关知识点。",
    category: "计算机基础",
    tags: ["操作系统", "模板", "复盘"],
    content:
      "# 操作系统学习笔记模板\n\n每篇笔记固定回答三个问题：\n\n1. 这个概念解决什么问题？\n2. 它的关键机制是什么？\n3. 哪些场景容易出错？",
    readingMinutes: 2,
    status: "draft"
  }
];

for (const post of posts) {
  await pool.execute(
    `INSERT INTO posts
      (title, summary, category, tags, content, reading_minutes, status, published_at)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)
     ON DUPLICATE KEY UPDATE title = title`,
    [
      post.title,
      post.summary,
      post.category,
      JSON.stringify(post.tags),
      post.content,
      post.readingMinutes,
      post.status,
      post.status === "published" ? new Date() : null
    ]
  );
}

await pool.end();
console.log("Seeded admin user and sample posts. Login with admin / admin123");
