import express from "express";
import { pool } from "../db.js";
import { normalizePost } from "../utils.js";

export const postsRouter = express.Router();

postsRouter.get("/", async (req, res, next) => {
  try {
    const { category, tag, q } = req.query;
    const clauses = ["status = 'published'"];
    const params = [];

    if (category) {
      clauses.push("category = ?");
      params.push(category);
    }

    if (tag) {
      clauses.push("JSON_CONTAINS(tags, JSON_QUOTE(?))");
      params.push(tag);
    }

    if (q) {
      clauses.push("(title LIKE ? OR summary LIKE ? OR content LIKE ?)");
      params.push(`%${q}%`, `%${q}%`, `%${q}%`);
    }

    const [rows] = await pool.execute(
      `SELECT * FROM posts WHERE ${clauses.join(" AND ")} ORDER BY COALESCE(published_at, created_at) DESC`,
      params
    );

    return res.json(rows.map(normalizePost));
  } catch (error) {
    return next(error);
  }
});

postsRouter.get("/:id", async (req, res, next) => {
  try {
    const [rows] = await pool.execute(
      "SELECT * FROM posts WHERE id = ? AND status = 'published'",
      [req.params.id]
    );

    if (!rows[0]) {
      return res.status(404).json({ message: "Post not found" });
    }

    return res.json(normalizePost(rows[0]));
  } catch (error) {
    return next(error);
  }
});

