use empresa;

-- 1. Dado uma taxa e um identificador do funcionário, crie um procedure que aplique a taxa informada no salário do funcionário. 

DELIMITER //

CREATE PROCEDURE GetTaxa(in id_funcinario DECIMAL(4,0), in taxa DECIMAL(5, 2))
BEGIN
  UPDATE Funcionario
  SET Salario = Salario + (Salario * taxa / 100)
  WHERE  id_funcinario = ID_Func;
END //

DELIMITER ;

CALL GetTaxa(1, 25);

SELECT * FROM Funcionario;


-- Crie uma tabela chamada hora_extra. Essa tabela deverá ter o identificador do funcionário e campo para guardar quantas horas foram excedidas de um funcionário na jornada semanal.

CREATE TABLE hora_extra (
    horasExcedidas INT NOT NULL,
    ID_Func NUMERIC(4) NOT NULL,
    PRIMARY KEY (ID_Func),
    FOREIGN KEY (ID_Func) REFERENCES Funcionario (ID_Func) ON DELETE CASCADE
);


-- Crie uma trigger que, ao ser adicionado um registro na tabela “trabalha” no banco, ela chamará uma procedure que calcula a soma do número de horas trabalhadas em todos os projetos de um funcionário. 
-- Caso a carga horária seja maior que 40, a trigger insere o valor excedente na tabela de hora_extra. 


DELIMITER //

CREATE PROCEDURE CalculaHorasTrabalhadas(IN p_ID_Func NUMERIC(4))
BEGIN
    DECLARE total_horas NUMERIC(6,1);
    SET total_horas = (
        SELECT IFNULL(SUM(NumHoras), 0)
        FROM Trabalha
        WHERE ID_Func = p_ID_Func
    );

    IF total_horas > 40 THEN
        INSERT INTO hora_extra (ID_Func, HorasExcedidas)
        VALUES (p_ID_Func, total_horas - 40)
        ON DUPLICATE KEY UPDATE HorasExcedidas = total_horas - 40;
    ELSE
        DELETE FROM hora_extra WHERE ID_Func = p_ID_Func;
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER trigger_calcula_horas AFTER INSERT ON Trabalha
FOR EACH ROW
BEGIN
    CALL CalculaHorasTrabalhadas(NEW.ID_Func);
END //

DELIMITER ;

	
    
