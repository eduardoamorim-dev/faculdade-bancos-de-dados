CREATE DATABASE Imobiliaria;

USE Imobiliaria;

CREATE TABLE Imoveis (
    ImovelID INT AUTO_INCREMENT PRIMARY KEY,
    Endereco VARCHAR(255) NOT NULL,
    Valor DECIMAL(10 , 2 ) NOT NULL,
    Status ENUM('Disponível', 'Reservado', 'Vendido') DEFAULT 'Disponível'
);

CREATE TABLE Corretores (
CorretorID INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(255) NOT NULL
);

CREATE TABLE Vendas (
VendaID INT AUTO_INCREMENT PRIMARY KEY,
ImovelID INT,
CorretorID INT,
Valor DECIMAL(10, 2),
DataVenda DATE,
FOREIGN KEY (ImovelID) REFERENCES Imoveis(ImovelID),
FOREIGN KEY (CorretorID) REFERENCES Corretores(CorretorID)
);

INSERT INTO Imoveis (Endereco, Valor, Status) VALUES
('Rua das Flores, 123', 250000.00, 'Disponível'),
('Avenida Central, 456', 350000.00, 'Disponível'),
('Rua das Acácias, 789', 300000.00, 'Disponível'),
('Rua do Comércio, 101', 450000.00, 'Vendido'),
('Avenida Brasil, 202', 500000.00, 'Disponível'),
('Praça da Liberdade, 303', 550000.00, 'Vendido');

INSERT INTO Corretores (Nome) VALUES
('Carlos Almeida'),
('Lucia Pereira'),
('Roberto Santos'),
('Juliana Martins'),
('Eduardo Costa');

INSERT INTO Vendas (ImovelID, CorretorID, Valor, DataVenda) VALUES
(1, 1, 250000.00, '2024-07-10'),
(2, 2, 350000.00, '2024-07-15'),
(3, 3, 280000.00, '2024-07-20'),
(4, 4, 450000.00, '2024-07-25'),
(5, 5, 490000.00, '2024-07-28');


-- 1) Crie uma procedure que gere um relatório com o valor total das comissões de vendas para cada corretor a partir de uma
-- 	  data passada como parâmetro para a procedure. O valor da comissão é de 5% o valor de venda.

DELIMITER //
CREATE PROCEDURE RelatorioComissoes(IN data_inicio DATE)
BEGIN
    SELECT 
        c.CorretorID,
        c.Nome,
        SUM(v.Valor * 0.05) AS TotalComissao
    FROM 
        Corretores c
    JOIN 
        Vendas v ON c.CorretorID = v.CorretorID
    WHERE 
        v.DataVenda >= data_inicio
    GROUP BY 
        c.CorretorID, c.Nome;
END //
DELIMITER ;

CALL RelatorioComissoes('2023-01-01');


-- 2) Crie um trigger que ajuste automaticamente o status de um imóvel para "Vendido" ou para “Reservado” na tabela de
--    imóveis, quando uma venda é registrada na tabela de transações. O imóvel será “reservado” quando o valor inserido na
--    tabela de vendas é menor que o valor do imóvel na tabela de imóveis.

DELIMITER //

CREATE TRIGGER atualizaStatusImovel
AFTER INSERT ON Vendas
FOR EACH ROW
BEGIN
    DECLARE valor_imovel DECIMAL(10, 2);
    
    SELECT Valor INTO valor_imovel
    FROM Imoveis
    WHERE ImovelID = NEW.ImovelID;
    
    IF NEW.Valor >= valor_imovel THEN
        UPDATE Imoveis
        SET Status = 'Vendido'
        WHERE ImovelID = NEW.ImovelID;
    ELSE
        UPDATE Imoveis
        SET Status = 'Reservado'
        WHERE ImovelID = NEW.ImovelID;
    END IF;
END //

DELIMITER ;



-- 3) Crie um usuário chamado “secretaria”. Este usuário tem permissões para visualizar relatórios de vendas, ou seja,
--    executar a procedure. Além disso ela poderá inserir, remover, atualizar e excluir imóveis, mas não poderá alterar nada de
--    vendas e nem de corretores.

CREATE USER 'secretaria'@'localhost' IDENTIFIED BY 'senha_segura';

-- Permissões para executar a procedure
GRANT EXECUTE ON PROCEDURE Imobiliaria.RelatorioComissoes TO 'secretaria'@'localhost';

-- Permissões para gerenciar imóveis
GRANT SELECT, INSERT, UPDATE, DELETE ON Imobiliaria.Imoveis TO 'secretaria'@'localhost';

-- Permissões de leitura para Vendas e Corretores
GRANT SELECT ON Imobiliaria.Vendas TO 'secretaria'@'localhost';
GRANT SELECT ON Imobiliaria.Corretores TO 'secretaria'@'localhost';

FLUSH PRIVILEGES;
