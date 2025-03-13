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

-- retorna quantidade de veículos alugados por mês e ano
SELECT
    EXTRACT(MONTH FROM r.initial_rent) AS month_rent,
    EXTRACT(YEAR FROM r.initial_rent) AS year_rent,
    COUNT(v.pk_idvehicle) AS vehicle_month
FROM
    tbl_rent AS r 
    LEFT JOIN tbl_vehicle   AS v ON r.fk_idvehicle = v.pk_idvehicle
GROUP BY
    month_rent,
    year_rent
ORDER BY
    year_rent,
    month_rent;

-- retorna todos os veículos disponíveis para aluguel
SELECT * FROM tbl_vehicle WHERE rent_vehicle = 'disponivel';

-- atualiza os veiculos que aparecem no aluguel do mês e ano atual para status 'alugado'
UPDATE tbl_vehicle SET rent_vehicle = 'alugado' 
WHERE pk_idvehicle IN (
    SELECT
        v.pk_idvehicle
    FROM
        tbl_rent AS r
        JOIN tbl_vehicle AS v ON r.fk_idvehicle = v.pk_idvehicle
    WHERE
        EXTRACT(MONTH FROM r.initial_rent) = extract(MONTH FROM now())
    AND
        EXTRACT(YEAR FROM r.initial_rent) = extract(YEAR FROM now())
);

-- atualiza os veiculos que não aparecem no aluguel do mês e ano para disponível 
UPDATE tbl_vehicle SET rent_vehicle = 'disponivel' 
WHERE pk_idvehicle NOT IN (
    SELECT
        v.pk_idvehicle
    FROM
        tbl_rent AS r
        JOIN tbl_vehicle AS v ON r.fk_idvehicle = v.pk_idvehicle
    WHERE
        EXTRACT(MONTH FROM r.initial_rent) = extract(MONTH FROM now())
    AND
        EXTRACT(YEAR FROM r.initial_rent) = extract(YEAR FROM now())
);

-- exclui registro que não seja do mês atual
DELETE FROM tbl_rent
WHERE pk_idrent NOT IN (
    SELECT
        r.pk_idrent
    FROM
        tbl_rent AS r
    WHERE
        EXTRACT(MONTH FROM r.initial_rent) = extract(MONTH FROM now())
);

-- função que exclui registro por id
CREATE FUNCTION del_rent_by_id(id INTEGER) RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
    row_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO row_count FROM tbl_rent WHERE pk_idrent = id;
    IF row_count > 0 THEN
        DELETE FROM tbl_rent WHERE pk_idrent = id;
        RETURN 'Registro deletado.';
    ELSE
        RETURN 'Não foi encontrado registro com este ID.';
    END IF;
END;
$$;