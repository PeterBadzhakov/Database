set schema PETAR_NIKO_PROTECTED;

-- Converts Unix time to Timestamp
CREATE OR REPLACE FUNCTION utt(start_time int)
    RETURNS timestamp
BEGIN
    ATOMIC
    DECLARE epoch timestamp default TIMESTAMP('1970-01-01-00.00.00.000000');
    DECLARE result timestamp;

    SET result = epoch + start_time seconds;
    RETURN result;
END;

-- Converts Timestamp to Unix time.
CREATE OR REPLACE FUNCTION ttu(start_timestamp timestamp)
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

CREATE OR REPLACE PROCEDURE fix_car(IN vin CHARACTER(17), IN reg VARCHAR(10))
    MODIFIES SQL DATA
BEGIN
    -- Fix Engine.
    UPDATE CARS
    SET BHP = 100 -- Realistically, check real value in owner's manual.
    WHERE CARS.cvin = vin
      AND CARS.REGNUMBER = reg;
    -- Fix Compression.
    UPDATE CATA
    SET CATA.COMPRESSION = 100 -- Realistically, check real value in owner's manual.
    WHERE CATA.CVIN = vin
      AND CATA.REGNUMBER = reg;
    -- Fix Seatcount.
    UPDATE CATB
    SET CATB.SEATCOUNT = 4 -- Realistically, check real value in owner's manual.
    WHERE CATB.CVIN = vin
      AND CATB.REGNUMBER = reg;
    -- Fix CargoHold.
    UPDATE CATC
    SET CATC.CARGOHOLD = 500 -- Realistically, check real value in owner's manual.
    WHERE CATC.CVIN = vin
      AND CATC.CARGOHOLD = reg;
END;

CREATE OR REPLACE PROCEDURE damage_car(IN vin CHARACTER(17), IN reg VARCHAR(10))
    MODIFIES SQL DATA
BEGIN
    -- Break Engine.
    UPDATE CARS
    SET BHP = 0
    WHERE CARS.cvin = vin
      AND CARS.REGNUMBER = reg;
    -- Break Compression.
    UPDATE CATA
    SET CATA.COMPRESSION = 0
    WHERE CATA.CVIN = vin
      AND CATA.REGNUMBER = reg;
    -- Break Seatcount.
    UPDATE CATB
    SET CATB.SEATCOUNT = 0
    WHERE CATB.CVIN = vin
      AND CATB.REGNUMBER = reg;
    -- Break CargoHold.
    UPDATE CATC
    SET CATC.CARGOHOLD = 0
    WHERE CATC.CVIN = vin
      AND CATC.CARGOHOLD = reg;
END;

CREATE OR REPLACE FUNCTION get_category(vin CHAR(17))
    RETURNS CHAR(1)
BEGIN
    DECLARE cat CHAR(1);

    IF (0 < (SELECT COUNT(*) FROM CATA WHERE CVIN = vin)) THEN
        SET cat = 'A';
    ELSEIF (0 < (SELECT COUNT(*) FROM CATB WHERE CVIN = vin)) THEN
        SET cat = 'B';
    ELSEIF (0 < (SELECT COUNT(*) FROM CATC WHERE CVIN = vin)) THEN
        SET cat = 'C';
    ELSE
        SET cat = '0';
    END IF;

    RETURN cat;
END;

CREATE OR REPLACE FUNCTION get_color(col BIGINT)
    RETURNS CHAR(1)
BEGIN
    -- Three color octets.
    DECLARE red BIGINT;
    DECLARE green BIGINT;
    DECLARE blue BIGINT;
    DECLARE red_align BIGINT;
    DECLARE green_align BIGINT;
    DECLARE blue_align BIGINT;

    SET red = 255;
    SET green = 255;
    SET blue = 255;
    SET red_align = col / (256*256*256);
    SET green_align = col / (256*256);
    SET blue_align = col / 256;

    -- col := red * 2^24 OR green * 2^16 OR blue * 2^8 OR luminance.
    -- Capture color values and remove the exponent.
    SET red = CAST(BITAND(red_align, red) AS INTEGER);
    SET green = CAST(BITAND(green_align, green) AS INTEGER);
    SET blue = CAST(BITAND(blue_align, blue) AS INTEGER);

    -- The maximum of the values is the main color;
    IF (red >= green AND red >= blue) THEN
        RETURN 'R';
    ELSEIF (green >= red AND green >= blue) THEN
        RETURN 'G';
    ELSEIF (blue >= red AND blue >= green) THEN
        RETURN 'B';
    END IF;

    RETURN '0';
END;
