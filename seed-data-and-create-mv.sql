-- Insert example users
INSERT INTO app."User" (name, email) VALUES
  ('Alice', 'alice@example.com'),
  ('Bob', 'bob@example.com');

-- Insert example posts
INSERT INTO app."Post" (title, content, "authorId") VALUES
  ('First Post', 'This is the content of the first post.', 1),
  ('Second Post', 'This is the content of the second post.', 1),
  ('Third Post', 'This is the content of the third post.', 2);

-- Create materialized views in the public schema
CREATE MATERIALIZED VIEW public.user_posts AS
SELECT
  u.id AS user_id,
  u.name AS user_name,
  p.id AS post_id,
  p.title AS post_title,
  p.content AS post_content
FROM
  app."User" u
JOIN
  app."Post" p ON u.id = p."authorId";

-- Refresh the materialized views
REFRESH MATERIALIZED VIEW public.user_posts;