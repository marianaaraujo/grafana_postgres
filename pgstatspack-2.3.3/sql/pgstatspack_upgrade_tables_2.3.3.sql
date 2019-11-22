SET client_min_messages TO error;
-- Upgrade pgstatspack schema tables.	
--
-- By mail@meo.bogliolo.name
--

insert into pgstatspack_version values('2.3.3');

DROP TABLE IF EXISTS pgstatspack_activity;
CREATE TABLE pgstatspack_activity
(
  snapid bigint NOT NULL,
  count_star integer,
  user_name_id integer,
  application_name_id integer,
  client_addr inet,
  waiting boolean,
  working boolean,
  CONSTRAINT pgstatspack_activity_pkey PRIMARY KEY (snapid, user_name_id, application_name_id, client_addr, waiting, working)
);

create or replace view pgstatspack_activity_v as
SELECT snapid, count_start, n1.name as user_name, n2.name as application_name, client_addr, waiting, working
FROM pgstatspack_activity
JOIN pgstatspack_names n1 on n1.nameid=user_name_id
JOIN pgstatspack_names n2 on n2.nameid=application_name_id;
