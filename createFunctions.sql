-- function: UNIX -> Date()
-- function: map numbers to colors
-- function: fix car
set schema PETAR_NIKO_PROTECTED;

CREATE FUNCTION utt(start_time int)
RETURNS timestamp
BEGIN ATOMIC
    DECLARE epoch timestamp default TIMESTAMP('1970-01-01-00.00.00.000000');
    DECLARE result timestamp;

    SET result = epoch + start_time seconds;
    RETURN result;
END;

CREATE FUNCTION ttu(start_timestamp timestamp)
RETURNS int
RETURN 0;
/*
CREATE FUNCTION ttu(start_timestamp timestamp)
RETURNS int
BEGIN ATOMIC
DECLARE d int;
SET d = DAY(start_timestamp)*24*60*60;
DECLARE m int;
SET m = MONTH(start_timestamp)*30*24*60*60;
DECLARE y int;
SET y = YEAR(start_timestamp - 1970)*365*24*60*60;

DECLARE res int default 0;
SET res = d + m + y;
END;
 */

