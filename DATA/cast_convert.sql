--The following two queries are equivalent. They both cast a decimal value to an integer:

select cast(user_count as integer)
from apps where app_id=100;

select user_count::integer
from apps where app_id=100;
