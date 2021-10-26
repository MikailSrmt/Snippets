-- The following example shows encoding, distribution style, sorting, and data skew for all user-defined tables in the database.
select "table", encoded, diststyle, sortkey1, skew_sortkey1, skew_rows
from svv_table_info
order by 1;