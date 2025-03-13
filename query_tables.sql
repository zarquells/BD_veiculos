-- Active: 1741127207592@@127.0.0.1@5432@db_rentvehicles@public
CREATE DATABASE db_rentvehicles

CREATE TABLE tbl_client(
    pk_IDclient     SERIAL PRIMARY KEY,
    name_client     VARCHAR(120) NOT NULL,
    cnh_client      CHAR(11) NOT NULL,
    phone_client    CHAR(11) NOT NULL
);

-- CREATE TYPE rent AS ENUM('alugado', 'disponivel');
CREATE TABLE tbl_vehicle(
    pk_IDvehicle    SERIAL PRIMARY KEY,
    model_vehicle   VARCHAR(120) NOT NULL,
    year_vehicle    CHAR(4) NOT NULL,
    license_vehicle CHAR(7) NOT NULL,
    rent_vehicle    rent DEFAULT('disponivel')
);

CREATE TABLE tbl_colab(
    pk_IDcolab      SERIAL PRIMARY KEY,
    name_colab      VARCHAR(120) NOT NULL,
    position_colab  VARCHAR(60)  NOT NULL,
    phone_colab     CHAR(11)     NOT NULL
);

CREATE TABLE tbl_rent(
    pk_IDrent       SERIAL PRIMARY KEY,
    fk_IDclient     INT NOT NULL,
    fk_IDvehicle    INT NOT NULL,
    fk_IDcolab      INT NOT NULL,
    initial_rent    DATE DEFAULT(NOW()),
    final_rent      DATE NOT NULL,

    FOREIGN KEY(fk_IDclient)    REFERENCES tbl_client(pk_IDclient),
    FOREIGN KEY(fk_IDvehicle)   REFERENCES tbl_vehicle(pk_IDvehicle),
    FOREIGN KEY(fk_IDcolab)     REFERENCES tbl_colab(pk_IDcolab)
);