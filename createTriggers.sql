SET SCHEMA PETAR_NIKO_PROTECTED;

-- Check that new date interval does not intersect with current date interval of same car.
CREATE OR REPLACE TRIGGER Rent_valid_date
    BEFORE INSERT
    ON RENTS
    REFERENCING NEW AS N
    FOR EACH ROW
    WHEN (
                0 < (select COUNT(*)
                     from (select *
                           from RENTS curr
                           where N.CVIN = curr.CVIN
                               AND
                                 (N.STARTDATE > curr.STARTDATE AND N.STARTDATE < curr.ENDDATE)
                              OR (N.ENDDATE > curr.STARTDATE AND N.ENDDATE < curr.ENDDATE)
                              OR (N.STARTDATE < curr.STARTDATE AND N.ENDDATE > curr.ENDDATE)
                          ))
            AND
                N.CVIN in (SELECT CVIN
                           FROM PETAR_NIKO_PROTECTED.available_cars)
        )
    SIGNAL SQLSTATE 'ER001' SET MESSAGE_TEXT = 'THIS IS AN ILLEGAL INSERT';
    /* OLDER VERSION!!! currently NOT USED!!!
    select *
    from RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS,
         RENTS;*/

--Check if a branch is added in a city which already has one.
CREATE OR REPLACE TRIGGER Branch_city
    BEFORE INSERT
    ON BRANCHES
    REFERENCING NEW AS N
    FOR EACH ROW
    WHEN (N.CITY in (select CITY from BRANCHES))
SIGNAL SQLSTATE 'ER001' SET MESSAGE_TEXT = 'THIS IS AN ILLEGAL INSERT';

--Check to see if the staff we hire are young enough.
Create OR REPLACE Trigger Check_staff
BEFORE INSERT
    ON STAFF
    REFERENCING NEW AS N
    FOR EACH ROW
    WHEN((N.DOB > 1992) --at least 18 years old
        or (N.DOB <= 1950 )--we hire only young staff
        or (N.Salary >= 6000))
    SIGNAL SQLSTATE 'ER001' SET MESSAGE_TEXT = 'THIS IS AN ILLEGAL INSERT';


-- Upon removing a staff member, next one to last one's customers.
CREATE OR REPLACE TRIGGER fire_staff
    BEFORE DELETE
    ON STAFF
    REFERENCING OLD AS O
    FOR EACH ROW
    -- Need at least two staff members, so one can be kicked.
    WHEN (2 <= (SELECT COUNT(*)
                FROM STAFF))
BEGIN
    DECLARE replacement INT;
    SET replacement = (select MIN(SID) FROM STAFF WHERE SID != O.SID);
    UPDATE CUSTOMERS
    SET SID = replacement
    WHERE SID = O.SID;

END;

