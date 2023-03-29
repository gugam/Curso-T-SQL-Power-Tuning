USE db_estudo


-- CRIANDO TABELA | ÍNDICE CLUSTERED
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR(100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL,
	Dt_Cadastro DATETIME NOT NULL CONSTRAINT DF_DtCadastro DEFAULT (GETDATE())
)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Yasmim Vieira', '19990511', 0)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT *
FROM [dbo].[Cliente]
WHERE Nm_Cliente = 'Luiz Gustavo'

-- CRIA O ÍNDICE
CREATE CLUSTERED INDEX [IX_Nm_Cliente]
ON [dbo].[Cliente] (Nm_Cliente)

-- EXECUTAR O SELECT E CONFERIR O PLANO DE EXECUÇÃO
SELECT *
FROM [dbo].[Cliente]
WHERE Nm_Cliente = 'Luiz Gustavo'

-- DEOP INDEX
DROP INDEX [dbo].[Cliente].[IX_Nm_Cliente]

GO

-- CRIANDO TABELA | ÍNDICE NonCluestered

DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL,
	Dt_Cadastro DATETIME NOT NULL CONSTRAINT Df_DtCadastro DEFAULT(GETDATE())
)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Yasmim Vieira', '19990511', 0)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT *
FROM [dbo].[Cliente]
WHERE Nm_Cliente = 'Luiz Gustavo'

-- CRIA ÍNDICE NonClustered
DROP INDEX IF EXISTS dbo.Cliente.[Ix_Nm_Cliente]

CREATE NONCLUSTERED INDEX [Ix_Nm_Cliente]
ON [dbo].[Cliente] (Nm_Cliente)

-- EXECUTAR O SELECT E CONFERIR O PLANO DE EXECUÇÃO
SELECT Nm_Cliente
FROM [dbo].[Cliente]
WHERE Nm_Cliente = 'Luiz Gustavo'

 /*		CONSTRAINTS		*/
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- PRIMARY KEY (PK)
--------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS [dbo].[Cliente]
-- 1) CRIANDO A CONSTRAINT JUNTO COM A TABELA
CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_ClIente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL,
	CONSTRAINT [PK_Cliente] PRIMARY KEY (Id_Cliente)
)

INSERT INTO [dbo].[Cliente] (Nm_ClIente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT * FROM [dbo].[Cliente]

INSERT INTO [dbo].[Cliente] (Nm_ClIente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

INSERT INTO [dbo].[Cliente] (Nm_ClIente, Dt_Nascimento, Fl_Sexo)
VALUES ('Yasmim Vieira', '19990511', 0)

SELECT * FROM [dbo].[Cliente]

-- 2) CRIANDO A CONSTRAINT APÓS A CRIAÇÃO DA TABELA
DROP TABLE IF EXISTS [dbo].[Cliente] 

CREATE TABLE [dbo].[Cliente] ( 
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
	)

	-- ADICIONANDO A PRIMARY KEY 
	ALTER TABLE  [dbo].[Cliente]
	ADD CONSTRAINT [PK_Cliente]
	PRIMARY KEY (Id_Cliente)

INSERT INTO [dbo].[Cliente] (Nm_ClIente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

INSERT INTO [dbo].[Cliente] (Nm_ClIente, Dt_Nascimento, Fl_Sexo)
VALUES ('Yasmim Vieira', '19990511', 0)

SELECT * FROM [dbo].[Cliente]

-- 3) TENTANDO DEFINIR UMA SEGUNDA PRIMARY KEY
ALTER TABLE [dbo].[Cliente]
ADD CONSTRAINT [PK_Cliente]
PRIMARY KEY (Nm_Cliente)

/*Mensagem 1779, Nível 16, Estado 0, Linha 123
A tabela 'Cliente' já tem uma chave primária definida.
Mensagem 1750, Nível 16, Estado 0, Linha 123
Não foi possível criar a restrição ou o índice. Consulte os erros anteriores.
*/

-- 4)  TENTANDO UTILIZAR EM COLUNA QUE ACEITA NULLL
DROP TABLE IF EXISTS [dbo].[Cliente] 

CREATE TABLE [dbo].[Cliente] ( 
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100)  NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
	)

ALTER TABLE [dbo].[Cliente]
ADD CONSTRAINT [PK_Cliente]
PRIMARY KEY (Nm_Cliente)

/*
Mensagem 8111, Nível 16, Estado 1, Linha 142
Não é possível definir a restrição PRIMARY KEY em coluna anulável na tabela 'Cliente'.
Mensagem 1750, Nível 16, Estado 0, Linha 142
Não foi possível criar a restrição ou o índice. Consulte os erros anteriores.
*/

-- 5) TENTANDO INSERIR UM REGISTRO DUPLICADO

DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente](
	ID_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL)

-- ADICIONANDO A PRIMARY KEY
ALTER TABLE  [dbo].[Cliente]
ADD CONSTRAINT [PK_Cliente]
PRIMARY KEY (Nm_Cliente)

INSERT INTO [dbo].Cliente (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

--SELECT * FROM dbo.Cliente

INSERT INTO [dbo].Cliente (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT * FROM dbo.Cliente

/*Mensagem 2627, Nível 14, Estado 1, Linha 171
Violação da restrição PRIMARY KEY 'PK_Cliente'. Não é possível inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada é (Luiz Gustavo).
A instrução foi finalizada.
*/

-- 6) ADICIONANDO UMA PRIMARY KEY COMPOSTA 
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR(100) NOT NULL,
	Dt_Nascimento DATE NOT  NULL,
	Fl_Sexo TINYINT NOT NULL
)

-- ADICIONANDO A PRIMARY KEY
ALTER TABLE [dbo].[Cliente]
ADD CONSTRAINT [PK_Cliente]
PRIMARY KEY (Nm_Cliente, Dt_Nascimento)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19990511', 1)

SELECT * FROM [dbo].[Cliente]

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19990511', 1)

SELECT * FROM [dbo].[Cliente]

/*
Mensagem 2627, Nível 14, Estado 1, Linha 206
Violação da restrição PRIMARY KEY 'PK_Cliente'. Não é possível inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada é (Luiz Gustavo, 1999-05-11).
A instrução foi finalizada.
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSTRAINTS
-- UNIQUE CONSTRAINTS
--------------------------------------------------------------------------------------------------------------------------------------------------------


