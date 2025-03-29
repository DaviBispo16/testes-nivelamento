CREATE TABLE operadoras (
    cnpj CHAR(14) PRIMARY KEY,
    registro_ans VARCHAR(20) NOT NULL UNIQUE,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    data_registro DATE NOT NULL,
    modalidade_id INT NOT NULL,
    regiao_id INT NOT NULL,
    representante_id INT NOT NULL,
    endereco_id INT NOT NULL,
    contato_id INT NOT NULL,
    CONSTRAINT fk_modalidade FOREIGN KEY (modalidade_id) REFERENCES modalidades(id),
    CONSTRAINT fk_regiao FOREIGN KEY (regiao_id) REFERENCES regioes_comercializacao(id),
    CONSTRAINT fk_representante FOREIGN KEY (representante_id) REFERENCES representantes(id),
    CONSTRAINT fk_endereco FOREIGN KEY (endereco_id) REFERENCES enderecos(id),
    CONSTRAINT fk_contato FOREIGN KEY (contato_id) REFERENCES contatos(id)
);

CREATE TABLE modalidades (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE enderecos (
    id SERIAL PRIMARY KEY,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL
);

CREATE TABLE contatos (
    id SERIAL PRIMARY KEY,
    ddd CHAR(2),
    telefone VARCHAR(9),
    fax VARCHAR(9),
    email VARCHAR(255) CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE representantes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(100)
);

CREATE TABLE regioes_comercializacao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

Copy

CREATE TABLE despesas (
    id SERIAL PRIMARY KEY,
    operadora_cnpj CHAR(14) NOT NULL REFERENCES operadoras(cnpj),
    valor DECIMAL(15,2) NOT NULL,
    categoria VARCHAR(255) NOT NULL,
    data DATE NOT NULL
);