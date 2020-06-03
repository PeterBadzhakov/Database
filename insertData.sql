set schema PETAR_NIKO_PROTECTED;

-- Create branches.
insert into BRANCHES
values (0, 'Burgas', 'Bulgaria', 'Bogoridi 1', '9303030'),
       (1, 'Skopje', 'Republic West Bulgaria', 'Macedonia 69', '69696969');

-- Add cars to Burgas.
insert into CARS
values (0, 'Ferrari', '599xx Evo', 'OUTATIME', 2003, 740, 16720435, 0),
       (1, 'Dodge', 'Viper ACR', 'B00M', 2017, 645, 2293555, 0),
       (2, 'Lada', '1500', 'TESTREG', 1968, 72, 3351295, 0);

-- Add cars to Skopje.
insert into CARS
values (3, 'Ferrari', 'Enzo', 'AA22221MM', 2003, 651, 16720435, 1),
       (4, 'Lamborghini', 'Murcielago', 'US32410SR', 2006, 650, 19230110, 1),
       (5, 'ZAZ', '965', 'AB32145BR', 1962, 75, 33114466, 1);

-- Place one in each category.
insert into CATA
values (0, 115, 0, 'OUTATIME'),
       (3, 100, 1, 'AA22221MM');

insert into CATB
values (1, 4, 0, 'B00M'),
       (4, 2, 1, 'US32410SR');

insert into CATC
values (2, 500, 0, 'TESTREG'),
       (5, 400, 1, 'AB32145BR');

-- Add two personnel per business.
insert into STAFF
values (0, 1300, 'Hasen Bojinov', 1969, 'M', 0),
       (1, 2400, 'Albanas Sedzhekiev', 1976, 'M', 0);

insert into STAFF
values (2, 5650, 'Radoslava Radomirova', 1989, 'F', 1),
       (3, 900, 'Enza Castro', 1776, 'F', 1);

-- Add one staff per customer.
insert into CUSTOMERS
values (0, 'Petkan Razan', 0, 0),
       (1, 'Radomir Gadzhev', 0, 0),
       (2, 'Yulian Purvanov', 1, 0);

insert into CUSTOMERS
values (3, 'Anton Antonov', 2, 1),
       (4, 'Peter Badzhakov', 3, 1),
       (5, 'Niko Meshkov', 3, 1);

-- Add some starting rents, we also keep past contracts.
insert into RENTS
values (2, 0, 'OUTATIME', ttu('22-12-2019') - ttu('20-12-2019'), 20000, ttu('20-12-2019'), ttu('22-12-2019'), 10000),
       (0, 1, 'B00M', ttu('09-03-2020') - ttu('01-03-2020'), 24000, ttu('01-03-2020'), ttu('09-03-2020'), 3000),
       (4, 5, 'AB32145BR', ttu('18-06-2020') - ttu('06-06-2020'), 120000, ttu('06-06-2020'), ttu('18-2020'), 10000),
       (1, 5, 'AB32145BR', ttu('10-02-2020') - ttu('02-02-2020'), 90000, ttu('02-02-2020'), ttu('10-02-2020'), 10000),
       (3, 4, 'US32410SR', ttu('28-03-2020') - ttu('14-03-2020'), 100000, ttu('14-03-2020'), ttu('28-03-2020'), 8000),
       (5, 2, 'TESTREG', ttu('20-06-2020') - ttu('15-06-2020'), 5000, ttu('15-06-2020'), ttu('20-06-2020'), 100);
