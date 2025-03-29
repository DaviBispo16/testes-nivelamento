WITH periodo_trimestre AS (
    SELECT 
        DATE_TRUNC('quarter', CURRENT_DATE) - INTERVAL '3 months' AS inicio_trimestre,
        DATE_TRUNC('quarter', CURRENT_DATE) AS fim_trimestre
)

SELECT
    o.razao_social AS operadora,
    SUM(d.valor) AS total_despesas,
    d.categoria
FROM
    operadoras o
INNER JOIN despesas d ON o.cnpj = d.operadora_cnpj
INNER JOIN periodo_trimestre pt ON d.data BETWEEN pt.inicio_trimestre AND pt.fim_trimestre
WHERE
    d.categoria = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
GROUP BY
    o.razao_social,
    d.categoria
ORDER BY
    total_despesas DESC
LIMIT 10;



WITH periodo_ano AS (
    SELECT 
        CURRENT_DATE - INTERVAL '1 year' AS inicio_ano,
        CURRENT_DATE AS fim_ano
)

SELECT
    o.razao_social AS operadora,
    SUM(d.valor) AS total_despesas,
    d.categoria
FROM
    operadoras o
INNER JOIN despesas d ON o.cnpj = d.operadora_cnpj
INNER JOIN periodo_ano pa ON d.data BETWEEN pa.inicio_ano AND pa.fim_ano
WHERE
    d.categoria = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
GROUP BY
    o.razao_social,
    d.categoria
ORDER BY
    total_despesas DESC
LIMIT 10;