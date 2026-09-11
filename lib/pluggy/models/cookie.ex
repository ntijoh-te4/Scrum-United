defmodule Pluggy.Cookie do
  def get_session_id(cookie) do
    Postgrex.query!(DB, "SELECT id FROM sessions WHERE session = $1", [cookie]).rows
  end

  def save_cookie(cookie) do
    Postgrex.query!(DB, "INSERT INTO sessions (session) VALUES ($1)", [cookie])
  end
end
