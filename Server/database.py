from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABSE_URL = "postgresql://postgres:240805@localhost:5432/fluttermusicapp"
engine = create_engine(DATABSE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()