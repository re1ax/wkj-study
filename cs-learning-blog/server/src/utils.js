export function normalizePost(row) {
  return {
    id: row.id,
    title: row.title,
    summary: row.summary,
    category: row.category,
    tags: Array.isArray(row.tags) ? row.tags : JSON.parse(row.tags || "[]"),
    content: row.content,
    readingMinutes: row.reading_minutes,
    status: row.status,
    publishedAt: row.published_at,
    createdAt: row.created_at,
    updatedAt: row.updated_at
  };
}

export function validatePostPayload(body) {
  const required = ["title", "summary", "category", "content", "status"];
  const missing = required.filter((key) => !String(body[key] || "").trim());

  if (missing.length) {
    return `Missing required fields: ${missing.join(", ")}`;
  }

  if (!["draft", "published"].includes(body.status)) {
    return "Status must be draft or published";
  }

  if (!Array.isArray(body.tags)) {
    return "Tags must be an array";
  }

  return "";
}

