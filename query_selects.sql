-- retorna nome do cliente, colaborador e veículo que aparecem na tabela de aluguel
SELECT 
    r.pk_idrent, 
    c.name_client, 
    b.name_colab, 
    v.model_vehicle,
    r.initial_rent,
    r.final_rent
FROM tbl_rent AS r
    LEFT JOIN tbl_client    AS c ON r.fk_idclient  = c.pk_idclient
    LEFT JOIN tbl_colab     AS b ON r.fk_idcolab   = b.pk_idcolab
    LEFT JOIN tbl_vehicle   AS v ON r.fk_idvehicle = v.pk_idvehicle;

-- retorna quantidade de veículos alugados por mês
SELECT
    EXTRACT(MONTH FROM r.initial_rent) AS month_rent,
    COUNT(v.pk_idvehicle) AS vehicle_month
FROM
    tbl_rent AS r 
    LEFT JOIN tbl_vehicle   AS v ON r.fk_idvehicle = v.pk_idvehicle
GROUP BY
    month_rent
ORDER BY
    month_rent;

-- retorna todos os veículos disponíveis
SELECT * FROM tbl_vehicle WHERE rent_vehicle = 'disponivel';

-- atualiza os veiculos que aparecem no aluguel do mês para alugado
UPDATE tbl_vehicle SET rent_vehicle = 'alugado' 
WHERE EXISTS (
    SELECT
        EXTRACT(MONTH FROM r.initial_rent) AS month_rent,
        COUNT(v.pk_idvehicle) AS vehicle_month
    FROM
        tbl_rent AS r
        LEFT JOIN tbl_vehicle   AS v ON r.fk_idvehicle = v.pk_idvehicle
    WHERE
        EXTRACT(MONTH FROM r.initial_rent) = extract(MONTH FROM now())
    GROUP BY
        month_rent
    ORDER BY
        month_rent
);

-- atualiza os veiculos que não aparecem no aluguel do mês para disponível 
UPDATE tbl_vehicle SET rent_vehicle = 'disponivel' 
WHERE NOT EXISTS (
    SELECT
        EXTRACT(MONTH FROM r.initial_rent) AS month_rent,
        COUNT(v.pk_idvehicle) AS vehicle_month
    FROM
        tbl_rent AS r
        LEFT JOIN tbl_vehicle   AS v ON r.fk_idvehicle = v.pk_idvehicle
    WHERE
        EXTRACT(MONTH FROM r.initial_rent) = extract(MONTH FROM now())
    GROUP BY
        month_rent
    ORDER BY
        month_rent
);

-- função que exclui registro que não seja do mês atual
DELETE FROM tbl_rent
WHERE NOT EXISTS (
    SELECT
        r.*
    FROM
        tbl_rent AS r
    WHERE
        EXTRACT(MONTH FROM r.initial_rent) = extract(MONTH FROM now())
);