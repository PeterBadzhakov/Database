set schema PETAR_NIKO_PROTECTED;

-- Converts Unix time to Timestamp
CREATE FUNCTION utt(start_time int)
RETURNS timestamp
BEGIN ATOMIC
    DECLARE epoch timestamp default TIMESTAMP('1970-01-01-00.00.00.000000');
    DECLARE result timestamp;

    SET result = epoch + start_time seconds;
    RETURN result;
END;

-- Converts Timestamp to Unix time.
CREATE FUNCTION ttu(start_timestamp timestamp)
RETURNS int
BEGIN ATOMIC
    /*
     Int
days_from_civil(Int y, unsigned m, unsigned d) noexcept
{
    static_assert(std::numeric_limits<unsigned>::digits >= 18,
             "This algorithm has not been ported to a 16 bit unsigned integer");
    static_assert(std::numeric_limits<Int>::digits >= 20,
             "This algorithm has not been ported to a 16 bit signed integer");
    y -= m <= 2;
    const Int era = (y >= 0 ? y : y-399) / 400;
    const unsigned yoe = static_cast<unsigned>(y - era * 400);      // [0, 399]
    const unsigned doy = (153*(m + (m > 2 ? -3 : 9)) + 2)/5 + d-1;  // [0, 365]
        (m > 2 ? -3 : 9)
        + m
        *153
        +2
        /5
        + d-1
    const unsigned doe = yoe * 365 + yoe/4 - yoe/100 + doy;         // [0, 146096]
    return era * 146097 + static_cast<Int>(doe) - 719468;
}
     */
    DECLARE y INT;
    SET y = YEAR(start_timestamp);
    DECLARE m INT;
    SET m = MONTH(start_timestamp);
    DECLARE d INT;
    SET d = DAYS(start_timestamp);

    IF (m <= 2) THEN
        SET y = y - 1;
    END IF;

    DECLARE era INT;
    IF (y >= 0) THEN
        SET era = y;
    ELSE
        SET era = y - 399;
    end if;
    SET era = era / 400;

    DECLARE yoe INT;
    SET yoe = y - era * 400;

    DECLARE doy INT;
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

    DECLARE doe INT;
    SET doe = yoe * 365;
    SET doe = doe + yoe/4;
    SET doe = doe - yoe/100;
    SET doe = doe + doy;

    DECLARE res INT;
    SET res = era * 146097 + doe - 719468;
    SET res = res * 24 * 60 * 60;

    RETURN res;
END;


CREATE FUNCTION fix_car(vin CHARACTER(17), reg VARCHAR(10))
RETURNS VARCHAR(1)
MODIFIES SQL DATA
BEGIN
    -- Fix Engine.
    UPDATE CARS
        SET BHP = 100 -- Realistically, check real value in owner's manual.
        WHERE CARS.cvin = vin AND CARS.REGNUMBER = reg;
    -- Fix Compression.
    UPDATE CATA
        SET CATA.COMPRESSION = 100 -- Realistically, check real value in owner's manual.
        WHERE CATA.CVIN = vin AND CATA.REGNUMBER = reg;
    -- Fix Seatcount.
    UPDATE CATB
        SET CATB.SEATCOUNT = 4 -- Realistically, check real value in owner's manual.
        WHERE CATB.CVIN = vin AND CATB.REGNUMBER = reg;
    -- Fix CargoHold.
    UPDATE CATC
        SET CATC.CARGOHOLD = 500 -- Realistically, check real value in owner's manual.
        WHERE CATC.CVIN = vin AND CATC.CARGOHOLD = reg;

RETURN '';
END;

CREATE FUNCTION damage_car(vin CHARACTER(17), reg VARCHAR(10))
RETURNS VARCHAR(1)
MODIFIES SQL DATA
BEGIN
    -- Break Engine.
    UPDATE CARS
        SET BHP = 0
        WHERE CARS.cvin = vin AND CARS.REGNUMBER = reg;
    -- Break Compression.
    UPDATE CATA
        SET CATA.COMPRESSION = 0
        WHERE CATA.CVIN = vin AND CATA.REGNUMBER = reg;
    -- Break Seatcount.
    UPDATE CATB
        SET CATB.SEATCOUNT = 0
        WHERE CATB.CVIN = vin AND CATB.REGNUMBER = reg;
    -- Break CargoHold.
    UPDATE CATC
        SET CATC.CARGOHOLD = 0
        WHERE CATC.CVIN = vin AND CATC.CARGOHOLD = reg;

RETURN '';
END;
