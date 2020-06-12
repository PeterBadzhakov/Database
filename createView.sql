set schema PETAR_NIKO_PROTECTED;

CREATE OR REPLACE VIEW currently_taken
AS
SELECT DISTINCT Rents.cVIN
FROM Rents
WHERE PETAR_NIKO_PROTECTED.utt(ENDDATE) > CURRENT_TIMESTAMP
  AND PETAR_NIKO_PROTECTED.utt(STARTDATE) < CURRENT_TIMESTAMP;


CREATE OR REPLACE VIEW broken
AS
SELECT DISTINCT CVIN
FROM (
         SELECT car.CVIN
         FROM CATA car
         WHERE car.COMPRESSION = 0
         UNION
         SELECT car.CVIN
         FROM CATB car
         WHERE car.SEATCOUNT = 0
         UNION
         SELECT car.CVIN
         FROM CATC car
         WHERE car.CARGOHOLD = 0
         UNION
         SELECT car.CVIN
         FROM CARS car
         WHERE car.BHP = 0
     );

CREATE OR REPLACE VIEW available_cars
AS
SELECT car.CVIN
FROM CARS car
WHERE car.CVIN not in (select CVIN from broken)
  AND car.CVIN not in (select CVIN from currently_taken);

create OR REPLACE view CARS_BRANCHES
as
select b.BBIC, COUNT(c.CVIN) as AVAILABLE
from BRANCHES b,
     CARS c
where c.BBIC = b.BBIC
group by b.BBIC;


