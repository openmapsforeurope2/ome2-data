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
'walkway');

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
'ninth_class');

DROP TYPE IF EXISTS vertical_position_value;
CREATE TYPE vertical_position_value AS ENUM (
'on_ground_surface', 
'suspended_or_elevated',
'underground');

DROP TYPE IF EXISTS ten_t_network_value;
CREATE TYPE ten_t_network_value AS ENUM (
'comprehensive_ten_t_network', 
'core_ten_t_network',
'no_ten_t_network');

DROP TYPE IF EXISTS road_surface_category_value;
CREATE TYPE road_surface_category_value AS ENUM (
'paved', 
'unpaved');

-- pas trouvé dans diagrammes UML
DROP TYPE IF EXISTS link_direction_value;
CREATE TYPE link_direction_value AS ENUM (
'both_directions',
'indirection',  
'opposite_direction');

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
--'electric_car_loading_stations'
);

DROP TABLE IF EXISTS ome2_tn.road_link CASCADE;
CREATE TABLE ome2_tn.road_link (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(LINESTRING, 4326),
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
	condition_of_facility condition_of_facility_value    
);

DROP TABLE IF EXISTS ome2_tn.road_node CASCADE;
CREATE TABLE ome2_tn.road_node (
    inspireid serial not null PRIMARY KEY,
    geom GEOMETRY(POINT, 4326),
    country varchar(8),
    form_of_road_node form_of_road_node_value
);


