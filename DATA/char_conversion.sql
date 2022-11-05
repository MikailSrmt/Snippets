--TO_CHAR converts a timestamp or numeric expression to a character-string data format.

select to_char(timestamp '2009-12-31 23:15:59', 'MONTH-DY-DD-YYYY HH12:MIPM');
