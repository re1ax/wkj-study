const API_BASE = import.meta.env.VITE_API_BASE || "http://localhost:3001/api";

async function request(path, options = {}) {
  const token = localStorage.getItem("blog_token");
  const response = await fetch(`${API_BASE}${path}`, {
    ...options,
    headers: {
      "Content-Type": "application/json",
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...options.headers
    }
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: "Request failed" }));
    throw new Error(error.message || "Request failed");
  }

  if (response.status === 204) {
    return null;
  }

  return response.json();
}

export const api = {
  getPosts: (params = {}) => {
    const search = new URLSearchParams(
      Object.entries(params).filter(([, value]) => value)
    ).toString();
    return request(`/posts${search ? `?${search}` : ""}`);
  },
  getPost: (id) => request(`/posts/${id}`),
  login: (credentials) =>
    request("/auth/login", {
      method: "POST",
      body: JSON.stringify(credentials)
    }),
  getAdminPosts: () => request("/admin/posts"),
  createPost: (post) =>
    request("/admin/posts", {
      method: "POST",
      body: JSON.stringify(post)
    }),
  updatePost: (id, post) =>
    request(`/admin/posts/${id}`, {
      method: "PUT",
      body: JSON.stringify(post)
    }),
  deletePost: (id) =>
    request(`/admin/posts/${id}`, {
      method: "DELETE"
    })
};

