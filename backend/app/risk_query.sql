SELECT
  a.id,
  a.name,
  a.domain,
  a.asset_type,

  -- 🔥 NEW: geometry type (POINT / LINESTRING / POLYGON)
  GeometryType(a.geom) AS geom_type,

  -- 🔥 NEW: always return GeoJSON (safe for all geometry types)
  ST_AsGeoJSON(a.geom) AS geometry,

  -- Risk scores (unchanged)
  CASE WHEN EXISTS (
    SELECT 1 FROM flood_zones f
    WHERE ST_Intersects(a.geom, f.geom)
  ) THEN 30 ELSE 0 END AS flood_score,

  CASE WHEN EXISTS (
    SELECT 1 FROM cyclone_zones c
    WHERE ST_Intersects(a.geom, c.geom)
  ) THEN 25 ELSE 0 END AS cyclone_score,

  CASE WHEN EXISTS (
    SELECT 1 FROM vegetation v
    WHERE ST_DWithin(a.geom::geography, v.geom::geography, 10)
  ) THEN 15 ELSE 0 END AS vegetation_score,

  CASE WHEN (EXTRACT(YEAR FROM CURRENT_DATE) - a.install_year) > 10
       THEN 20 ELSE 0 END AS age_score,

  CASE WHEN (CURRENT_DATE - a.last_inspection) > 365
       THEN 10 ELSE 0 END AS inspection_score

FROM assets a;
