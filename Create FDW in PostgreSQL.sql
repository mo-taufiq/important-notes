-- step 1
CREATE EXTENSION postgres_fdw;

-- step 2
-- create server with name "foreign_server" for foreign database, and spesify host, port, dbname
CREATE SERVER foreign_server
       FOREIGN DATA WRAPPER postgres_fdw
       OPTIONS (host 'localhost', port '5432', dbname 'foreign_database_name');

-- step 3
-- create user mapping for roles user postgres, and spesify user and password local database
CREATE USER MAPPING FOR postgres
       SERVER foreign_server
       OPTIONS (user 'postgres', password 'root');

-- step 4
-- create new schema with name "foreign_schema" on local database, 
CREATE SCHEMA foreign_schema;

-- step 5
-- import all table from foreign_server schema public to schema foreign_schema local
IMPORT FOREIGN SCHEMA public
 FROM SERVER foreign_server
 INTO foreign_schema;


-- select all foreign server
--select 
--    srvname as name, 
--    srvowner::regrole as owner, 
--    fdwname as wrapper, 
--    srvoptions as options
--from pg_foreign_server
--join pg_foreign_data_wrapper w on w.oid = srvfdw;

-- delete foreign server
--DROP server foreign_server_name;
