import psycopg2
from config import DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASS

conn = psycopg2.connect(
    host=DB_HOST,
    port=DB_PORT,
    dbname=DB_NAME,
    user=DB_USER,
    password=DB_PASS
)

cur = conn.cursor()
cur.execute("""
CREATE TABLE IF NOT EXISTS entries (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    value INTEGER NOT NULL,
    time TEXT NOT NULL
)
""")
conn.commit()
cur.close()
conn.close()