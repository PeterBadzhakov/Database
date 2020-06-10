SET SCHEMA PETAR_NIKO_PROTECTED;

-- Check that new date interval does not intersect with current date interval of same car.
DROP TRIGGER Rent_valid_date;
CREATE TRIGGER Rent_valid_date
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
         RENTS;

-- Upon removing a staff member, next one to last one's customers.
DROP TRIGGER fire_staff;
CREATE TRIGGER fire_staff
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
