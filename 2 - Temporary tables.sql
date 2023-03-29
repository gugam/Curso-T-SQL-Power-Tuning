USE db_estudo

CREATE TABLE [dbo].[Cliente](
		Id_Cliente INT IDENTITY NOT NULL,
		Nm_Cliente VARCHAR (100) NOT NULL,
		Dt_Nascimento DATE NOT NULL,
		Fl_Sexo TINYINT NOT NULL
)

-- INSERIR COLUNA
ALTER TABLE  [dbo].[Cliente]
ADD Telefone VARCHAR (11) NULL

-- ALTERAR COLUNA - TIPO DE DADOS
ALTER TABLE [dbo].[Cliente]
ALTER COLUMN Telefone VARCHAR (9) NULL

-- ALTERAR COLUNA - NOME DA COLUNA 
EXEC sp_rename '[dbo].[Cliente].[Telefone]',
'Celular', 'Column'

-- DELETAR COLUNA
ALTER TABLE [dbo].[Cliente]
DROP COLUMN Celular

SELECT * FROM  [dbo].[Cliente]
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO TABELA TEMPORÁRIA - LOCAL #
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE db_estudo

CREATE TABLE #Cliente (
		Id_Cliente INT IDENTITY NOT NULL,
		Nm_Cliente VARCHAR (100) NOT NULL,
		Dt_Nascimento DATE NOT NULL,
		Fl_Sexo TINYINT NOT NULL
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO TABELA TEMPORÁRIA - GLOBAL  ##
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE db_estudo

CREATE TABLE ##Cliente (
		Id_Cliente INT IDENTITY NOT NULL,
		Nm_Cliente VARCHAR (100) NOT NULL,
		Dt_Nascimento DATE NOT NULL,
		Fl_Sexo TINYINT NOT NULL
) 

-- MODIFICANDO A COLLATION UTILIZANDO COLLATE
SELECT * FROM Cliente
WHERE Nm_Cliente = 'Luiz Gustavo'

SELECT * FROM Cliente
WHERE Nm_Cliente  COLLATE Latin1_General_CS_AS = 'Luiz Gustavo'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO SCHEMAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE db_estudo

CREATE TYPE [Vendas].[CPF] FROM CHAR (11)

CREATE SCHEMA [Vendas]
GO

CREATE SCHEMA [RH]
GO

CREATE SCHEMA CPF VARCHAR(11)
GO

DROP TABLE IF EXISTS [Vendas].[Estoque]
DROP TABLE IF EXISTS [dbo].[Estoque]
GO

CREATE TABLE [Vendas].[Estoque] (
		IdProduto INT NOT NULL,
		IdQtde INT NOT NULL
)

DROP TABLE IF EXISTS [Vendas].[Vendedor]
GO

CREATE TABLE [Vendas].[Vendedor] (
		IdVendedor INT IDENTITY NOT NULL,
		NmVendedor VARCHAR(100) NOT NULL,
		CPF CPF, 
		DtNascimento DATE
)

DROP TABLE IF EXISTS [RH].[Funcionario]
GO

CREATE TABLE  [RH].[Funcionario] (
	IdFuncionario INT IDENTITY(1,1) NOT NULL,
	NmFuncionario VARCHAR (100) NOT NULL,
	CPF CPF,
	DtNascimento DATE NOT NULL,
	VlSalario NUMERIC (9,2) NOT NULL
)

DROP TABLE IF EXISTS [RH].[Ferias]

CREATE TABLE  [RH].[Ferias] (
	IdFuncionario INT NOT NULL,
	FlStatus TINYINT NOT NULL,
	DtInicio DATE NOT NULL,
	DtFim DATE NOT NULL
)

-- SCHEMA "dbo":
SELECT * FROM Cliente

SELECT * FROM [dbo].[Cliente]

-- SCHEMA "Vendas":
SELECT * FROM [Estoque]

/*Mensagem 208, Nível 16, Estado 1, Linha 114
Nome de objeto 'Estoque' inválido.
*/

SELECT * FROM [Vendas].[Estoque]

-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO LOGIN
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE db_estudo

CREATE LOGIN userTeste   
    WITH PASSWORD = '12345';  
GO  

-- Creates a database user for the login created above.  
CREATE USER userTeste 
	FOR LOGIN userTeste;  
GO  

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LIBERANDO ACESSO DE LEITURA
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT SELECT ON [Vendas].[Estoque]  TO userTeste -- Acesso a tabela específica;

/*Mensagem 229, Nível 14, Estado 5, Linha 3
A permissão SELECT foi negada no objeto 'Estoque', banco de dados 'db_estudo', esquema 'Vendas'.
*/

GRANT SELECT ON SCHEMA::[Vendas] TO userTeste -- Acesso ao schema 

-- RETIRANDO ACESSO DE LEITURA
REVOKE SELECT ON [Vendas].Estoque TO userTeste

REVOKE SELECT ON SCHEMA::[Vendas] TO userTeste

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO TABELAS 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Fl_Sexo
	0 -> Feminino
	1 -> Masculino
*/

DROP TABLE IF EXISTS [dbo].[Cliente]
GO

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1),
			  ('Yasmim Vieira', '19990511', 0)

--INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
--VALUES ('Yasmim Vieira', '19990511', 0)

SELECT * FROM [dbo].[Cliente]

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--		1) ALTERAÇÃO EM TABELAS:
--		 	 INSERIR COLUNA
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE [dbo].[Cliente]
ADD Telefone VARCHAR(9) NULL

SELECT * FROM [dbo].[Cliente]

--		ALTERAR COLUNA - TIPO DE DADOS(CUIDADAO COM TABELAS GRANDES)
ALTER TABLE [dbo].[Cliente]
ALTER COLUMN Telefone VARCHAR(11) NULL

--		ALTERAR COLUNA - NOME DA COLUNA
EXEC sp_rename 'Cliente.Telefone', 'Celular', 'column'

--		DELETAR COLUNA 
ALTER TABLE [dbo].[Cliente]
DROP COLUMN Celular

SELECT * FROM [dbo].[Cliente]

--		1) CRIANDO TABELAS COM PALAVRAS RESERVADAS

DROP TABLE IF EXISTS "FROM"
GO

CREATE TABLE "FROM" (
	"SELECT" VARCHAR (100),
	"FROM" VARCHAR (100),
	[WHERE] VARCHAR(100),
	[ORDER BY ] VARCHAR (100)
)

INSERT INTO "FROM" 
VALUES ('SELECT', 'FROM', 'GROPUP BY', 'ORDER BY')

SELECT [FROM], "WHERE", "ORDER BY"
FROM "FROM"
GROUP BY [FROM], "WHERE", "ORDER BY"
ORDER BY [ORDER BY]

-- ALTERANDO INFORMAÇÃO DA LINHA
UPDATE "FROM"
	SET "WHERE" = 'WHERE'
	WHERE "SELECT" = 'SELECT'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO TABELA TEMPORÁRIA - LOCAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE  #Cliente (
	Id_Cliente INT IDENTITY NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
)

INSERT INTO #Cliente (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1),
			  ('Yasmim Vieira', '19990511', 0)

SELECT * FROM #Cliente

DROP TABLE #Cliente

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO TABELA TEMPORÁRIA - GLOBAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE db_estudo

DROP TABLE IF EXISTS ##Cliente

CREATE TABLE  ##Cliente (
	Id_Cliente INT IDENTITY NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
)

INSERT INTO ##Cliente (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1),
			  ('Yasmim Vieira', '19990511', 0)

SELECT * FROM ##Cliente

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIANDO TABELA TEMPORÁRIA - VARIÁVEL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE db_estudo

DECLARE @Cliente TABLE (
	Id_Cliente INT IDENTITY NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
)

INSERT INTO @Cliente (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1),
			  ('Yasmim Vieira', '19990511', 0)

SELECT * FROM @Cliente

GO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DESAFIO 1 - VARIÁVEIS
--ROLLBACK não funciona em variáveis. Neste caso, deveria desfazer a multiplicação
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @Num INT = 10000
	BEGIN TRAN 
		SET @Num = @Num * 2
ROLLBACK;

SELECT @Num

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DESAFIO 2 - TABELAS VARIÁVEIS
--ROLLBACK não funciona em variáveis. Neste caso, deveria desfazer os inserts
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @People TABLE (Name VARCHAR (50))

BEGIN TRAN
	INSERT INTO @People VALUES ('Luiz Gustavo');
	INSERT INTO @People VALUES ('Yasmim Vieira');

ROLLBACK

SELECT * FROM @People

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DESAFIO 3 - TABELAS TEMPORÁRIA LOCAIS
--ROLLBACK funciona
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #Cliente

CREATE TABLE  #Cliente (
	Id_Cliente INT IDENTITY NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
)
BEGIN TRAN
INSERT INTO #Cliente (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1),
			  ('Yasmim Vieira', '19990511', 0)

ROLLBACK

SELECT * FROM #Cliente













