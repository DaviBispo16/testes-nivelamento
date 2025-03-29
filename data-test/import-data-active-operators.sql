CREATE EXTENSION IF NOT EXISTS pg_trgm;

COPY operadoras (
    registro_ans,
    cnpj,
    razao_social,
    nome_fantasia,
    modalidade,
    logradouro,
    numero,
    complemento,
    bairro,
    cidade,
    uf,
    cep,
    ddd,
    telefone,
    fax,
    endereco_eletronico,
    representante,
    cargo_representante,
    regiao_de_comercializacao,
    data_registro_ans
)
FROM "data/Relatorio_cadop.csv"
WITH (
    FORMAT CSV,
    DELIMITER ";",
    HEADER,
    ENCODING "UTF8",
    NULL ""
);