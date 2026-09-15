defmodule Pluggy.Cookie do
  def get_session_id(cookie) do
    Postgrex.query!(DB, "SELECT id FROM sessions WHERE session = $1", [cookie]).rows
  end

  def save_cookie(cookie) do
    Postgrex.query!(DB, "INSERT INTO sessions (session) VALUES ($1)", [cookie])
  end

  def clear_cookie(cookie) do
    Postgrex.query!(DB, "DELETE FROM sessions WHERE session = $1", [cookie])
  end

  def assign_admin(session_id) do
    admin = "admin"
    Postgrex.query!(DB, "UPDATE sessions SET is_admin = $1 WHERE id = $2", [admin, session_id])
  end
end
