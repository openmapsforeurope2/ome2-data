GRANT CONNECT ON DATABASE ome2_hvlsp_v1 TO PUBLIC;

GRANT g_ome2_user TO ome2_user;

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
