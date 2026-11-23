import os
from flask import Flask, jsonify
import psycopg

app = Flask(__name__)

def db_connection():
    return psycopg.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME", "capstone"),
        user=os.getenv("DB_USER", "capstone"),
        password=os.getenv("DB_PASSWORD", ""),
        connect_timeout=3,
    )

@app.get("/api/health")
def health():
    return jsonify(status="ok", service="capstone-api"), 200

@app.get("/api/db-check")
def db_check():
    try:
        with db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT 1")
                result = cur.fetchone()[0]
        return jsonify(database="reachable", result=result), 200
    except Exception:
        # Do not expose connection strings, credentials, or stack traces.
        app.logger.exception("Database connectivity check failed")
        return jsonify(error="database_unavailable"), 503

@app.get("/api/")
def api_root():
    return jsonify(message="Three-tier capstone API", health="/api/health"), 200
