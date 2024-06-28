-- 1. Liste o nome, o CPF e a data de nascimento de todos os alunos.
-- 2. Liste o nome, o CPF e o sexo de todos os alunos nascidos após 1990.
-- 3. Liste o nome do curso com a maior carga horária.
-- 4. Excluir todas as disciplinas com a carga horária inferior a 20 horas:
-- 5. Liste o ID do aluno com a menor nota na disciplina de Programação Orientada a
-- Objetos.
-- 6. Liste os IDS de todos os alunos que estão matriculados em um curso com carga
-- horária superior a 2400 horas:
-- 7. Liste o nome, o nome do curso e a carga horária do curso de cada aluno.
-- 8. Atualizar a carga horária do curso de Administração para 300 horas: 


-- Seleciona o nome, CPF e data de nascimento de todos os alunos
SELECT nome, cpf, data_nascimento
FROM aluno;

-- Seleciona nome, CPF e data de nascimento dos alunos nascidos após 1990-12-31
SELECT nome, cpf, data_nascimento
FROM aluno
WHERE data_nascimento > '1990-12-31';

-- Seleciona nome e CPF dos alunos nascidos após 1990
SELECT nome, cpf
FROM aluno
WHERE YEAR(data_nascimento) > 1990;

-- Seleciona o nome do curso com a maior carga horária
SELECT nome
FROM curso
ORDER BY carga_horaria DESC
LIMIT 1;

-- Seleciona todas as colunas da tabela disciplina
SELECT *
FROM disciplina;

-- Insere uma nova disciplina chamada "Testes" com carga horária de 15
INSERT INTO disciplina VALUES (null, 'Testes', 15);

-- Deleta disciplinas cuja carga horária é menor que 20
DELETE FROM disciplina
WHERE carga_horaria < 20;

-- Seleciona o ID e nome do aluno com a menor nota na disciplina 'Programação Orientada a Objetos'
SELECT a.id_aluno, a.nome
FROM aluno AS a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN matricula_disciplina md ON md.id_matricula = m.id_matricula
JOIN disciplina d ON d.id_disciplina = md.id_disciplina
WHERE d.nome = 'Programação Orientada a Objetos'
ORDER BY md.nota
LIMIT 1;

-- Seleciona o ID e nome dos alunos matriculados em cursos com carga horária maior que 2400
SELECT a.id_aluno, a.nome
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN curso c ON c.id_curso = m.id_curso
WHERE c.carga_horaria > 2400;

-- Seleciona o nome do aluno, nome do curso e carga horária do curso em que o aluno está matriculado
SELECT a.nome, c.nome, c.carga_horaria
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN curso c ON c.id_curso = m.id_curso;

-- Atualiza a carga horária do curso de Administração para 300
UPDATE curso
SET carga_horaria = 300
WHERE nome = 'Administração';

-- Seleciona todos os registros da tabela curso após a atualização
SELECT *
FROM curso;
