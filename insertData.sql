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
       (5, 'ZAZ', '965', 'AB32145BR', 1962, 650, 33114466, 1);

-- Place one in each category.
insert into CATA
values (0, 115, 0, 'OUTATIME'),
       (3, 100, 1, 'AA22221MM');

insert into CATB
values (1, 4, 0, 'B00M'),
       (4, 2, 1, 'US32410SR');

insert into CATC
values (2, 500, 0, 'TESTREG'),
       (5, 20, 1, 'AB32145BR');

-- Add two personnel per business.
insert into STAFF
values (0, 1300, 'Hasen Bojinov', 1969, 'M', 0),
       (1, 2400, 'Albanas Sedzhekiev', 1976, 'M', 0);

insert into STAFF
values (2, 5650, 'Radoslava Radomirova', 1989, 'F', 1),
       (3, 900, 'Enza Castro', 1955, 'F', 1);

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
values (2, 0, 'OUTATIME', PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1576972800)) -
                          PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1576713600)), 20000,
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1576713600)),
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1576972800)), 10000),
       (0, 1, 'B00M', PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1583712000)) -
                      PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1583020800)), 24000,
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1583020800)),
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1583712000)), 3000),
       (4, 5, 'AB32145BR', PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1592438400)) -
                           PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1591401600)), 120000,
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1591401600)),
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1592438400)), 10001),
       (1, 5, 'AB32145BR', PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1581292800)) -
                           PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1580601600)), 90000,
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1580601600)),
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1581292800)), 10000),
       (3, 4, 'US32410SR', PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1585353600)) -
                           PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1584144000)), 100000,
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1584144000)),
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1585353600)), 8000),
       (5, 3, 'AA22221MM', PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1592611200)) -
                           PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1592179200)), 30000,
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1592179200)),
        PETAR_NIKO_PROTECTED.ttu(PETAR_NIKO_PROTECTED.utt(1592611200)), 10000);


