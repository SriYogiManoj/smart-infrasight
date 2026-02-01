from fastapi import FastAPI
from sqlalchemy import text
from app.database import engine
from pathlib import Path

app = FastAPI(title="Smart InfraSight Demo")
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # demo only
    allow_methods=["*"],
    allow_headers=["*"],
)

SQL_FILE = Path(__file__).parent / "risk_query.sql"

@app.get("/assets-risk")
def get_assets_risk():
    query = text(SQL_FILE.read_text())
    with engine.connect() as conn:
        result = conn.execute(query)
        print(result)
        return [dict(row._mapping) for row in result]
