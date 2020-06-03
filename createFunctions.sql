-- function: UNIX -> Date()
-- function: map numbers to colors
-- function: fix car
set schema PETAR_NIKO_PROTECTED;

CREATE FUNCTION utod(epoch_time int)
RETURNS DATE
BEGIN ATOMIC
    DECLARE start DATE;
    SET start = ADD_SECONDS(DATE '1970-01-01', epoch_time);
END;


