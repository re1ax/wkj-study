import cors from "cors";
import express from "express";
import { config } from "./config.js";
import { requireAuth } from "./middleware/auth.js";
import { adminPostsRouter } from "./routes/adminPosts.js";
import { authRouter } from "./routes/auth.js";
import { postsRouter } from "./routes/posts.js";

const app = express();

app.use(cors({ origin: config.clientOrigin }));
app.use(express.json({ limit: "1mb" }));

app.get("/api/health", (_req, res) => {
  res.json({ ok: true, service: "cs-learning-blog-api" });
});

app.use("/api/auth", authRouter);
app.use("/api/posts", postsRouter);
app.use("/api/admin/posts", requireAuth, adminPostsRouter);

app.use((error, _req, res, _next) => {
  console.error(error);
  res.status(500).json({ message: "Internal server error" });
});

app.listen(config.port, () => {
  console.log(`API server listening on http://localhost:${config.port}`);
});

