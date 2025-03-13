INSERT INTO tbl_client(name_client, cnh_client, phone_client)
VALUES(
    'Erick Cardoso Martins',
    '12345678911',
    '11917564998'
),
(
    'Flavio Henrique Santos',
    '12345678911',
    '11917499856'
);

INSERT INTO tbl_colab(name_colab, position_colab, phone_colab)
VALUES(
    'Diego Ribeiro Lima',
    'Analista de Vendas',
    '11956174998'
),
(
    'Giovanna Santos Souza',
    'Analista de Pós-Vendas',
    '1149985617'
);

INSERT INTO tbl_vehicle(model_vehicle, year_vehicle, license_vehicle)
VALUES(
    'Uno Mille',
    '2016',
    '123ABCD'
),
(
    'Renault Sandero',
    '2019',
    '654DBCA'
),
(
    'Hyundai HB20',
    '2023',
    'JHOI879'
);

INSERT INTO tbl_rent(fk_idclient, fk_idcolab, fk_idvehicle, initial_rent, final_rent)
VALUES(
    1,
    1,
    1,
    '2024-12-04',
    '2024-12-10'
),
(
    2,
    2,
    2,
    '2025-01-10',
    '2025-01-20'
),
(
    2,
    2,
    3,
    '2025-01-20',
    '2025-01-26'
),
(
    1,
    1,
    1,
    '2025-02-10',
    '2025-02-20'
),
(
    1,
    1,
    3,
    '2025-03-12',
    '2025-03-20'
);