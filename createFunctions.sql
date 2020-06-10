set schema PETAR_NIKO_PROTECTED;

DROP FUNCTION utt;
-- Converts Unix time to Timestamp
CREATE FUNCTION utt(start_time int)
    RETURNS timestamp
BEGIN
    ATOMIC
    DECLARE epoch timestamp default TIMESTAMP('1970-01-01-00.00.00.000000');
    DECLARE result timestamp;

    SET result = epoch + start_time seconds;
    RETURN result;
END;


DROP FUNCTION ttu;
-- Converts Timestamp to Unix time.
CREATE FUNCTION ttu(start_timestamp timestamp)
    RETURNS int
BEGIN
    DECLARE y INT;
    DECLARE m INT;
    DECLARE d INT;
    DECLARE era INT;
    DECLARE yoe INT;
    DECLARE doy INT;
    DECLARE doe INT;
    DECLARE res INT;

    set y = CAST(YEAR(start_timestamp) AS INT);
    SET m = CAST(MONTH(start_timestamp) AS INT);
    SET d = CAST(DAY(start_timestamp) AS INT);

    IF (m <= 2) THEN
        SET y = y - 1;
    END IF;

    IF (y >= 0) THEN
        SET era = y;
    ELSE
        SET era = y - 399;
    end if;
    SET era = era / 400;

    SET yoe = y - era * 400;

    IF (m > 2) THEN
        SET doy = -3;
    ELSE
        SET doy = 9;
    END IF;
    SET doy = doy + m;
    SET doy = doy * 153;
    SET doy = doy + 2;
    SET doy = doy / 5;
    SET doy = doy + (d - 1);

    SET doe = yoe * 365;
    SET doe = doe + yoe / 4;
    SET doe = doe - yoe / 100;
    SET doe = doe + doy;

    SET res = era * 146097 + doe - 719468;
    SET res = res * 24 * 60 * 60;

    RETURN res;
END;

DROP FUNCTION CARS.damage_car;
CREATE FUNCTION CARS.damage_car(vin CHAR(17))
RETURNS CHAR(17)
MODIFIES SQL DATA
BEGIN
    UPDATE CARS
        SET BHP = 0
    WHERE CARS.cvin = vin;

    RETURN vin;
END;


