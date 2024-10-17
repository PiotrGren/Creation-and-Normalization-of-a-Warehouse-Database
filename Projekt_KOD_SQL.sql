ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';
CREATE TABLE adres_klienci (
    id_address INTEGER NOT NULL,
    city       VARCHAR2(50 CHAR) NOT NULL,
    street     VARCHAR2(50 CHAR) NOT NULL,
    post_code  VARCHAR2(12 CHAR) NOT NULL
);

ALTER TABLE adres_klienci ADD CONSTRAINT adres_klienci_pk PRIMARY KEY ( id_address );

CREATE TABLE adres_pr (
    id_address INTEGER NOT NULL,
    city       VARCHAR2(50 CHAR) NOT NULL,
    street     VARCHAR2(50 CHAR) NOT NULL,
    post_code  VARCHAR2(12 CHAR) NOT NULL
),

ALTER TABLE adres_pr ADD CONSTRAINT adres_pr_pk PRIMARY KEY ( id_address );

CREATE TABLE adres_staff (
    id_address INTEGER NOT NULL,
    city       VARCHAR2(50 CHAR) NOT NULL,
    street     VARCHAR2(50 CHAR) NOT NULL,
    post_code  VARCHAR2(12 CHAR) NOT NULL
);

ALTER TABLE adres_staff ADD CONSTRAINT adres_staff_pk PRIMARY KEY ( id_address );

CREATE TABLE country (
    id_country INTEGER NOT NULL,
    name       VARCHAR2(60 CHAR) NOT NULL,
    shortcut   VARCHAR2(3 CHAR) NOT NULL
);

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( id_country );

CREATE TABLE dostawcy (
    id_dostawcy INTEGER NOT NULL,
    co_name     VARCHAR2(80 CHAR) NOT NULL
);

ALTER TABLE dostawcy ADD CONSTRAINT dostawcy_pk PRIMARY KEY ( id_dostawcy );

CREATE TABLE dostawcy_kraj (
    dostawcy_id_dostawcy INTEGER NOT NULL,
    country_id_country   INTEGER NOT NULL
);


CREATE TABLE klienci (
    id_klienta  INTEGER NOT NULL,
    co_name     VARCHAR2(80 CHAR) NOT NULL,
    ceo         VARCHAR2(50 CHAR),
    nip         VARCHAR2(15 CHAR) NOT NULL,
    building_no INTEGER NOT NULL,
    id_address  INTEGER NOT NULL
);

CREATE UNIQUE INDEX klienci__idx ON
    klienci (
        id_address
    ASC );

ALTER TABLE klienci ADD CONSTRAINT klienci_pk PRIMARY KEY ( id_klienta );

CREATE TABLE order_cost (
    cost            NUMBER(8, 2) NOT NULL,
    payment         NUMBER NOT NULL,
    orders_id_order INTEGER NOT NULL
);

ALTER TABLE order_cost ADD CONSTRAINT order_cost_pk PRIMARY KEY ( orders_id_order );

CREATE TABLE order_dates (
    order_date       DATE NOT NULL,
    order_time       TIMESTAMP NOT NULL,
    realization_date DATE,
    realization_time TIMESTAMP,
    orders_id_order  INTEGER NOT NULL
);

ALTER TABLE order_dates ADD CONSTRAINT order_dates_pk PRIMARY KEY ( orders_id_order );

CREATE TABLE orders (
    id_order           INTEGER NOT NULL,
    quantity           INTEGER NOT NULL,
    towar_id_towaru    INTEGER NOT NULL,
    klienci_id_klienta INTEGER NOT NULL,
    staff_id_worker    INTEGER NOT NULL
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( id_order );

CREATE TABLE pr_cat (
    id_cat   INTEGER NOT NULL,
    cat_name VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE pr_cat ADD CONSTRAINT pr_cat_pk PRIMARY KEY ( id_cat );

CREATE TABLE pr_country (
    country_id_country         INTEGER NOT NULL,
    adres_pr_producent_id_prod INTEGER NOT NULL
);

ALTER TABLE pr_country ADD CONSTRAINT pr_country_pk PRIMARY KEY ( country_id_country,
                                                                  adres_pr_producent_id_prod );

CREATE TABLE pr_type (
    id_type INTEGER NOT NULL,
    name    VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE pr_type ADD CONSTRAINT pr_type_pk PRIMARY KEY ( id_type );

CREATE TABLE pr_type_cat (
    pr_cat_id_cat   INTEGER NOT NULL,
    pr_type_id_type INTEGER NOT NULL
);

ALTER TABLE pr_type_cat ADD CONSTRAINT pr_type_cat_pk PRIMARY KEY ( pr_type_id_type );

CREATE TABLE producent (
    id_prod     INTEGER NOT NULL,
    co_name     VARCHAR2(80 CHAR) NOT NULL,
    nip         VARCHAR2(12 CHAR) NOT NULL,
    building_no INTEGER NOT NULL,
    id_address  INTEGER NOT NULL
);

CREATE UNIQUE INDEX producent__idx ON
    producent (
        id_address
    ASC );

ALTER TABLE producent ADD CONSTRAINT producent_pk PRIMARY KEY ( id_prod );

CREATE TABLE sg_dates (
    order_date                   DATE NOT NULL,
    order_time                   TIMESTAMP NOT NULL,
    realization_date             DATE,
    realization_time             TIMESTAMP,
    suplement_goods_id_order_sup INTEGER NOT NULL
);

ALTER TABLE sg_dates ADD CONSTRAINT sg_dates_pk PRIMARY KEY ( suplement_goods_id_order_sup );

CREATE TABLE sg_quantity (
    quantity                     INTEGER NOT NULL,
    suplement_goods_id_order_sup INTEGER NOT NULL
);

ALTER TABLE sg_quantity ADD CONSTRAINT sg_quantity_pk PRIMARY KEY ( suplement_goods_id_order_sup );

CREATE TABLE staff (
    id_worker   INTEGER NOT NULL,
    name        VARCHAR2(30 CHAR) NOT NULL,
    surname     VARCHAR2(30 CHAR) NOT NULL,
    hire_date   DATE NOT NULL,
    phone       INTEGER,
    building_no INTEGER NOT NULL,
    local_no    INTEGER,
    id_address  INTEGER NOT NULL
);

CREATE UNIQUE INDEX staff__idx ON
    staff (
        id_address
    ASC );

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( id_worker );

CREATE TABLE suplement_goods (
    id_order_sup         INTEGER NOT NULL,
    staff_id_worker      INTEGER NOT NULL,
    producent_id_prod    INTEGER NOT NULL,
    dostawcy_id_dostawcy INTEGER NOT NULL,
    towar_id_towaru      INTEGER NOT NULL
);

ALTER TABLE suplement_goods ADD CONSTRAINT suplement_goods_pk PRIMARY KEY ( id_order_sup );

CREATE TABLE towar (
    id_towaru INTEGER NOT NULL,
    name      VARCHAR2(60 CHAR) NOT NULL
);

ALTER TABLE towar ADD CONSTRAINT towar_pk PRIMARY KEY ( id_towaru );

CREATE TABLE towar_cost (
    cost            NUMBER NOT NULL,
    towar_id_towaru INTEGER NOT NULL
);

ALTER TABLE towar_cost ADD CONSTRAINT towar_cost_pk PRIMARY KEY ( towar_id_towaru );

CREATE TABLE towar_pr_t_c (
    towar_id_towaru             INTEGER NOT NULL,
    pr_type_cat_pr_cat_id_cat   INTEGER NOT NULL,
    pr_type_cat_pr_type_id_type INTEGER NOT NULL
);

ALTER TABLE towar_pr_t_c ADD CONSTRAINT towar_pr_t_c_pk PRIMARY KEY ( towar_id_towaru );

CREATE TABLE towar_quantity (
    quantity        INTEGER NOT NULL,
    towar_id_towaru INTEGER NOT NULL
);

ALTER TABLE towar_quantity ADD CONSTRAINT towar_quantity_pk PRIMARY KEY ( towar_id_towaru );

CREATE TABLE twoar_producent (
    towar_id_towaru   INTEGER NOT NULL,
    producent_id_prod INTEGER NOT NULL
);

ALTER TABLE dostawcy_kraj
    ADD CONSTRAINT dostawcy_kraj_country_fk FOREIGN KEY ( country_id_country )
        REFERENCES country ( id_country );

ALTER TABLE dostawcy_kraj
    ADD CONSTRAINT dostawcy_kraj_dostawcy_fk FOREIGN KEY ( dostawcy_id_dostawcy )
        REFERENCES dostawcy ( id_dostawcy );

ALTER TABLE klienci
    ADD CONSTRAINT klienci_adres_klienci_fk FOREIGN KEY ( id_address )
        REFERENCES adres_klienci ( id_address );

ALTER TABLE order_cost
    ADD CONSTRAINT order_cost_orders_fk FOREIGN KEY ( orders_id_order )
        REFERENCES orders ( id_order );

ALTER TABLE order_dates
    ADD CONSTRAINT order_dates_orders_fk FOREIGN KEY ( orders_id_order )
        REFERENCES orders ( id_order );

ALTER TABLE orders
    ADD CONSTRAINT orders_klienci_fk FOREIGN KEY ( klienci_id_klienta )
        REFERENCES klienci ( id_klienta );

ALTER TABLE orders
    ADD CONSTRAINT orders_staff_fk FOREIGN KEY ( staff_id_worker )
        REFERENCES staff ( id_worker );

ALTER TABLE orders
    ADD CONSTRAINT orders_towar_fk FOREIGN KEY ( towar_id_towaru )
        REFERENCES towar ( id_towaru );

ALTER TABLE pr_country
    ADD CONSTRAINT pr_country_adres_pr_fk FOREIGN KEY ( adres_pr_producent_id_prod )
        REFERENCES adres_pr ( id_address );

ALTER TABLE pr_country
    ADD CONSTRAINT pr_country_country_fk FOREIGN KEY ( country_id_country )
        REFERENCES country ( id_country );

ALTER TABLE pr_type_cat
    ADD CONSTRAINT pr_type_cat_pr_cat_fk FOREIGN KEY ( pr_cat_id_cat )
        REFERENCES pr_cat ( id_cat );

ALTER TABLE pr_type_cat
    ADD CONSTRAINT pr_type_cat_pr_type_fk FOREIGN KEY ( pr_type_id_type )
        REFERENCES pr_type ( id_type );

ALTER TABLE producent
    ADD CONSTRAINT producent_adres_pr_fk FOREIGN KEY ( id_address )
        REFERENCES adres_pr ( id_address );

ALTER TABLE sg_dates
    ADD CONSTRAINT sg_dates_suplement_goods_fk FOREIGN KEY ( suplement_goods_id_order_sup )
        REFERENCES suplement_goods ( id_order_sup );

ALTER TABLE sg_quantity
    ADD CONSTRAINT sg_quantity_suplement_goods_fk FOREIGN KEY ( suplement_goods_id_order_sup )
        REFERENCES suplement_goods ( id_order_sup );

ALTER TABLE staff
    ADD CONSTRAINT staff_adres_staff_fk FOREIGN KEY ( id_address )
        REFERENCES adres_staff ( id_address );

ALTER TABLE suplement_goods
    ADD CONSTRAINT suplement_goods_dostawcy_fk FOREIGN KEY ( dostawcy_id_dostawcy )
        REFERENCES dostawcy ( id_dostawcy );

ALTER TABLE suplement_goods
    ADD CONSTRAINT suplement_goods_producent_fk FOREIGN KEY ( producent_id_prod )
        REFERENCES producent ( id_prod );

ALTER TABLE suplement_goods
    ADD CONSTRAINT suplement_goods_staff_fk FOREIGN KEY ( staff_id_worker )
        REFERENCES staff ( id_worker );

ALTER TABLE suplement_goods
    ADD CONSTRAINT suplement_goods_towar_fk FOREIGN KEY ( towar_id_towaru )
        REFERENCES towar ( id_towaru );

ALTER TABLE towar_cost
    ADD CONSTRAINT towar_cost_towar_fk FOREIGN KEY ( towar_id_towaru )
        REFERENCES towar ( id_towaru );

--ALTER TABLE towar_pr_t_c
    --ADD CONSTRAINT towar_pr_t_c_pr_type_cat_fk FOREIGN KEY ( pr_type_cat_pr_cat_id_cat,
                                                            -- pr_type_cat_pr_type_id_type )
        --REFERENCES pr_type_cat ( pr_cat_id_cat,
                                 --pr_type_id_type );

ALTER TABLE towar_pr_t_c
    ADD CONSTRAINT towar_pr_t_c_towar_fk FOREIGN KEY ( towar_id_towaru )
        REFERENCES towar ( id_towaru );

ALTER TABLE towar_quantity
    ADD CONSTRAINT towar_quantity_towar_fk FOREIGN KEY ( towar_id_towaru )
        REFERENCES towar ( id_towaru );

ALTER TABLE twoar_producent
    ADD CONSTRAINT twoar_producent_producent_fk FOREIGN KEY ( producent_id_prod )
        REFERENCES producent ( id_prod );

ALTER TABLE twoar_producent
    ADD CONSTRAINT twoar_producent_towar_fk FOREIGN KEY ( towar_id_towaru )
        REFERENCES towar ( id_towaru );

CREATE TABLE Missing_Goods (
    id_missing_goods   INTEGER GENERATED ALWAYS AS IDENTITY,
    towar_id_towaru    INTEGER NOT NULL,
    quantity           INTEGER NOT NULL,
    PRIMARY KEY (id_missing_goods),
    FOREIGN KEY (towar_id_towaru) REFERENCES towar (id_towaru)
);

CREATE TABLE Pending_Orders (
    id_pending_order    INTEGER GENERATED ALWAYS AS IDENTITY,
    quantity            INTEGER NOT NULL,
    towar_id_towaru     INTEGER NOT NULL,
    klienci_id_klienta  INTEGER NOT NULL,
    PRIMARY KEY (id_pending_order),
    FOREIGN KEY (towar_id_towaru) REFERENCES towar (id_towaru),
    FOREIGN KEY (klienci_id_klienta) REFERENCES klienci (id_klienta)
);

INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Gdansk', 'Gdanska', '80-820', 1);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Warsaw', 'Krakowskie Przedmiescie', '00-001', 2);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Krakow', 'Szeroka', '30-001', 3);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Wroclaw', 'Hlonda', '50-001', 4);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Poznan', 'Malta', '60-001', 5);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Lodz', 'Piotrkowska', '90-001', 6);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Gdynia', '10 Lutego', '81-000', 7);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Sopot', 'Bohaterow Monte Cassino', '81-500', 8);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Lublin', 'Kowalska', '20-001', 9);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Katowice', 'Piotra Skargi', '40-001', 10);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Gdansk', 'Gdanska', '80-820', 11);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Warsaw', 'Krakowskie Przedmiescie', '00-001', 12);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Krakow', 'Szeroka', '30-001', 13);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Wroclaw', 'Hlonda', '50-001', 14);
INSERT INTO adres_klienci (city, street, post_code, id_address) VALUES ('Poznan', 'Malta', '60-001', 15);

INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', '3 Maja', '35-001', 1);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Ks. Jerzego Popieluszki', '35-002', 2);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Sienkiewicza', '35-003', 3);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Paderewskiego', '35-004', 4);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Mickiewicza', '35-005', 5);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Konopnickiej', '35-006', 6);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Slowackiego', '35-007', 7);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Reymonta', '35-008', 8);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Szlachecka', '35-009', 9);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Powstancow', '35-010', 10);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Krotka', '35-011', 11);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Plac Wolnosci', '35-012', 12);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Kosciuszki', '35-013', 13);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Krakowska', '35-014', 14);
INSERT INTO adres_staff (city, street, post_code, id_address) VALUES ('Rzeszow', 'Pilzno', '35-015', 15);

INSERT INTO country (id_country, name, shortcut) VALUES (1, 'Poland', 'POL');
INSERT INTO country (id_country, name, shortcut) VALUES (2, 'Germany', 'GER');
INSERT INTO country (id_country, name, shortcut) VALUES (3, 'USA', 'USA');
INSERT INTO country (id_country, name, shortcut) VALUES (4, 'Croatia', 'CRO');
INSERT INTO country (id_country, name, shortcut) VALUES (5, 'Portugal', 'PRT');
INSERT INTO country (id_country, name, shortcut) VALUES (6, 'Spain', 'ESP');
INSERT INTO country (id_country, name, shortcut) VALUES (7, 'France', 'FRA');
INSERT INTO country (id_country, name, shortcut) VALUES (8, 'Netherlands', 'NER');
INSERT INTO country (id_country, name, shortcut) VALUES (9, 'England', 'ENG');
INSERT INTO country (id_country, name, shortcut) VALUES (10, 'Norway', 'NOR');
INSERT INTO country (id_country, name, shortcut) VALUES (11, 'Iran', 'IRN');
INSERT INTO country (id_country, name, shortcut) VALUES (12, 'Saudi Arabia', 'SAR');

INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (1, 'DHL');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (2, 'FedEx');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (3, 'UPS');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (4, 'TNT');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (5, 'DPD');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (6, 'Poczta Polska');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (7, 'DPD Polska');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (8, 'PostNL');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (9, 'Deutsche Post');
INSERT INTO dostawcy (id_dostawcy, co_name) VALUES (10, 'Royal Mail');

INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (1, 1);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (1, 3);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (1, 7);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (1, 8);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (1, 9);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (1, 10);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (1, 11);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (2, 2);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (2, 3);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (2, 7);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (2, 8);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (2, 9);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (3, 1);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (3, 2);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (3, 3);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (3, 4);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (3, 7);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (3, 8);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (3, 12);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (4, 3);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (4, 7);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (4, 8);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (4, 10);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (4, 12);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 2);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 3);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 4);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 5);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 6);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 7);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 8);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 9);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 10);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 11);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (5, 12);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (6, 1);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (7, 1);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (8, 2);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (8, 8);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (8, 9);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (9, 2);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (9, 8);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (10, 2);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (10, 5);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (10, 6);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (10, 7);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (10, 9);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (10, 11);
INSERT INTO dostawcy_kraj (dostawcy_id_dostawcy, country_id_country) VALUES (10, 12);

INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (1, 'ABC Inc.', 'John Smith', '123-456-78-90', 1, 1);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (2, 'XYZ Corp.', 'Jane Doe', '987-654-32-10', 2, 2);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (3, 'Example Ltd.', 'Bob Johnson', '246-801-46-38', 3, 3);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (4, 'Test Co.', 'Alice Williams', '135-792-84-76', 4, 4);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (5, 'Demo Inc.', 'Mike Brown', '753-961-28-34', 5, 5);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (6, 'Sample Ltd.', 'Sarah Jones', '369-258-14-70', 6, 6);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (7, 'Prova Co.', 'William Taylor', '159-753-02-15', 7, 7);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (8, 'Esempio Inc.', 'Carla Anderson', '753-941-27-34', 9, 8);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (9, 'Model Co.', 'Chris Davis', '369-251-14-70', 10, 9);
INSERT INTO klienci (id_klienta, co_name, ceo, nip, building_no, id_address) VALUES (10, 'Przyklad Ltd.', 'Kimberly Williams', '159-733-02-48', 11, 10);

INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (1, 'Jan', 'Kowalski', '2021-06-01', 123456789, 1, 1, 1);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (2, 'Anna', 'Nowak', '2021-06-02', 987654321, 2, 2, 2);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (3, 'Piotr', 'Wiśniewski', '2021-06-03', 123123123, 3, 3, 3);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (4, 'Agnieszka', 'Wójcik', '2021-06-04', 456456456, 4, 4, 4);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (5, 'Katarzyna', 'Krawczyk', '2021-06-05', 789789789, 5, 5, 5);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (6, 'Marcin', 'Kowalczyk', '2021-06-06', 121212121, 6, 6, 6);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (7, 'Ewa', 'Dąbrowska', '2021-06-07', 343434343, 7, 7, 7);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (8, 'Andrzej', 'Majewski', '2021-06-08', 565656565, 8, 8, 8);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (9, 'Małgorzata', 'Nowakowska', '2021-06-09', 787878787, 9, 9, 9);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (10, 'Jerzy', 'Kozłowski', '2021-06-10', 101010101, 10, 10, 10);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (11, 'Janusz', 'Wojciechowski', '2021-06-11', 323232323, 11, 11, 11);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (12, 'Paweł', 'Zieliński', '2021-06-12', 444444444, 12, 12, 12);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (13, 'Marek', 'Szewczyk', '2021-06-13', 666666666, 13, 13, 13);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (14, 'Tomasz', 'Jabłoński', '2021-06-14', 888888888, 14, 14, 14);
INSERT INTO staff (id_worker, name, surname, hire_date, phone, building_no, local_no, id_address) VALUES (15, 'Adam', 'Wróbel', '2021-06-15', 101010101, 15, 15, 15);

INSERT INTO towar(id_towaru, name) VALUES (1, 'Laptop GHI Omen 1');
INSERT INTO towar(id_towaru, name) VALUES (2, 'Laptop Dotykowy');
INSERT INTO towar(id_towaru, name) VALUES (3, 'Komputer stacjonarny LEGION');
INSERT INTO towar(id_towaru, name) VALUES (4, 'Komputer stacjonarny Meta');
INSERT INTO towar(id_towaru, name) VALUES (5, 'XPhone 12');
INSERT INTO towar(id_towaru, name) VALUES (6, 'Oiomi POCO');
INSERT INTO towar(id_towaru, name) VALUES (7, 'Płyn do mycia naczyń TUV');
INSERT INTO towar(id_towaru, name) VALUES (8, 'Płyn do mycia naczyń MNO');
INSERT INTO towar(id_towaru, name) VALUES (9, 'Porszedk do prania Bryza');
INSERT INTO towar(id_towaru, name) VALUES (10, 'Proszek do prania E');
INSERT INTO towar(id_towaru, name) VALUES (11, 'Płyn do mycia szyb Clean');
INSERT INTO towar(id_towaru, name) VALUES (12, 'Płyn do mycia okien GLASS');
INSERT INTO towar(id_towaru, name) VALUES (13, 'Odkażacz Clorox');
INSERT INTO towar(id_towaru, name) VALUES (14, 'Odkażacz Dettol');
INSERT INTO towar(id_towaru, name) VALUES (15, 'Zestaw opon zimowych');
INSERT INTO towar(id_towaru, name) VALUES (16, 'Ramki do tablic rejestracyjnych');
INSERT INTO towar(id_towaru, name) VALUES (17, 'Klocki hamulcowe');
INSERT INTO towar(id_towaru, name) VALUES (18, 'Linki hamulocwe');
INSERT INTO towar(id_towaru, name) VALUES (19, 'Płyn hamulocwy');
INSERT INTO towar(id_towaru, name) VALUES (20, 'Płyn do spryskiwaczy');
INSERT INTO towar(id_towaru, name) VALUES (21, 'Szafa trzydrzwiowa z lustrem');
INSERT INTO towar(id_towaru, name) VALUES (22, 'Szafa dwudrzwiowa z szufladą');
INSERT INTO towar(id_towaru, name) VALUES (23, 'Wysoka komoda 5-cio szufladowa');
INSERT INTO towar(id_towaru, name) VALUES (24, 'Niska komoda pod telewizor');
INSERT INTO towar(id_towaru, name) VALUES (25, 'Łóżko podwójne');
INSERT INTO towar(id_towaru, name) VALUES (26, 'Łóżko pojedyńcze');
INSERT INTO towar(id_towaru, name) VALUES (27, 'Młotek gumowy');
INSERT INTO towar(id_towaru, name) VALUES (28, 'Młotek szewski');
INSERT INTO towar(id_towaru, name) VALUES (29, 'Zagęszczarka duża');
INSERT INTO towar(id_towaru, name) VALUES (30, 'Zagęszczarka mała');
INSERT INTO towar(id_towaru, name) VALUES (31, 'Wiertarka udarowa');
INSERT INTO towar(id_towaru, name) VALUES (32, 'Wkrętarka');
INSERT INTO towar(id_towaru, name) VALUES (33, 'Kask budowlany');
INSERT INTO towar(id_towaru, name) VALUES (34, 'Kask przemysłowy');

INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (1, 100, 1, 1, 1);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (2, 500, 2, 2, 2);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (3, 800, 3, 3, 3);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (4, 300, 4, 4, 4);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (5, 700, 5, 5, 5);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (6, 200, 6, 6, 6);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (7, 900, 7, 7, 7);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (8, 400, 8, 8, 8);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (9, 600, 9, 9, 9);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (10, 350, 10, 10, 10);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (11, 950, 11, 1, 11);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (12, 250, 12, 2, 12);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (13, 850, 13, 3, 13);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (14, 450, 14, 4, 14);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (15, 750, 15, 5, 15);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (16, 150, 16, 6, 1);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (17, 1000, 17, 7, 2);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (18, 50, 18, 8, 3);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (19, 950, 19, 9, 4);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (20, 250, 20, 10, 5);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (21, 850, 21, 1, 6);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (22, 450, 22, 2, 7);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (23, 750, 23, 3, 8);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (24, 150, 24, 4, 9);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (25, 1000, 25, 5, 10);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (26, 50, 26, 6, 1);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (27, 950, 27, 7, 2);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (28, 250, 28, 8, 3);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (29, 850, 29, 9, 4);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (30, 450, 30, 10, 5);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (31, 750, 31, 1, 6);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (32, 150, 32, 2, 7);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (33, 1000, 33, 3, 8);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (34, 50, 34, 4, 9);
INSERT INTO orders (id_order, quantity, towar_id_towaru, klienci_id_klienta, staff_id_worker) VALUES (35, 950, 33, 5, 10);

INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/10/06', '10:05:00', '22/10/07', '09:30:00', 1);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/08', '15:45:00', '22/09/09', '16:15:00', 2);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/03', '11:30:00', '22/09/04', '12:00:00', 3);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/25', '18:35:00', NULL, NULL, 4);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/14', '07:40:00', '22/08/15', '08:10:00', 5);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/10/06', '08:20:00', '22/10/07', '09:00:00', 6);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/11', '17:15:00', '22/09/12', '17:45:00', 7);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/06', '14:50:00', '22/09/07', '15:20:00', 8);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/29', '09:25:00', NULL, NULL, 9);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/17', '16:05:00', NULL, NULL, 10);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/10/06', '12:30:00', '22/10/07', '13:00:00', 11);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/09', '08:15:00', '22/09/10', '08:45:00', 12);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/04', '19:50:00', NULL, NULL, 13);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/26', '10:35:00', '22/08/27', '11:05:00', 14);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/15', '17:40:00', '22/08/16', '18:10:00', 15);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/10/06', '09:20:00', '22/10/07', '09:50:00', 16);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/10', '16:15:00', NULL, NULL, 17);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/05', '13:30:00', NULL, NULL, 18);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/27', '19:35:00', NULL, NULL, 19);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/14', '06:40:00', NULL, NULL, 20);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/10/06', '07:20:00', '22/10/07', '08:00:00', 21);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/07', '15:15:00', '22/09/08', '15:45:00', 22);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/02', '12:30:00', NULL, NULL, 23);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/24', '19:35:00', '22/08/25', '20:05:00', 24);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/13', '08:40:00', '22/08/14', '09:10:00', 25);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/10/06', '06:20:00', NULL, NULL, 26);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/08', '14:15:00', '22/09/09', '14:45:00', 27);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/03', '11:30:00', '22/09/04', '12:00:00', 28);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/25', '18:35:00', NULL, NULL, 29);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/14', '07:40:00', NULL, NULL, 30);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/10/06', '05:20:00', NULL, NULL, 31);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/09', '13:15:00', '22/09/10', '13:45:00', 32);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/09/04', '10:30:00', '22/09/05', '11:00:00', 33);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/26', '17:35:00', NULL, NULL, 34);
INSERT INTO order_dates (order_date, order_time, realization_date, realization_time, orders_id_order) VALUES ('22/08/15', '06:40:00', NULL, NULL, 35);

INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Warsaw', 'Nowy Swiat', '00-001', 1);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Berlin', 'Unter den Linden', '10117', 2);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('New York', 'Fifth Avenue', '10001', 3);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Zagreb', 'Trg Bana Jelacica', '10000', 4);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Lisbon', 'Avenida da Liberdade', '1250-092', 5);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Madrid', 'Paseo del Prado', '28014', 6);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Paris', 'Avenue des Champs-Élysées', '75008', 7);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Amsterdam', 'Dam Square', '1012 NP', 8);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('London', 'Buckingham Palace Road', 'SW1A 1AA', 9);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Oslo', 'Karl Johans gate', '0162', 10);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Tehran', 'Ferdowsi Avenue', '1115613371', 11);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Riyadh', 'King Fahd Road', '11483', 12);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Vienna', 'Kärntner Strasse', '1010', 13);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Rome', 'Via del Corso', '00186', 14);
INSERT INTO adres_pr (city, street, post_code, id_address) VALUES ('Stockholm', 'Drottninggatan', '11120', 15);

INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (1, 'Acme Corp.', '1234567890', 1, 1);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (2, 'XYZ Industries', '9876543210', 2, 2);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (3, 'ABC Enterprises', '1231231230', 3, 3);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (4, 'Foo Bar Inc.', '4564564560', 4, 4);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (5, 'MNO Solutions', '7897897890', 5, 5);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (6, 'PQR Technologies', '1212121210', 6, 6);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (7, 'TUV Products', '3434343430', 7, 7);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (8, 'WXY Solutions', '5656565650', 8, 8);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (9, 'GHI Services', '7878787870', 9, 9);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (10, 'JKL Enterprises', '1010101010', 10, 10);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (11, 'DEF Inc.', '3232323230', 11, 11);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (12, 'LMN Corp.', '5454545450', 12, 12);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (13, 'OPQ Industries', '7676767670', 13, 13);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (14, 'RST Products', '9898989890', 14, 14);
INSERT INTO producent (id_prod, co_name, nip, building_no, id_address) VALUES (15, 'UVW Enterprises', '1210121010', 15, 15);

INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (1, 1);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (2, 2);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (3, 3);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (4, 4);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (5, 5);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (6, 6);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (7, 7);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (8, 8);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (9, 9);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (10, 10);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (11, 11);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (12, 12);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (1, 13);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (4, 14);
INSERT INTO pr_country (country_id_country, adres_pr_producent_id_prod) VALUES (7, 15);

INSERT INTO pr_cat (id_cat, cat_name) VALUES (1, 'Elektronika');
INSERT INTO pr_cat (id_cat, cat_name) VALUES (2, 'Chemia');
INSERT INTO pr_cat (id_cat, cat_name) VALUES (3, 'Motoryzacja');
INSERT INTO pr_cat (id_cat, cat_name) VALUES (4, 'Meble');
INSERT INTO pr_cat (id_cat, cat_name) VALUES (5, 'Narzędzia budowlane');

INSERT INTO pr_type (id_type, name) VALUES (1, 'Laptopy');
INSERT INTO pr_type (id_type, name) VALUES (2, 'Komputery stacjonarne');
INSERT INTO pr_type (id_type, name) VALUES (3, 'Telefony');
INSERT INTO pr_type (id_type, name) VALUES (4, 'Płyny do mycia naczyń');
INSERT INTO pr_type (id_type, name) VALUES (5, 'Proszki do prania');
INSERT INTO pr_type (id_type, name) VALUES (6, 'Płyny do mycia szyb');
INSERT INTO pr_type (id_type, name) VALUES (7, 'Ozkażacze');
INSERT INTO pr_type (id_type, name) VALUES (8, 'Części samochodowe');
INSERT INTO pr_type (id_type, name) VALUES (9, 'Części do motocyklu');
INSERT INTO pr_type (id_type, name) VALUES (10, 'Płyny samochodowe');
INSERT INTO pr_type (id_type, name) VALUES (11, 'Szafy');
INSERT INTO pr_type (id_type, name) VALUES (12, 'Komody');
INSERT INTO pr_type (id_type, name) VALUES (13, 'Łóżka');
INSERT INTO pr_type (id_type, name) VALUES (14, 'Młotki');
INSERT INTO pr_type (id_type, name) VALUES (15, 'Zagęszczarki');
INSERT INTO pr_type (id_type, name) VALUES (16, 'Wiertarki');
INSERT INTO pr_type (id_type, name) VALUES (17, 'Kaski ochronne');

INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (1, 1);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (1, 2);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (1, 3);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (2, 4);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (2, 5);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (2, 6);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (2, 7);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (3, 8);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (3, 9);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (3, 10);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (4, 11);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (4, 12);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (4, 13);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (5, 14);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (5, 15);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (5, 16);
INSERT INTO pr_type_cat (pr_cat_id_cat, pr_type_id_type) VALUES (5, 17);

INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (1, 9);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (2, 1);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (2, 2);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (2, 13);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (3, 6);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (3, 15);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (4, 1);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (5, 2);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (6, 6);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (7, 7);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (8, 5);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (9, 8);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (10, 8);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (10, 7);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (11, 8);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (11, 7);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (12, 6);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (12, 8);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (13, 6);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (14, 6);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (14, 7);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (15, 3);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (15, 11);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (15, 15);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (16, 3);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (16, 15);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (17, 3);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (17, 11);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (17, 15);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (18, 11);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (19, 3);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (19, 11);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (19, 15);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (20, 3);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (20, 11);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (20, 15);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (21, 4);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (22, 14);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (23, 4);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (23, 14);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (24, 14);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (25, 4);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (25, 14);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (26, 4);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (26, 14);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (27, 10);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (27, 12);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (28, 12);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (29, 10);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (30, 10);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (30, 12);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (31, 10);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (31, 12);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (32, 10);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (32, 12);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (33, 10);
INSERT INTO twoar_producent(towar_id_towaru, producent_id_prod) VALUES (34, 10);

INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (999.99, 1);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (1299.99, 2);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (849.99, 3);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (729.99, 4);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (599.99, 5);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (499.99, 6);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (5.99, 7);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (3.99, 8);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (2.99, 9);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (1.99, 10);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (3.99, 11);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (2.99, 12);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (3.99, 13);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (2.99, 14);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (129.99, 15);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (14.99, 16);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (24.99, 17);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (19.99, 18);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (29.99, 19);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (14.99, 20);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (349.99, 21);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (299.99, 22);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (449.99, 23);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (399.99, 24);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (449.99, 25);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (399.99, 26);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (14.99, 27);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (19.99, 28);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (449.99, 29);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (399.99, 30);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (79.99, 31);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (59.99, 32);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (19.99, 33);
INSERT INTO towar_cost (cost, towar_id_towaru) VALUES (29.99, 34);

INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2000, 1);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3000, 2);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3500, 3);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2500, 4);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (4500, 5);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (5500, 6);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (4000, 7);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3000, 8);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (6000, 9);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (7000, 10);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2000, 11);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2000, 12);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3000, 13);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2500, 14);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3500, 15);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (4000, 16);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (5500, 17);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (4500, 18);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3000, 19);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (6000, 20);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (7000, 21);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2500, 22);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3500, 23);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (4000, 24);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (5500, 25);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (4500, 26);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3000, 27);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (6000, 28);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (7000, 29);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2000, 30);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2000, 31);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3000, 32);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (2500, 33);
INSERT INTO towar_quantity (quantity, towar_id_towaru) VALUES (3500, 34);


INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (1, 1, 1);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (2, 1, 1);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (3, 1, 2);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (4, 1, 2);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (5, 1, 3);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (6, 1, 3);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (7, 2, 4);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (8, 2, 4);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (9, 2, 5);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (10, 2, 5);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (11, 2, 6);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (12, 2, 6);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (13, 2, 7);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (14, 2, 7);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (15, 3, 8);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (16, 3, 8);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (17, 3, 9);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (18, 3, 9);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (19, 3, 10);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (20, 3, 10);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (21, 4, 11);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (22, 4, 11);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (23, 4, 12);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (24, 4, 12);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (25, 4, 13);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (26, 4, 13);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (27, 5, 14);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (28, 5, 14);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (29, 5, 15);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (30, 5, 15);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (31, 5, 16);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (32, 5, 16);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (33, 5, 17);
INSERT INTO towar_pr_t_c(towar_id_towaru, pr_type_cat_pr_cat_id_cat, pr_type_cat_pr_type_id_type) VALUES (34, 5, 17);

INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (1, 15, 3, 3, 15);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (2, 5, 8, 5, 8);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (3, 10, 2, 2, 2);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (4, 9, 4, 4, 21);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (5, 6, 5, 5, 7);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (6, 7, 6, 6, 3);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (7, 8, 7, 7, 8);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (8, 2, 8, 8, 9);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (9, 3, 9, 9, 10);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (10, 4, 10, 10, 2);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (11, 14, 11, 11, 16);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (12, 1, 12, 12, 17);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (13, 12, 13, 13, 18);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (14, 11, 14, 14, 22);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (15, 13, 15, 15, 19);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (16, 15, 1, 1, 20);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (17, 5, 2, 2, 23);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (18, 10, 3, 3, 24);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (19, 9, 4, 4, 25);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (20, 6, 5, 5, 26);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (21, 5, 7, 7, 1);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (22, 6, 5, 5, 2);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (23, 7, 15, 3, 3);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (24, 8, 9, 1, 4);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (25, 9, 6, 6, 5);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (26, 10, 1, 2, 6);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (27, 11, 8, 8, 7);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (28, 12, 13, 4, 8);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (29, 13, 2, 9, 9);
INSERT INTO suplement_goods (id_order_sup, staff_id_worker, producent_id_prod, dostawcy_id_dostawcy, towar_id_towaru) VALUES (30, 14, 4, 10, 10);

INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/12/06', '14:00:00', '22/12/07', '15:00:00', 1);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/11/05', '09:30:00', '22/11/06', '10:00:00', 2);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/10/03', '19:00:00', NULL, NULL, 3);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/09/02', '12:00:00', '22/09/03', '13:00:00', 4);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/08/01', '07:00:00', '22/08/02', '08:00:00', 5);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/12/06', '10:00:00', '22/12/07', '11:00:00', 6);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/11/05', '15:30:00', '22/11/06', '16:00:00', 7);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/10/03', '14:00:00', '22/10/04', '15:00:00', 8);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/09/02', '09:00:00', NULL, NULL, 9);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/08/01', '17:00:00', NULL, NULL, 10);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/12/06', '16:00:00', '22/12/07', '17:00:00', 11);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/11/05', '11:00:00', '22/11/06', '12:00:00', 12);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/10/03', '20:00:00', NULL, NULL, 13);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/09/02', '13:00:00', '22/09/03', '14:00:00', 14);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/08/01', '08:00:00', '22/08/02', '09:00:00', 15);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/12/06', '12:00:00', '22/12/07', '13:00:00', 16);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/11/05', '16:30:00', NULL, NULL, 17);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/10/03', '15:00:00', NULL, NULL, 18);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/09/02', '19:00:00', NULL, NULL, 19);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/08/01', '06:00:00', NULL, NULL, 20);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/12/06', '08:00:00', '22/12/07', '09:00:00', 21);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/11/05', '14:30:00', '22/11/06', '15:00:00', 22);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('22/10/03', '11:00:00', NULL, NULL, 23);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('23/01/06', '09:05:00', '23/01/07', '09:30:00', 24);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('23/02/08', '15:45:00', '23/02/09', '16:15:00', 25);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('23/03/03', '11:30:00', '23/03/04', '12:00:00', 26);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('23/04/25', '18:35:00', NULL, NULL, 27);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('23/05/14', '07:40:00', '23/05/15', '08:10:00', 28);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('23/06/06', '08:20:00', '23/06/07', '09:00:00', 29);
INSERT INTO sg_dates (order_date, order_time, realization_date, realization_time, suplement_goods_id_order_sup) VALUES ('23/07/11', '17:15:00', '23/07/12', '17:45:00', 30);



INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (400, 1);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (450, 2);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (500, 3);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (550, 4);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (600, 5);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (650, 6);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (700, 7);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (750, 8);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (800, 9);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (850, 10);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (900, 11);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (950, 12);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1000, 13);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1050, 14);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1100, 15);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1150, 16);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1200, 17);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1250, 18);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1300, 19);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1350, 20);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1400, 21);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1450, 22);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1500, 23);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1550, 24);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1600, 25);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1650, 26);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1700, 27);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1750, 28);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1800, 29);
INSERT INTO sg_quantity (quantity, suplement_goods_id_order_sup) VALUES (1850, 30);

INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (100*999.99, 1, 1);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (500*1299.99, 1, 2);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (800*849.99,1,3);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (300*729.99,1,4);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (700*599.99,1,5);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (200*499.99,1,6);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (900*5.99,1,7);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (400*3.99,1,8);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (600*2.99,0,9);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (350*1.99,1,10);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (950*3.99,1,11);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (250*2.99,1,12);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (850*3.99,0,13);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (450*2.99,1,14);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (750*129.99,1,15);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (150*14.99,1,16);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (1000*24.99,1,17);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (50*19.99,0,18);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (950*29.99,1,19);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (250*14.99,1,20);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (850*349.99,1,21);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (450*299.99,1,22);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (750*449.99,0,23);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (150*399.99,1,24);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (1000*449.99,1,25);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (50*399.99,1,26);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (950*14.99,1,27);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (250*19.99,1,28);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (850*449.99,0,29);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (450*399.99,1,30);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (750*79.99,1,31);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (150*59.99,1,32);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (1000*19.99,1,33);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (50*29.99,1,34);
INSERT INTO order_cost (cost, payment, orders_id_order) VALUES (950*19.99,0,35);

INSERT INTO Pending_Orders (id_pending_order, quantity, towar_id_towaru, klienci_id_klienta) VALUES (1, 800, 33, 11);
INSERT INTO Pending_Orders (id_pending_order, quantity, towar_id_towaru, klienci_id_klienta) VALUES (2, 5, 29, 2);
INSERT INTO Pending_Orders (id_pending_order, quantity, towar_id_towaru, klienci_id_klienta) VALUES (3, 150, 19, 5);
INSERT INTO Pending_Orders (id_pending_order, quantity, towar_id_towaru, klienci_id_klienta) VALUES (4, 450, 11, 4);
INSERT INTO Pending_Orders (id_pending_order, quantity, towar_id_towaru, klienci_id_klienta) VALUES (5, 505, 10, 9);

INSERT INTO Missing_Goods (id_missing_goods, towar_id_towaru, quantity) VALUES (1, 33, 180);
INSERT INTO Missing_Goods (id_missing_goods, towar_id_towaru, quantity) VALUES (1, 29, 1);
INSERT INTO Missing_Goods (id_missing_goods, towar_id_towaru, quantity) VALUES (1, 19, 26);
INSERT INTO Missing_Goods (id_missing_goods, towar_id_towaru, quantity) VALUES (1, 11, 250);
INSERT INTO Missing_Goods (id_missing_goods, towar_id_towaru, quantity) VALUES (1, 10, 5);









--APEX Export - for Oracle APEX APP
begin
    --HTMLDB_PLAN_TABLE: 0/10000 rows exported, no file generated
    apex_data_install.load_supporting_object_data(p_table_name => 'HTMLDB_PLAN_TABLE', p_delete_after_install => false );
    --ADRES_KLIENCI: 17/10000 rows exported, APEX$DATA$PKG/ADRES_KLIENCI$690467
    apex_data_install.load_supporting_object_data(p_table_name => 'ADRES_KLIENCI', p_delete_after_install => false );
    --ADRES_STAFF: 15/10000 rows exported, APEX$DATA$PKG/ADRES_STAFF$197045
    apex_data_install.load_supporting_object_data(p_table_name => 'ADRES_STAFF', p_delete_after_install => false );
    --COUNTRY: 12/10000 rows exported, APEX$DATA$PKG/COUNTRY$765899
    apex_data_install.load_supporting_object_data(p_table_name => 'COUNTRY', p_delete_after_install => false );
    --DOSTAWCY: 10/10000 rows exported, APEX$DATA$PKG/DOSTAWCY$885151
    apex_data_install.load_supporting_object_data(p_table_name => 'DOSTAWCY', p_delete_after_install => false );
    --DOSTAWCY_KRAJ: 49/10000 rows exported, APEX$DATA$PKG/DOSTAWCY_KRAJ$228124
    apex_data_install.load_supporting_object_data(p_table_name => 'DOSTAWCY_KRAJ', p_delete_after_install => false );
    --KLIENCI: 16/10000 rows exported, APEX$DATA$PKG/KLIENCI$413174
    apex_data_install.load_supporting_object_data(p_table_name => 'KLIENCI', p_delete_after_install => false );
    --STAFF: 15/10000 rows exported, APEX$DATA$PKG/STAFF$935484
    apex_data_install.load_supporting_object_data(p_table_name => 'STAFF', p_delete_after_install => false );
    --TOWAR: 37/10000 rows exported, APEX$DATA$PKG/TOWAR$349435
    apex_data_install.load_supporting_object_data(p_table_name => 'TOWAR', p_delete_after_install => false );
    --ORDERS: 50/10000 rows exported, APEX$DATA$PKG/ORDERS$908588
    apex_data_install.load_supporting_object_data(p_table_name => 'ORDERS', p_delete_after_install => false );
    --ORDER_DATES: 50/10000 rows exported, APEX$DATA$PKG/ORDER_DATES$867337
    apex_data_install.load_supporting_object_data(p_table_name => 'ORDER_DATES', p_delete_after_install => false );
    --ORDER_COST: 50/10000 rows exported, APEX$DATA$PKG/ORDER_COST$818533
    apex_data_install.load_supporting_object_data(p_table_name => 'ORDER_COST', p_delete_after_install => false );
    --ADRES_PR: 17/10000 rows exported, APEX$DATA$PKG/ADRES_PR$391907
    apex_data_install.load_supporting_object_data(p_table_name => 'ADRES_PR', p_delete_after_install => false );
    --PRODUCENT: 17/10000 rows exported, APEX$DATA$PKG/PRODUCENT$106885
    apex_data_install.load_supporting_object_data(p_table_name => 'PRODUCENT', p_delete_after_install => false );
    --PR_COUNTRY: 15/10000 rows exported, APEX$DATA$PKG/PR_COUNTRY$164198
    apex_data_install.load_supporting_object_data(p_table_name => 'PR_COUNTRY', p_delete_after_install => false );
    --PR_CAT: 6/10000 rows exported, APEX$DATA$PKG/PR_CAT$147649
    apex_data_install.load_supporting_object_data(p_table_name => 'PR_CAT', p_delete_after_install => false );
    --PR_TYPE: 20/10000 rows exported, APEX$DATA$PKG/PR_TYPE$323350
    apex_data_install.load_supporting_object_data(p_table_name => 'PR_TYPE', p_delete_after_install => false );
    --PR_TYPE_CAT: 20/10000 rows exported, APEX$DATA$PKG/PR_TYPE_CAT$875495
    apex_data_install.load_supporting_object_data(p_table_name => 'PR_TYPE_CAT', p_delete_after_install => false );
    --TWOAR_PRODUCENT: 37/10000 rows exported, APEX$DATA$PKG/TWOAR_PRODUCENT$717539
    apex_data_install.load_supporting_object_data(p_table_name => 'TWOAR_PRODUCENT', p_delete_after_install => false );
    --TOWAR_COST: 37/10000 rows exported, APEX$DATA$PKG/TOWAR_COST$320393
    apex_data_install.load_supporting_object_data(p_table_name => 'TOWAR_COST', p_delete_after_install => false );
    --TOWAR_QUANTITY: 37/10000 rows exported, APEX$DATA$PKG/TOWAR_QUANTITY$843331
    apex_data_install.load_supporting_object_data(p_table_name => 'TOWAR_QUANTITY', p_delete_after_install => false );
    --TOWAR_PR_T_C: 37/10000 rows exported, APEX$DATA$PKG/TOWAR_PR_T_C$488457
    apex_data_install.load_supporting_object_data(p_table_name => 'TOWAR_PR_T_C', p_delete_after_install => false );
    --SUPLEMENT_GOODS: 25/10000 rows exported, APEX$DATA$PKG/SUPLEMENT_GOODS$548436
    apex_data_install.load_supporting_object_data(p_table_name => 'SUPLEMENT_GOODS', p_delete_after_install => false );
    --SG_DATES: 25/10000 rows exported, APEX$DATA$PKG/SG_DATES$764432
    apex_data_install.load_supporting_object_data(p_table_name => 'SG_DATES', p_delete_after_install => false );
    --SG_QUANTITY: 25/10000 rows exported, APEX$DATA$PKG/SG_QUANTITY$4277
    apex_data_install.load_supporting_object_data(p_table_name => 'SG_QUANTITY', p_delete_after_install => false );
end;