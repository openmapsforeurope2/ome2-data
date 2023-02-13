CREATE TYPE administrative_hierarchy_level_type AS ENUM (
'1st_order', 
'2nd_order',
'3rd_order',
'4th_order',
'5th_order',
'6th_order');

CREATE TYPE legal_status_value_type AS ENUM (
'agreed', 
'not_agreed');

CREATE TYPE technical_status_value_type AS ENUM (
'edge_matched', 
'calculated',
'not_edge_matched');

DROP TABLE IF EXISTS simplified_model.administrative_unit;
CREATE TABLE simplified_model.administrative_unit (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(MULTIPOLYGON, 3035),
    country varchar(8),
    national_code varchar(30),
    national_level administrative_hierarchy_level_type,
	begin_lifespan_version TIMESTAMP,
	end_lifespan_version TIMESTAMP,
	national_level_name varchar(255),
	residence_of_authority varchar(30)
);

DROP TABLE IF EXISTS simplified_model.administrative_boundary;
CREATE TABLE simplified_model.administrative_boundary (
    id serial not null PRIMARY KEY,
    geom GEOMETRY(MULTILINESTRING, 3035),
    country varchar(8),
    national_level administrative_hierarchy_level_type,
	begin_lifespan_version TIMESTAMP,
	end_lifespan_version TIMESTAMP,
	legal_status legal_status_value_type,
	technical_status technical_status_value_type
);

