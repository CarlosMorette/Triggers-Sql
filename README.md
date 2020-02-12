## Triggers

### O que s�o Triggers?

O termo trigger (gatilho em ingl�s) define uma estrutura do banco de dados que funciona, como o nome sugere, como uma fun��o que � disparada mediante alguma a��o. Geralmente essas a��es que disparam os triggers s�o altera��es nas tabelas por meio de opera��es de inser��o, exclus�o e atualiza��o de dados (insert, delete e update).

Um gatilho est� intimamente relacionado a uma tabela, sempre que uma dessas a��es � efetuada sobre essa tabela, � poss�vel dispar�-lo para executar alguma tarefa.

### A sintaxe para cria��o de um trigger � a seguinte:
```sql
CREATE TRIGGER [NOME DO TRIGGER]
ON  [NOME DA TABELA]
[FOR/AFTER/INSTEAD OF]  [INSERT/UPDATE/DELETE]
AS
    --CORPO DO TRIGGER
```

####**Exemplo:**
```sql
CREATE TRIGGER utrEnviarEmailAlunoNovo	
ON Aluno 

FOR INSERT-- Para quando [inserir,alterar,excluir]
AS
BEGIN 
	DECLARE
		@IdAluno int,
		@Nome varchar(100);

		SELECT 
			@IdAluno = IdAluno,
			@Nome = Nome
		FROM 
			INSERTED -- Que acabou de ser inserido

		INSERT INTO EnviarEmail	(Destinatario, Assunto,	Corpo )
		VALUES
		(
			'aluno.teste@email.com',
			'Novo aluno cadastrado',
			'Foi cadastrado o aluno codigo' + CAST(@IdAluno AS VARCHAR) + ' nome' + @Nome
		)		
END

SELECT * FROM Aluno;
SELECT * FROM EnviarEmail;


INSERT INTO Aluno(Nome, DataNascimento )
VALUES ('SAULO CAROL', '2020-01-04')
```
