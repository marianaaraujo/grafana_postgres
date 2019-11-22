SET client_min_messages TO error;
-- Create pgstatspack_snap procedure.
--
-- By frits.hoogland@interaccess.nl
-- Based on Glenn.Fawcett@Sun.com's snap procedure
-- meo 2 months online
-- meo Space Usage collection

CREATE OR REPLACE FUNCTION pgstatspack_delete_snap () returns varchar(512) AS $$
DECLARE
  old_snap_time TIMESTAMP;
  old_snap_id BIGINT;
  message VARCHAR(512);
BEGIN
  SELECT current_timestamp - interval '62 days' INTO old_snap_time;

  SELECT max(snapid) INTO old_snap_id FROM pgstatspack_snap WHERE ts < old_snap_time;

  SELECT 'Deleted '||count(snapid)||' snapshots older than '||old_snap_time
  INTO message 
  FROM pgstatspack_snap 
  WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_snap WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_database WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_tables WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_indexes WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_sequences WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_settings WHERE snapid <= old_snap_id;
  
  DELETE FROM pgstatspack_statements WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_bgwriter WHERE snapid <= old_snap_id;

  DELETE FROM pgstatspack_activity WHERE snapid <= old_snap_id;

  INSERT INTO pgstatspack_space_usage(schema,sizek,ts)
  select rolname,sum(relpages*8), current_timestamp
    from pg_class, pg_roles
   where relowner=pg_roles.oid
   group by rolname;

  RETURN message;
END;
$$ LANGUAGE plpgsql;

