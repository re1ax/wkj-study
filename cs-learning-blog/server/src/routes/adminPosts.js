import express from "express";
import { pool } from "../db.js";
import { normalizePost, validatePostPayload } from "../utils.js";

export const adminPostsRouter = express.Router();

adminPostsRouter.get("/", async (_req, res, next) => {
  try {
    const [rows] = await pool.execute("SELECT * FROM posts ORDER BY updated_at DESC");
    return res.json(rows.map(normalizePost));
  } catch (error) {
    return next(error);
  }
});

adminPostsRouter.post("/", async (req, res, next) => {
  try {
    const error = validatePostPayload(req.body);
    if (error) {
      return res.status(400).json({ message: error });
    }

    const publishedAt = req.body.status === "published" ? req.body.publishedAt || new Date() : null;
    const [result] = await pool.execute(
      `INSERT INTO posts
        (title, summary, category, tags, content, reading_minutes, status, published_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        req.body.title,
        req.body.summary,
        req.body.category,
        JSON.stringify(req.body.tags),
        req.body.content,
        Number(req.body.readingMinutes || 3),
        req.body.status,
        publishedAt
      ]
    );

    const [rows] = await pool.execute("SELECT * FROM posts WHERE id = ?", [result.insertId]);
    return res.status(201).json(normalizePost(rows[0]));
  } catch (error) {
    return next(error);
  }
});

adminPostsRouter.put("/:id", async (req, res, next) => {
  try {
    const error = validatePostPayload(req.body);
    if (error) {
      return res.status(400).json({ message: error });
    }

    const [existingRows] = await pool.execute("SELECT * FROM posts WHERE id = ?", [req.params.id]);
    if (!existingRows[0]) {
      return res.status(404).json({ message: "Post not found" });
    }

    const existing = normalizePost(existingRows[0]);
    const publishedAt =
      req.body.status === "published"
        ? req.body.publishedAt || existing.publishedAt || new Date()
        : null;

    await pool.execute(
      `UPDATE posts
       SET title = ?, summary = ?, category = ?, tags = ?, content = ?,
           reading_minutes = ?, status = ?, published_at = ?
       WHERE id = ?`,
      [
        req.body.title,
        req.body.summary,
        req.body.category,
        JSON.stringify(req.body.tags),
        req.body.content,
        Number(req.body.readingMinutes || 3),
        req.body.status,
        publishedAt,
        req.params.id
      ]
    );

    const [rows] = await pool.execute("SELECT * FROM posts WHERE id = ?", [req.params.id]);
    return res.json(normalizePost(rows[0]));
  } catch (error) {
    return next(error);
  }
});

adminPostsRouter.delete("/:id", async (req, res, next) => {
  try {
    const [result] = await pool.execute("DELETE FROM posts WHERE id = ?", [req.params.id]);

    if (!result.affectedRows) {
      return res.status(404).json({ message: "Post not found" });
    }

    return res.status(204).send();
  } catch (error) {
    return next(error);
  }
});
