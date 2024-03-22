-- criando o banco

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
    ON UPDATE RESTRICT ON DELETE RESTRICT,
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


-- inserindo dados nas colunas

INSERT INTO banco( codigo_banco , nome) VALUES ( 1, 'Banco do Brasil');
INSERT INTO banco( codigo_banco , nome) VALUES ( 4, 'CEF');

INSERT INTO agencia( numero_agencia , cod_banco, endereco) VALUES ( 0562, 4, 'Rua Joaquim Teixeira Alves, 1555');
INSERT INTO agencia( numero_agencia , cod_banco, endereco) VALUES ( 3153, 1, 'Av. Marcelino Pires, 1960');

INSERT INTO cliente( cpf, nome, endereco, sexo) VALUES ( '111.222.333-44', 'Jennifer B Souza', 'Rua Cuiabá, 1050', 'F');
INSERT INTO cliente( cpf, nome, endereco, sexo) VALUES ( '666.777.888-99', 'Caetano K Lima',  'Rua Ivinhema, 879', 'M');
INSERT INTO cliente( cpf, nome, endereco, sexo) VALUES ( '555.444.777-33', 'Silvia Macedo', 'Rua Estados Unidos, 735', 'F');

INSERT INTO conta( num_conta, saldo, tipo_conta, num_agencia) VALUES ('86340-2', 763.05, 2, 3153);
INSERT INTO conta( num_conta, saldo, tipo_conta, num_agencia) VALUES ('23584-7', 3879.12, 1, 0562);

INSERT INTO historico( historico_cpf, historico_num_conta, data_inicio) VALUES ('111.222.333-44', '23584-7', '1997-12-17');
INSERT INTO historico( historico_cpf, historico_num_conta, data_inicio) VALUES ('666.777.888-99', '23584-7', '1997-12-17');
INSERT INTO historico( historico_cpf, historico_num_conta, data_inicio) VALUES ('555.444.777-33', '86340-2', '2010-11-29');

INSERT INTO telefone_cliente( telefone_cpf_cliente, telefone) VALUES ( '111.222.333-44', '(67)3422-7788');
INSERT INTO telefone_cliente( telefone_cpf_cliente, telefone) VALUES ( '666.777.888-99', '(67)3423-9900');
INSERT INTO telefone_cliente( telefone_cpf_cliente, telefone) VALUES ( '666.777.888-99', '(67)8121-8833');

-- 
