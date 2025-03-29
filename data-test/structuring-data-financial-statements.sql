CREATE TABLE contas_contabeis (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    descricao TEXT NOT NULL
);

CREATE TABLE registros_contabeis (
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    reg_ans VARCHAR(20) NOT NULL,
    cd_conta_contabil VARCHAR(20) NOT NULL,
    vl_saldo_inicial NUMERIC(15,2) NOT NULL,
    vl_saldo_final NUMERIC(15,2) NOT NULL,
    conta_id INT NOT NULL REFERENCES contas_contabeis(id)
);
