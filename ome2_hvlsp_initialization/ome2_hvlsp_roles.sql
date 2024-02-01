GRANT CONNECT ON DATABASE ome2_hvlsp_template TO PUBLIC;

CREATE SCHEMA au;
CREATE SCHEMA hy;
CREATE SCHEMA tn;
CREATE SCHEMA ib;

GRANT ALL ON SCHEMA au TO g_ome2_user;
GRANT ALL ON SCHEMA hy TO g_ome2_user;
GRANT ALL ON SCHEMA tn TO g_ome2_user;
GRANT ALL ON SCHEMA ib TO g_ome2_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON tables TO g_ome2_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA au GRANT ALL ON tables TO g_ome2_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA tn GRANT ALL ON tables TO g_ome2_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA hy GRANT ALL ON tables TO g_ome2_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA ib GRANT ALL ON tables TO g_ome2_user;

GRANT g_ome2_read TO ome2_read;
GRANT USAGE ON SCHEMA au TO g_ome2_read;
GRANT USAGE ON SCHEMA hy TO g_ome2_read;
GRANT USAGE ON SCHEMA tn TO g_ome2_read;
GRANT USAGE ON SCHEMA ib TO g_ome2_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON tables TO g_ome2_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA au GRANT SELECT ON tables TO g_ome2_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA tn GRANT SELECT ON tables TO g_ome2_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA hy GRANT SELECT ON tables TO g_ome2_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA ib GRANT SELECT ON tables TO g_ome2_read;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO g_ome2_read;
GRANT SELECT ON ALL TABLES IN SCHEMA au TO g_ome2_read;
GRANT SELECT ON ALL TABLES IN SCHEMA tn TO g_ome2_read;
GRANT SELECT ON ALL TABLES IN SCHEMA hy TO g_ome2_read;
GRANT SELECT ON ALL TABLES IN SCHEMA ib TO g_ome2_read;


-- Pour ome2_carto
GRANT USAGE ON SCHEMA au TO g_ome2_carto;
GRANT USAGE ON SCHEMA hy TO g_ome2_carto;
GRANT USAGE ON SCHEMA tn TO g_ome2_carto;
GRANT USAGE ON SCHEMA ib TO g_ome2_carto;
GRANT USAGE ON SCHEMA public TO g_ome2_carto;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA au TO g_ome2_carto;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA hy TO g_ome2_carto;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA tn TO g_ome2_carto;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ib TO g_ome2_carto;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO g_ome2_carto;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON tables TO g_ome2_carto;
ALTER DEFAULT PRIVILEGES IN SCHEMA au GRANT ALL ON tables TO g_ome2_carto;
ALTER DEFAULT PRIVILEGES IN SCHEMA tn GRANT ALL ON tables TO g_ome2_carto;
ALTER DEFAULT PRIVILEGES IN SCHEMA hy GRANT ALL ON tables TO g_ome2_carto;
ALTER DEFAULT PRIVILEGES IN SCHEMA ib GRANT ALL ON tables TO g_ome2_carto;
