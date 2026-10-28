-- MNMN Store shared-points database (Cloudflare D1 / SQLite)
-- New installs start at ZERO points (half_points=0).
CREATE TABLE IF NOT EXISTS score (
  id INTEGER PRIMARY KEY CHECK (id = 1),
  half_points INTEGER NOT NULL CHECK (half_points >= 0),
  revision INTEGER NOT NULL DEFAULT 0
);
INSERT OR IGNORE INTO score (id, half_points, revision) VALUES (1, 0, 0);

CREATE TABLE IF NOT EXISTS events (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  half_delta INTEGER NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pin_attempts (
  ip_hash TEXT PRIMARY KEY,
  failures INTEGER NOT NULL DEFAULT 0,
  until_sec INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS credentials (
  id INTEGER PRIMARY KEY CHECK (id = 1),
  pin_hash TEXT NOT NULL,
  recovery_hash TEXT NOT NULL
);
-- Provision credentials(id=1) securely outside version control.
-- The API uses SHA-256 of a purpose-prefixed PIN and recovery word.
