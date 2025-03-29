COPY registros_contabeis (
    data, 
    reg_ans, 
    cd_conta_contabil, 
    vl_saldo_inicial, 
    vl_saldo_final, 
    conta_id
)
FROM '/data/1T2024.csv'
WITH (FORMAT CSV, DELIMITER ';', HEADER, ENCODING 'UTF8')
WHERE (
    SELECT id 
    FROM contas_contabeis 
    WHERE codigo = cd_conta_contabil
) IS NOT NULL;