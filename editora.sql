CREATE TABLE editora (
    cod_editora INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL,
    endereco VARCHAR(45)
);

CREATE TABLE livro (
    cod_livro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(45) NOT NULL,
    titulo VARCHAR(45) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    num_edicao INT,
    preco FLOAT NOT NULL,
    editora_cod_editora INT NOT NULL,
    FOREIGN KEY (editora_cod_editora)
        REFERENCES editora (cod_editora)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE autor (
	cod_autor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    autor VARCHAR(45) NOT NULL,
    sexo VARCHAR(1),
    data_nascimento DATE NOT NULL
);

CREATE TABLE livro_autor ( 
    cod_livro INT NOT NULL,
    cod_autor INT NOT NULL,
    FOREIGN KEY (cod_livro)
        REFERENCES livro (cod_livro),
    FOREIGN KEY (cod_autor)
        REFERENCES autor (cod_autor),
    CONSTRAINT pk_la PRIMARY KEY livro_autor (cod_livro , cod_autor)
);

-- Altere nome da coluna descrição da tabela editora para nome
ALTER TABLE editora RENAME COLUMN descricao TO nome; -- alternativa: ALTER TABLE editora CHANGE COLUMN descricao nome VARCHAR(45) NOT NULL;


-- Altere a coluna sexo para o tipo varchar(1); 
ALTER TABLE autor CHANGE COLUMN sexo sexo VARCHAR(1);    -- alternativa:  ALTER TABLE autor MODIFY COLUMN sexo VARCHAR(1);


-- Adicione uma restrição onde a coluna isbn tenha valor único
ALTER TABLE livro ADD UNIQUE(isbn); -- alternativa: ALTER TABLE livro ADD CONSTRAINT UNIQUE(isbn);


-- Adicione uma restrição onde valor padrão do livro seja R$10,00
ALTER TABLE livro ALTER COLUMN preco SET DEFAULT 10.00;  -- alternativa: ALTER TABLE livro MODIFY COLUMN preco FLOAT DEFAULT 20.00;


--  Exclua a coluna num_edição da tabela livro e recrie com nome de edição
ALTER TABLE livro DROP COLUMN num_edicao;
ALTER TABLE livro ADD COLUMN edicao INT;


-- Crie um nova tabela chamada grupo(id_grupo, nome). Adicione a tabela editora uma
-- coluna para essa tabela através de um chave estrangeira. Ajuste o comando para
-- que quando for deletada seja setado null na tabela editora. No caso do update seja
-- atualizado em cascata.

CREATE TABLE grupo (
    id_grupo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(45) NOT NULL
);

ALTER TABLE editora ADD COLUMN cod_grupo INT;

ALTER TABLE editora ADD CONSTRAINT fk_editora_grupo FOREIGN KEY (cod_grupo)
REFERENCES grupo (id_grupo)
ON UPDATE CASCADE ON DELETE SET NULL;
  
