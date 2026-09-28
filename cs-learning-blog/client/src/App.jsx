import { BookOpen, Edit3, FileText, LogOut, Plus, Search, Trash2 } from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import ReactMarkdown from "react-markdown";
import { api } from "./api";

const emptyPost = {
  title: "",
  summary: "",
  category: "计算机基础",
  tagsText: "",
  content: "",
  readingMinutes: 3,
  status: "draft"
};

function formatDate(value) {
  if (!value) return "未发布";
  return new Intl.DateTimeFormat("zh-CN", { dateStyle: "medium" }).format(new Date(value));
}

function toFormPost(post) {
  return {
    id: post.id,
    title: post.title,
    summary: post.summary,
    category: post.category,
    tagsText: post.tags.join(", "),
    content: post.content,
    readingMinutes: post.readingMinutes,
    status: post.status
  };
}

function fromFormPost(post) {
  return {
    title: post.title.trim(),
    summary: post.summary.trim(),
    category: post.category.trim(),
    tags: post.tagsText
      .split(",")
      .map((tag) => tag.trim())
      .filter(Boolean),
    content: post.content.trim(),
    readingMinutes: Number(post.readingMinutes || 3),
    status: post.status
  };
}

export default function App() {
  const [view, setView] = useState("reader");
  const [posts, setPosts] = useState([]);
  const [adminPosts, setAdminPosts] = useState([]);
  const [selectedPost, setSelectedPost] = useState(null);
  const [category, setCategory] = useState("");
  const [query, setQuery] = useState("");
  const [message, setMessage] = useState("");
  const [login, setLogin] = useState({ username: "admin", password: "" });
  const [formPost, setFormPost] = useState(emptyPost);
  const [isAuthed, setIsAuthed] = useState(Boolean(localStorage.getItem("blog_token")));

  const categories = useMemo(
    () => Array.from(new Set(posts.map((post) => post.category))).filter(Boolean),
    [posts]
  );

  async function loadPosts(filters = {}) {
    const data = await api.getPosts(filters);
    setPosts(data);
  }

  async function loadAdminPosts() {
    const data = await api.getAdminPosts();
    setAdminPosts(data);
  }

  useEffect(() => {
    loadPosts().catch((error) => setMessage(error.message));
  }, []);

  useEffect(() => {
    if (view === "admin" && isAuthed) {
      loadAdminPosts().catch((error) => setMessage(error.message));
    }
  }, [view, isAuthed]);

  async function applyFilters(nextCategory = category, nextQuery = query) {
    setCategory(nextCategory);
    setQuery(nextQuery);
    setSelectedPost(null);
    await loadPosts({ category: nextCategory, q: nextQuery });
  }

  async function openPost(id) {
    const post = await api.getPost(id);
    setSelectedPost(post);
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  async function submitLogin(event) {
    event.preventDefault();
    try {
      const result = await api.login(login);
      localStorage.setItem("blog_token", result.token);
      setIsAuthed(true);
      setMessage("登录成功");
      await loadAdminPosts();
    } catch (error) {
      setMessage(error.message);
    }
  }

  async function savePost(event) {
    event.preventDefault();
    try {
      const payload = fromFormPost(formPost);
      if (formPost.id) {
        await api.updatePost(formPost.id, payload);
        setMessage("文章已更新");
      } else {
        await api.createPost(payload);
        setMessage("文章已创建");
      }
      setFormPost(emptyPost);
      await Promise.all([loadAdminPosts(), loadPosts()]);
    } catch (error) {
      setMessage(error.message);
    }
  }

  async function deletePost(id) {
    if (!window.confirm("确认删除这篇文章？")) return;
    try {
      await api.deletePost(id);
      setMessage("文章已删除");
      await Promise.all([loadAdminPosts(), loadPosts()]);
    } catch (error) {
      setMessage(error.message);
    }
  }

  function logout() {
    localStorage.removeItem("blog_token");
    setIsAuthed(false);
    setAdminPosts([]);
    setMessage("已退出登录");
  }

  return (
    <div className="app-shell">
      <header className="site-header">
        <nav className="topbar">
          <button className="brand" onClick={() => setView("reader")}>
            <BookOpen size={22} />
            <span>计算机学习日志</span>
          </button>
          <div className="nav-actions">
            <button className={view === "reader" ? "active" : ""} onClick={() => setView("reader")}>
              文章
            </button>
            <button className={view === "admin" ? "active" : ""} onClick={() => setView("admin")}>
              管理
            </button>
          </div>
        </nav>
        <div className="hero">
          <p className="eyebrow">Computer Science Learning Notes</p>
          <h1>把每天学到的计算机知识，沉淀成可复盘的文章。</h1>
          <div className="metrics">
            <span>{posts.length} 篇已发布</span>
            <span>{categories.length || 0} 个方向</span>
            <span>Markdown 笔记</span>
          </div>
        </div>
      </header>

      {message && (
        <button className="notice" onClick={() => setMessage("")}>
          {message}
        </button>
      )}

      {view === "reader" ? (
        <main className="reader-layout">
          <section className="filters">
            <label className="search-box">
              <Search size={18} />
              <input
                value={query}
                placeholder="搜索标题、摘要或正文"
                onChange={(event) => applyFilters(category, event.target.value)}
              />
            </label>
            <div className="category-row">
              <button className={!category ? "selected" : ""} onClick={() => applyFilters("", query)}>
                全部
              </button>
              {categories.map((item) => (
                <button
                  className={category === item ? "selected" : ""}
                  key={item}
                  onClick={() => applyFilters(item, query)}
                >
                  {item}
                </button>
              ))}
            </div>
          </section>

          {selectedPost ? (
            <article className="post-detail">
              <button className="text-button" onClick={() => setSelectedPost(null)}>
                返回列表
              </button>
              <p className="eyebrow">{selectedPost.category}</p>
              <h2>{selectedPost.title}</h2>
              <p className="summary">{selectedPost.summary}</p>
              <div className="post-meta">
                <span>{formatDate(selectedPost.publishedAt)}</span>
                <span>{selectedPost.readingMinutes} 分钟阅读</span>
              </div>
              <div className="tag-row">
                {selectedPost.tags.map((tag) => (
                  <span key={tag}>{tag}</span>
                ))}
              </div>
              <ReactMarkdown className="markdown">{selectedPost.content}</ReactMarkdown>
            </article>
          ) : (
            <section className="post-grid">
              {posts.map((post) => (
                <button className="post-card" key={post.id} onClick={() => openPost(post.id)}>
                  <div className="card-topline">
                    <span>{post.category}</span>
                    <span>{formatDate(post.publishedAt)}</span>
                  </div>
                  <h2>{post.title}</h2>
                  <p>{post.summary}</p>
                  <div className="tag-row">
                    {post.tags.map((tag) => (
                      <span key={tag}>{tag}</span>
                    ))}
                  </div>
                  <span className="read-time">{post.readingMinutes} 分钟阅读</span>
                </button>
              ))}
              {!posts.length && <p className="empty">还没有匹配的文章。</p>}
            </section>
          )}
        </main>
      ) : (
        <main className="admin-layout">
          {!isAuthed ? (
            <form className="panel login-panel" onSubmit={submitLogin}>
              <h2>管理员登录</h2>
              <input
                value={login.username}
                placeholder="用户名"
                onChange={(event) => setLogin({ ...login, username: event.target.value })}
              />
              <input
                value={login.password}
                type="password"
                placeholder="密码"
                onChange={(event) => setLogin({ ...login, password: event.target.value })}
              />
              <button className="primary" type="submit">
                登录
              </button>
            </form>
          ) : (
            <>
              <section className="panel admin-list">
                <div className="panel-title">
                  <h2>文章管理</h2>
                  <button onClick={logout}>
                    <LogOut size={16} />
                    退出
                  </button>
                </div>
                <button className="primary" onClick={() => setFormPost(emptyPost)}>
                  <Plus size={16} />
                  新建文章
                </button>
                <div className="admin-posts">
                  {adminPosts.map((post) => (
                    <div className="admin-row" key={post.id}>
                      <FileText size={18} />
                      <div>
                        <strong>{post.title}</strong>
                        <span>
                          {post.category} · {post.status === "published" ? "已发布" : "草稿"}
                        </span>
                      </div>
                      <button onClick={() => setFormPost(toFormPost(post))} title="编辑">
                        <Edit3 size={16} />
                      </button>
                      <button onClick={() => deletePost(post.id)} title="删除">
                        <Trash2 size={16} />
                      </button>
                    </div>
                  ))}
                </div>
              </section>

              <form className="panel editor" onSubmit={savePost}>
                <h2>{formPost.id ? "编辑文章" : "新建文章"}</h2>
                <input
                  value={formPost.title}
                  placeholder="标题"
                  onChange={(event) => setFormPost({ ...formPost, title: event.target.value })}
                />
                <textarea
                  value={formPost.summary}
                  placeholder="摘要"
                  rows="3"
                  onChange={(event) => setFormPost({ ...formPost, summary: event.target.value })}
                />
                <div className="form-grid">
                  <input
                    value={formPost.category}
                    placeholder="分类"
                    onChange={(event) => setFormPost({ ...formPost, category: event.target.value })}
                  />
                  <input
                    value={formPost.tagsText}
                    placeholder="标签，用英文逗号分隔"
                    onChange={(event) => setFormPost({ ...formPost, tagsText: event.target.value })}
                  />
                  <input
                    value={formPost.readingMinutes}
                    type="number"
                    min="1"
                    placeholder="阅读分钟"
                    onChange={(event) =>
                      setFormPost({ ...formPost, readingMinutes: event.target.value })
                    }
                  />
                  <select
                    value={formPost.status}
                    onChange={(event) => setFormPost({ ...formPost, status: event.target.value })}
                  >
                    <option value="draft">草稿</option>
                    <option value="published">发布</option>
                  </select>
                </div>
                <textarea
                  className="content-editor"
                  value={formPost.content}
                  placeholder="# Markdown 正文"
                  onChange={(event) => setFormPost({ ...formPost, content: event.target.value })}
                />
                <button className="primary" type="submit">
                  保存文章
                </button>
              </form>
            </>
          )}
        </main>
      )}
    </div>
  );
}

