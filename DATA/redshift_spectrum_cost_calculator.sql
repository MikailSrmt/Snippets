select current_user_id; -- get your user_id

SELECT * -- put your user_id and find the query you just run and get query id from query column
FROM SVL_S3QUERY_SUMMARY
where userid = {{user_id}}
order by starttime desc;

SELECT -- get the cost
   round(1.0*sum(s3_scanned_bytes/1024/1024/1024/1024),4) s3_scanned_tb,
   round(1.0*5*sum(s3_scanned_bytes/1024/1024/1024/1024),2) cost_in_usd
FROM (
SELECT sum(s3_scanned_bytes) s3_scanned_bytes
FROM (SELECT s3_scanned_bytes
      FROM SVL_S3QUERY_SUMMARY
      WHERE query = {{query_id}})) ;
