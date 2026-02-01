CREATE EXTENSION IF NOT EXISTS postgis;

-- Assets
CREATE TABLE assets (
    id SERIAL PRIMARY KEY,
    name TEXT,
    domain TEXT,
    asset_type TEXT,
    install_year INT,
    last_inspection DATE,
    geom GEOMETRY(Point, 4326)
);

-- Flood Zones
CREATE TABLE flood_zones (
    id SERIAL PRIMARY KEY,
    risk_level INT,
    geom GEOMETRY(Polygon, 4326)
);

-- Cyclone Zones
CREATE TABLE cyclone_zones (
    id SERIAL PRIMARY KEY,
    severity INT,
    geom GEOMETRY(Polygon, 4326)
);

-- Vegetation
CREATE TABLE vegetation (
    id SERIAL PRIMARY KEY,
    geom GEOMETRY(Point, 4326)
);

-- Insert Assets (Utility + Telecom)
INSERT INTO assets VALUES
(1,'Transformer-01','Utility','Transformer',2010,'2023-01-10',
 ST_SetSRID(ST_Point(83.316,17.738),4326)),
(2,'Pole-02','Utility','Pole',2008,'2022-12-01',
 ST_SetSRID(ST_Point(83.319,17.739),4326)),
(3,'Tower-01','Telecom','Tower',2012,'2023-06-15',
 ST_SetSRID(ST_Point(83.322,17.740),4326)),
(4,'Fiber-Joint-01','Telecom','Fiber Joint',2015,'2024-01-20',
 ST_SetSRID(ST_Point(83.318,17.741),4326));

-- Flood Zone
INSERT INTO flood_zones VALUES
(1,3,ST_GeomFromText(
'POLYGON((83.314 17.737,83.324 17.737,83.324 17.742,83.314 17.742,83.314 17.737))',4326));

-- Cyclone Zone
INSERT INTO cyclone_zones VALUES
(1,4,ST_GeomFromText(
'POLYGON((83.312 17.735,83.326 17.735,83.326 17.745,83.312 17.745,83.312 17.735))',4326));

-- Vegetation
INSERT INTO vegetation VALUES
(1,ST_SetSRID(ST_Point(83.317,17.7385),4326)),
(2,ST_SetSRID(ST_Point(83.321,17.7405),4326));
