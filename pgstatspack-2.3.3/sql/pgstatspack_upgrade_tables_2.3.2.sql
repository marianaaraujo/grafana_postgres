SET client_min_messages TO error;
-- Upgrade pgstatspack schema tables.	
--
-- By mail@meo.bogliolo.name
--

insert into pgstatspack_version values('2.3.2');

CREATE TABLE pgstatspack_activity
(
  snapid bigint NOT NULL,
  procpid integer,
  user_name_id integer,
  application_name_id integer,
  client_addr inet,
  waiting boolean,
  query_id integer,
  CONSTRAINT pgstatspack_activity_pkey PRIMARY KEY (snapid, procpid)
);

create view pgstatspack_activity_v as
SELECT snapid, procpid, n1.name as user_name, n2.name as application_name, client_addr, waiting, n3.name as current_query
FROM pgstatspack_activity
JOIN pgstatspack_names n1 on n1.nameid=user_name_id
JOIN pgstatspack_names n2 on n2.nameid=application_name_id
JOIN pgstatspack_names n3 on n3.nameid=query_id;
