from sqlalchemy import create_engine
from sqlalchemy.engine import URL
import os

#DATABASE_URL = "postgresql://postgres:NewStr0ngP@ssw0rd!@localhost:5432/infrasight"
# build URL safely (reads values from env with sane defaults)
db_user = os.getenv("DB_USER", "postgres")
db_pass = os.getenv("DB_PASS", "NewStr0ngP@ssw0rd!")
db_host = os.getenv("DB_HOST", "localhost")
db_port = os.getenv("DB_PORT", "5432")
db_name = os.getenv("DB_NAME", "infrasight")

db_url = URL.create(
    "postgresql+psycopg2",
    username=db_user,
    password=db_pass,
    host=db_host,
    port=int(db_port),
    database=db_name,
)

#dburl = "postgresql://postgres:NewStr0ngP@ssw0rd!@localhost:5432/omtechvl"
engine = create_engine(db_url)
#engine = create_engine(DATABASE_URL, echo=True)
