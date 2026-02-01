from sqlalchemy import Column, Integer, String, Date
from sqlalchemy.ext.declarative import declarative_base
from geoalchemy2 import Geometry

Base = declarative_base()

class Asset(Base):
    __tablename__ = "assets"

    id = Column(Integer, primary_key=True)
    name = Column(String)
    domain = Column(String)        # Utility / Telecom
    asset_type = Column(String)    # Transformer / Tower / Pole / Fiber
    install_year = Column(Integer)
    last_inspection = Column(Date)
    geom = Column(Geometry("POINT", srid=4326))
