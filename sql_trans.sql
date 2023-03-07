DROP SCHEMA IF EXISTS ome2_tn CASCADE;
CREATE SCHEMA ome2_tn;

DROP TYPE IF EXISTS form_of_way_value;
CREATE TYPE form_of_way_value AS ENUM (
    'bicycle_road', 
    'dual_carriage_way',
    'enclosed_traffic_area',
    'entrance_or_exit_car_park',
    'entrance_or_exit_service',
    'freeway',
    'motorway',
    'pedestrian_zone',
    'roundabout',
    'service_road',
    'single_carriage_way',
    'slip_road',
    'tractor',
    'traffic_square',
    'walkway'
);

DROP TYPE IF EXISTS functional_road_class_value;
CREATE TYPE functional_road_class_value AS ENUM (
    'main_road', 
    'first_class',
    'second_class',
    'third_class',
    'fourth_class',
    'fifth_class',
    'sixth_class',
    'seventh_class',
    'eighth_class',
    'ninth_class'
);

DROP TYPE IF EXISTS vertical_position_value;
CREATE TYPE vertical_position_value AS ENUM (
    'on_ground_surface', 
    'suspended_or_elevated',
    'underground'
);

DROP TYPE IF EXISTS ten_t_network_value;
CREATE TYPE ten_t_network_value AS ENUM (
    'comprehensive_ten_t_network', 
    'core_ten_t_network',
    'no_ten_t_network'
);

DROP TYPE IF EXISTS road_surface_category_value;
CREATE TYPE road_surface_category_value AS ENUM (
    'paved', 
    'unpaved'
);

-- pas trouvé dans diagrammes UML
DROP TYPE IF EXISTS link_direction_value;
CREATE TYPE link_direction_value AS ENUM (
    'both_directions',
    'indirection',  
    'opposite_direction'
);

DROP TYPE IF EXISTS access_restriction_value;
CREATE TYPE access_restriction_value AS ENUM (
    'forbidden_legally',
    'physically_impossible',
    'private',
    'public_access',
    'seasonal',
    'toll'
);

DROP TYPE IF EXISTS condition_of_facility_value;
CREATE TYPE condition_of_facility_value AS ENUM (
    'disused',
    'functional',
    'projected',
    'under_construction',
    'decommissioned'
);

DROP TYPE IF EXISTS form_of_road_node_value;
CREATE TYPE form_of_road_node_value AS ENUM (
    'enclosed_traffic_area',
    'interchange',
    'junction',
    'level_crossing',
    'pseudo_node',
    'road_end',
    'roundabout',
    'traffic_square',
    'road_service_area'
);

DROP TYPE IF EXISTS road_service_type_value;
CREATE TYPE road_service_type_value AS ENUM (
    'bus_station',
    'parking',
    'rest_area',
    'toll' --,
    --'electric_car_loading_stations' valeur présente dans specs mais pas dans diagrammes UML
);

DROP TYPE IF EXISTS railway_type_value;
CREATE TYPE railway_type_value AS ENUM (
    'cog_railway',
    'funicular',
    'magnetic_levitation',
    'metro',
    'monorail',
    'suspended_rail',
    'train',
    'tramway'
);

DROP TYPE IF EXISTS railway_use_value;
CREATE TYPE railway_use_value AS ENUM (
    'cargo',
    'passenger',
    'mixed',
    'car_shuttle'
);


-------- ROAD NETWORK --------

-- Road_link
DROP TABLE IF EXISTS ome2_tn.road_link CASCADE;
CREATE TABLE ome2_tn.road_link (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(LINESTRINGZ, 4326),
    country varchar(8),
    form_of_way form_of_way_value,
    functional_road_class functional_road_class_value,
    number_of_lanes integer,
	vertical_position vertical_position_value,
	trans_european_transport_network ten_t_network_value,
	geographical_name varchar(255), --normalement porté par road
	road_surface_category road_surface_category_value,
	traffic_flow_direction link_direction_value,
	access_restriction access_restriction_value,
	condition_of_facility condition_of_facility_value,
    begin_lifespan_version timestamp,
    end_lifespan_version timestamp,
    valid_from timestamp,
    valid_to timestamp   
);

-- Road_node
DROP TABLE IF EXISTS ome2_tn.road_node CASCADE;
CREATE TABLE ome2_tn.road_node (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(POINTZ, 4326),
    country varchar(8),
    form_of_road_node form_of_road_node_value,
    begin_lifespan_version timestamp,
    end_lifespan_version timestamp,
    valid_from timestamp,
    valid_to timestamp
);

-- Road_service
DROP TABLE IF EXISTS ome2_tn.road_service CASCADE;
CREATE TABLE ome2_tn.road_service (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(POINT, 4326),
    country varchar(8),
    geom_area GEOMETRY(MULTIPOLYGONZ, 4326),
    type road_service_type_value,
    geographical_name varchar(255), -- field called 'name' in specs, renamed as geographical_name for harmonisation
    begin_lifespan_version timestamp,
    end_lifespan_version timestamp,
    valid_from timestamp,
    valid_to timestamp
);

-- Marker_post
DROP TABLE IF EXISTS ome2_tn.marker_post CASCADE;
CREATE TABLE ome2_tn.marker_post (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(POINT, 4326),
    country varchar(8),
    link_to_road varchar(255),
    code varchar(255),
    distance real,
    begin_lifespan_version timestamp,
    end_lifespan_version timestamp,
    valid_from timestamp,
    valid_to timestamp
);

-------- RAILWAY NETWORK --------

-- Railway_link
DROP TABLE IF EXISTS ome2_tn.railway_link CASCADE;
CREATE TABLE ome2_tn.railway_link (
    inspireid serial not null PRIMARY KEY,
    geom geometry(LineStringZ, 4326),
    country varchar(8),
    type railway_type_value,
    number_of_tracks integer,
    vertical_position vertical_position_value,
    trans_european_transport_network ten_t_network_value,
    electrified boolean,
    begin_lifespan_version timestamp,
    end_lifespan_version timestamp,
    valid_from timestamp,
    valid_to timestamp
);

-- Railway_station
DROP TABLE IF EXISTS ome2_tn.railway_station CASCADE;
CREATE TABLE ome2_tn.railway_station (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(POINTZ, 4326),
    country varchar(8),
    geom_area GEOMETRY(MULTIPOLYGONZ, 4326),
    station_code varchar(255),
    railway_use railway_use_value,
    begin_lifespan_version timestamp,
    end_lifespan_version timestamp,
    valid_from timestamp,
    valid_to timestamp
);
