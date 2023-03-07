DROP TABLE IF EXISTS ome2_ib.international_boundary_node;
CREATE TABLE IF NOT EXISTS ome2_ib.international_boundary_node
(
    inspireid uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    geom geometry(Point,4326),
    country character varying(8) COLLATE pg_catalog."default",
    legal_status legal_status_value_type,
    technical_status technical_status_value_type
);

DROP TABLE IF EXISTS ome2_ib.international_boundary_line;
CREATE TABLE IF NOT EXISTS ome2_ib.international_boundary_line
(
    inspireid uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
	geom geometry(LineString,4326),
    country character varying(200) COLLATE pg_catalog."default",
    legal_status character varying(200) COLLATE pg_catalog."default",
    technical_status character varying(200) COLLATE pg_catalog."default"
);
