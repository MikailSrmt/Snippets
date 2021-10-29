-- Performs compression analysis and produces a report with the suggested 
-- compression encoding for the tables analyzed. For each column, the report
-- includes an estimate of the potential reduction in disk space compared to 
-- the current encoding.

ANALYZE COMPRESSION "table"

