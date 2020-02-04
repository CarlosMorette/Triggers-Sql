CREATE DATABASE TesteTrigger_Security
GO

USE TesteTrigger_Security
GO

CREATE TABLE testeTrigger
(
	idTeste			INT PRIMARY KEY IDENTITY,
	mensagemTeste	VARCHAR(50)
);
GO

--  CRIANDO O GATILHO PARA BARRAR A TENTATIVA DE DROPAR A TABELA (testeTrigger)
CREATE TRIGGER securityTest
ON	DATABASE
FOR DROP_TABLE
AS
	BEGIN
		PRINT 'Voc� deve desativar o gatilho (testeTrigger) para completar esta a��o'
		ROLLBACK;
	END
GO

-- TENTANDO DROPAR A TABELA
DROP TABLE testeTrigger
GO

-- PARA DROPAR A TABELA DEVEMOS DESATIVAR O GATILHO
IF EXISTS (SELECT * FROM sys.triggers
		   WHERE name = 'securityTest')
DISABLE TRIGGER securityTest ON DATABASE
GO

DROP TABLE testeTrigger
GO

SELECT * FROM testeTrigger
GO