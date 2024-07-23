-- 1. Trigger para inserção na tabela telefone_cliente

DELIMITER //
CREATE TRIGGER insere_telefone_cliente
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO telefone_cliente (cpf_cli, telefone) VALUES (NEW.cpf, 'Seu-Valor-Padrao');
END//
DELIMITER ;

-- 2. Trigger para deleção automática na tabela telefone_cliente

DELIMITER //
CREATE TRIGGER deleta_telefone_cliente
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
    DELETE FROM telefone_cliente WHERE cpf_cli = OLD.cpf;
END//
DELIMITER ;


-- 3. Tabela de log para registros de atualização de conta

CREATE TABLE log_conta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num_conta VARCHAR(7),
    saldo_anterior FLOAT,
    saldo_atual FLOAT,
    tipo_conta_anterior INT,
    tipo_conta_atual INT,
    num_agencia_anterior INT,
    num_agencia_atual INT,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. View com informações do cliente, banco, agência e número da conta

CREATE VIEW view_cliente_banco_agencia_conta AS
SELECT c.nome AS nome_cliente, b.nome AS nome_banco, a.endereco AS endereco_agencia, cn.num_conta
FROM cliente c
JOIN historico h ON c.cpf = h.cpf
JOIN conta cn ON h.num_conta = cn.num_conta
JOIN agencia a ON cn.num_agencia = a.numero_agencia
JOIN banco b ON a.cod_banco = b.codigo;
