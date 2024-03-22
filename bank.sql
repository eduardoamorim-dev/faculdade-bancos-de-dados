CREATE DATABASE bank;
use bank;

CREATE TABLE banco (
    codigo_banco INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE agencia (
    numero_agencia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cod_banco INT NOT NULL,
    FOREIGN KEY (cod_banco)
        REFERENCES banco (codigo_banco)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    endereco VARCHAR(100)
);

CREATE TABLE conta (
    num_conta VARCHAR(7) NOT NULL PRIMARY KEY,
    saldo FLOAT NOT NULL,
    tipo_conta INT,
    num_agencia INT NOT NULL,
    FOREIGN KEY (num_agencia)
        REFERENCES agencia (numero_agencia)
);


CREATE TABLE cliente (
    cpf VARCHAR(14) NOT NULL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    endereco  VARCHAR(100),
    sexo CHAR(1)
);


CREATE TABLE historico (
    historico_cpf VARCHAR(14) NOT NULL,
    FOREIGN KEY (historico_cpf)
        REFERENCES cliente (cpf),
    historico_num_conta VARCHAR(7) NOT NULL,
    FOREIGN KEY (historico_num_conta)
        REFERENCES conta (num_conta)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    data_inicio DATE,
    CONSTRAINT cpf_num_conta PRIMARY KEY historico(historico_cpf, historico_num_conta)
);

CREATE TABLE telefone_cliente (
    telefone_cpf_cliente VARCHAR(14) NOT NULL,
    FOREIGN KEY (telefone_cpf_cliente)
        REFERENCES cliente (cpf)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
   telefone VARCHAR(20) NOT NULL PRIMARY KEY
); 
