USE db_estudo


-- CRIANDO TABELA | �NDICE CLUSTERED
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

-- CRIA O �NDICE
CREATE CLUSTERED INDEX [IX_Nm_Cliente]
ON [dbo].[Cliente] (Nm_Cliente)

-- EXECUTAR O SELECT E CONFERIR O PLANO DE EXECU��O
SELECT *
FROM [dbo].[Cliente]
WHERE Nm_Cliente = 'Luiz Gustavo'

-- DEOP INDEX
DROP INDEX [dbo].[Cliente].[IX_Nm_Cliente]

GO

-- CRIANDO TABELA | �NDICE NonCluestered

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

-- CRIA �NDICE NonClustered
DROP INDEX IF EXISTS dbo.Cliente.[Ix_Nm_Cliente]

CREATE NONCLUSTERED INDEX [Ix_Nm_Cliente]
ON [dbo].[Cliente] (Nm_Cliente)

-- EXECUTAR O SELECT E CONFERIR O PLANO DE EXECU��O
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

-- 2) CRIANDO A CONSTRAINT AP�S A CRIA��O DA TABELA
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

/*Mensagem 1779, N�vel 16, Estado 0, Linha 123
A tabela 'Cliente' j� tem uma chave prim�ria definida.
Mensagem 1750, N�vel 16, Estado 0, Linha 123
N�o foi poss�vel criar a restri��o ou o �ndice. Consulte os erros anteriores.
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
Mensagem 8111, N�vel 16, Estado 1, Linha 142
N�o � poss�vel definir a restri��o PRIMARY KEY em coluna anul�vel na tabela 'Cliente'.
Mensagem 1750, N�vel 16, Estado 0, Linha 142
N�o foi poss�vel criar a restri��o ou o �ndice. Consulte os erros anteriores.
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

/*Mensagem 2627, N�vel 14, Estado 1, Linha 171
Viola��o da restri��o PRIMARY KEY 'PK_Cliente'. N�o � poss�vel inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada � (Luiz Gustavo).
A instru��o foi finalizada.
*/

-- 6) ADICIONANDO UMA PRIMARY KEY COMPOSTA 
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR(100) NOT NULL,
	Dt_Nascimento DATE NOT  NULL,
	Fl_Sexo TINYINT NOT NULL)

-- ADICIONANDO A PRIMARY KEY
ALTER TABLE [dbo].[Cliente]
ADD CONSTRAINT [PK_Cliente] PRIMARY KEY (Nm_Cliente, Dt_Nascimento)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19990511', 1)

SELECT * FROM [dbo].[Cliente]

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19990511', 1)

SELECT * FROM [dbo].[Cliente]

/*
Mensagem 2627, N�vel 14, Estado 1, Linha 206
Viola��o da restri��o PRIMARY KEY 'PK_Cliente'. N�o � poss�vel inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada � (Luiz Gustavo, 1999-05-11).
A instru��o foi finalizada.
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSTRAINTS
-- UNIQUE CONSTRAINTS
--------------------------------------------------------------------------------------------------------------------------------------------------------
USE db_estudo

--1) DEFININDO NA CRIA��O DA TABELA
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL,
	CONSTRAINT [UQ_Cliente] UNIQUE (Id_Cliente)) -- CONSTRAINT UNIQUE

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1),
			  ('Luiz Gustavo', '19980429', 1) 			  
			  
SELECT * FROM [dbo].[Cliente]

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1) -- REGISTRO DUPLICADO PODEM SER INSERIDOS, POIS A VALIDA��O � NO ID_CLIENTE (Id_Cliente INT IDENTITY (1,1) NOT NULL)
							
SELECT * FROM [dbo].[Cliente]

-- 2) DEFININDO AP�S CRIA��O DA TABELA
USE db_estudo

DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT * FROM [dbo].[Cliente]

-- ADICIONANDO A UNIQUE CONSTRAINT
ALTER TABLE  [dbo].[Cliente]
ADD CONSTRAINT [UQ_Cliente] UNIQUE (Id_Cliente)

-- 3) DEFININDO UMA SEGUNDA UNIQUE CONSTRAINT (Nm_Cliente)
ALTER TABLE [dbo].[Cliente]
ADD CONSTRAINT [UQ_Nm_Cliente] UNIQUE (Nm_Cliente)

-- 4) UTILIZANDO COLUNA QUE ACEITA NULL
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL)

-- ADICIONANDO A UNIQUE CONSTRAINT 
ALTER TABLE [dbo].[Cliente] 
ADD CONSTRAINT [UQ_Nm_Cliente] UNIQUE (Nm_Cliente)

-- INSERINDO VALOR NULO
INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES (NULL, '19980429', 1)

SELECT * FROM [dbo].[Cliente]

-- INSERINDO MAIS UMA LINHA NULL
-- � PERMITIDA A CRIA��O DE UNIQUE EM UM COLUNA NULL, LIMITANDO 1 NULL POR COLUNA
INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES (NULL, CAST(GETDATE() AS date), 1)

/*
Mensagem 2627, N�vel 14, Estado 1, Linha 288
Viola��o da restri��o UNIQUE KEY 'UQ_Nm_Cliente'. N�o � poss�vel inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada � (<NULL>).
A instru��o foi finalizada.
*/

SELECT * FROM [dbo].[Cliente]

-- 5) INSERINDO VALORES DUPLICADOS, UNIQUE (Nm_Cliente)
ALTER TABLE [dbo].[Cliente]
ADD CONSTRAINT [UQ_Nm_Cliente] UNIQUE (Nm_Cliente)

-- 4) UTILIZANDO COLUNA QUE ACEITA NULL
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL)

-- ADICIONANDO A UNIQUE CONSTRAINT (Nm_Cliente)
ALTER TABLE [dbo].[Cliente]
ADD CONSTRAINT [UQ_Nm_Cliente] UNIQUE (Nm_Cliente)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES('Luiz Gustavo', CAST(GETDATE() AS date), 1)

SELECT * FROM [dbo].[Cliente] 

-- INSERINDO VALOR DUPLICADO
-- LIMITANDO 1 NOME POR COLUNA
INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES('Luiz Gustavo', CAST(GETDATE() AS date), 1)

/*
Mensagem 2627, N�vel 14, Estado 1, Linha 322
Viola��o da restri��o UNIQUE KEY 'UQ_Nm_Cliente'. N�o � poss�vel inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada � (Luiz Gustavo).
A instru��o foi finalizada.
*/

-- 6) UTILIZANDO UNIQUE CONSTRAINT COMPOSTO(MAIS DE UMA COLUNA PARA VALIDA��O)
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL,
	CONSTRAINT [UQ_Cliente] UNIQUE ( Nm_Cliente, Dt_Nascimento)) -- CONSTRAINT UNIQUE

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT * FROM [dbo].[Cliente]

-- INSERINDO COM NOME IGUAL, MAS DATA DE NASCIMENTO DIFERENTE
INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19970429', 1)

SELECT * FROM [dbo].[Cliente]

-- INSERINDO COM NOME IGUAL E MESMA DATA DE NASCIMENTO
-- LIMITANDO 1 NOME POR COLUNA
INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19970429', 1)

SELECT * FROM [dbo].[Cliente]

/*
Mensagem 2627, N�vel 14, Estado 1, Linha 354
Viola��o da restri��o UNIQUE KEY 'UQ_Cliente'. N�o � poss�vel inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada � (Luiz Gustavo, 1997-04-29).
A instru��o foi finalizada.
*/

-- PRIMARI KEY + UNIQUE 
DROP TABLE IF EXISTS [dbo].[Cliente]

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR (100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL,
	CONSTRAINT [UQ_Cliente] UNIQUE ( Nm_Cliente), -- CONSTRAINT UNIQUE
	CONSTRAINT [PK_Id_Cliente] PRIMARY KEY (Id_Cliente))

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT * FROM [dbo].[Cliente]

-- INSERINDO MESMO DADO
-- LIMITANDO 1 NOME POR COLUNA
INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento, Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

SELECT * FROM [dbo].[Cliente]

/*
Mensagem 2627, N�vel 14, Estado 1, Linha 382
Viola��o da restri��o UNIQUE KEY 'UQ_Cliente'. N�o � poss�vel inserir a chave duplicada no objeto 'dbo.Cliente'. O valor de chave duplicada � (Luiz Gustavo).
A instru��o foi finalizada.
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSTRAINTS
-- FOREIGN KEY
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1) TESTE FOREIGN KEY

DROP TABLE IF EXISTS [dbo].[Tipo_Produto]
GO

-- CRIANDO TABELA [dbo].[Tipo_Produto]
CREATE TABLE [dbo].[Tipo_Produto] (
	Id_Tipo_Produto INT IDENTITY(1,1) NOT NULL,
	Nm_Tipo_Produto VARCHAR (100) NOT NULL
	CONSTRAINT [PK_Tipo_Produto] PRIMARY KEY (Id_Tipo_Produto)
)

INSERT INTO [dbo].[Tipo_Produto] (Nm_Tipo_Produto)
VALUES ('Celular'), ('Video Game')

SELECT * FROM [dbo].[Tipo_Produto] 

-- CRIANDO TABELA [dbo].[Produto]
DROP TABLE IF EXISTS [dbo].[Produto]

CREATE TABLE [dbo].[Produto] (
	Id_Produto INT IDENTITY(1,1) NOT NULL,
	Nm_Produto VARCHAR (100) NOT NULL,
	Id_Tipo_Produto INT NOT NULL,
	CONSTRAINT [PK_Produto] PRIMARY KEY (Id_Produto))

-- ADRICIONANDO FOREIGN KEY
ALTER TABLE			 [dbo].[Produto] 
ADD CONSTRAINT [FK_Tipo_Produto] FOREIGN KEY ([Id_Tipo_Produto])
REFERENCES			 [dbo].[Tipo_Produto]  ([Id_Tipo_Produto])

-- ADICIONANDO ALGUNS PRODUTOS
INSERT INTO [dbo].[Produto] 
VALUES ('Samsumg Galaxy', 1), ('Iphone', 1), 
			  ('Playstation',2),  ('Xbox',2)

SELECT * FROM [dbo].[Tipo_Produto] 
SELECT * FROM  [dbo].[Produto] 

-- TENTANDO INSERIR UM TIPO DE PRODUTO INEXISTENTE
INSERT INTO [dbo].[Produto] 
VALUES ('Notebook Dell', 3)

/*
Mensagem 547, N�vel 16, Estado 0, Linha 437
A instru��o INSERT conflitou com a restri��o do FOREIGN KEY "FK_Tipo_Produto". O conflito ocorreu no banco de dados "db_estudo", tabela "dbo.Tipo_Produto", column 'Id_Tipo_Produto'.
A instru��o foi finalizada.
*/

-- TENTAR FAZER UM UPDATE COM UM TIPO DE PRODUTO INEXISTENTE
-- TOMA ERRO TANTO NA INSER��O DO DADO INEXISTENTE, QUANTO NO UPDATE
 UPDATE [dbo].[Produto] 
 SET [Id_Tipo_Produto] = 10
 WHERE Id_Produto = 2

 /*
 Mensagem 547, N�vel 16, Estado 0, Linha 447
A instru��o UPDATE conflitou com a restri��o do FOREIGN KEY "FK_Tipo_Produto". O conflito ocorreu no banco de dados "db_estudo", tabela "dbo.Tipo_Produto", column 'Id_Tipo_Produto'.
A instru��o foi finalizada.
*/


-- 2) FOREIGN KEY - INSERINDO COLUNAS COM O VALOR NULL
DROP TABLE IF EXISTS [dbo].[Tipo_Produto]
GO

-- CRIANDO TABELA [dbo].[Tipo_Produto]
DROP TABLE IF EXISTS [dbo].[Tipo_Produto]

CREATE TABLE [dbo].[Tipo_Produto] (
	Id_Tipo_Produto INT IDENTITY(1,1) NOT NULL,
	Nm_Tipo_Produto VARCHAR (100) NOT NULL
	CONSTRAINT [PK_Tipo_Produto] PRIMARY KEY (Id_Tipo_Produto))


 -- CRIANDO TABELA [dbo].[Produto]
DROP TABLE IF EXISTS [dbo].[Produto]

CREATE TABLE [dbo].[Produto] (
	Id_Produto INT IDENTITY(1,1) NOT NULL,
	Nm_Produto VARCHAR (100) NOT NULL,
	Id_Tipo_Produto INT NULL,
	CONSTRAINT [PK_Produto] PRIMARY KEY (Id_Produto))

-- ADICIONANDO A FOREIGN KEY
ALTER TABLE [dbo].[Produto]
ADD CONSTRAINT [FK_Tipo_Produto] FOREIGN KEY ([Id_Tipo_Produto])
REFERENCES [Tipo_Produto] ([Id_Tipo_Produto])

-- � PERMITIDO INSERIR MAIS DE UM DADO NULO
INSERT INTO [dbo].[Produto] (Nm_Produto, Id_Tipo_Produto)
VALUES ('Notebook HP', NULL)

SELECT * FROM [dbo].[Produto]
 
INSERT INTO [dbo].[Produto] (Nm_Produto, Id_Tipo_Produto)
VALUES ('Notebook Dell', NULL)

SELECT * FROM [dbo].[Produto]

 -- 3)TABELA COM MAIS DE UM FOREIGN KEY
DROP TABLE IF EXISTS [dbo].[Produto] 
DROP TABLE IF EXISTS [dbo].[Tipo_Produto]
DROP TABLE IF EXISTS [dbo].[Fornecedor] 
GO

-- TABELA TIPO PRODUTO
CREATE TABLE [dbo].[Tipo_Produto] (
	Id_Tipo_Produto INT IDENTITY(1,1) NOT NULL,
	Nm_Tipo_Produto VARCHAR (100) NOT NULL
	CONSTRAINT [PK_Tipo_Produto] PRIMARY KEY (Id_Tipo_Produto))

INSERT INTO [dbo].[Tipo_Produto] 
VALUES ('Celular'), ('Video Game')

SELECT * FROM [dbo].[Tipo_Produto] 

-- TABELA FORNECEDOR
CREATE TABLE [dbo].[Fornecedor] (
	Id_Fornecedor INT IDENTITY (1,1) NOT NULL,
	Nm_Fornecedor VARCHAR (100) NOT NULL,
	CONSTRAINT [PK_Fornecedor] PRIMARY KEY (Id_Fornecedor))

INSERT INTO [dbo].[Fornecedor]
VALUES ('Sony'), ('Microsoft')

SELECT * FROM [dbo].[Fornecedor]

-- TABELA PRODUTO
CREATE TABLE [dbo].[Produto] (
	Id_Produto INT IDENTITY (1,1) NOT NULL,
	Nm_Produto VARCHAR (100) NOT NULL,
	Id_Tipo_Produto INT NOT NULL,
	Id_Fornecedor INT NOT NULL,
	CONSTRAINT [PK_Produto] PRIMARY KEY (Id_Produto))

	-- ADICIONANDO FOREIGN KEY
	ALTER TABLE [dbo].[Produto]
	ADD CONSTRAINT [FK_Tipo_Produto] FOREIGN KEY (Id_Tipo_Produto)
	REFERENCES [dbo].[Tipo_Produto]  (Id_Tipo_Produto)

	ALTER TABLE [dbo].[Produto]
	ADD CONSTRAINT [FK_Fornecedor] FOREIGN KEY (Id_Fornecedor)
	REFERENCES [dbo].[Fornecedor]  (Id_Fornecedor)

	SELECT * FROM [dbo].[Tipo_Produto]
	SELECT * FROM  [dbo].[Fornecedor]


	INSERT INTO [dbo].[Produto] (Nm_Produto, Id_Tipo_Produto, Id_Fornecedor)
	VALUES 
		('Sony Cell', 1,1), ('Microsoft Cell', 1,2),
		('Playstation', 2,1), ('Xbox', 2,2)
	
	SELECT * FROM [dbo].[Produto] 

-- TENTAR INSERIR UM TIPO DE PRODUTO QUE N�O EXISTE
INSERT INTO [dbo].[Produto]  (Nm_Produto, Id_Tipo_Produto, Id_Fornecedor)
VALUES 
		('Notebook Dell', 3,1)

/*
Mensagem 547, N�vel 16, Estado 0, Linha 556
A instru��o INSERT conflitou com a restri��o do FOREIGN KEY "FK_Tipo_Produto". O conflito ocorreu no banco de dados "db_estudo", tabela "dbo.Tipo_Produto", column 'Id_Tipo_Produto'.
A instru��o foi finalizada.
*/

-- TENTAR INSERIR UM TIPO DE PRODUTO QUE N�O EXISTE
INSERT INTO [dbo].[Produto]  (Nm_Produto, Id_Tipo_Produto, Id_Fornecedor)
VALUES 
		('Notebook Dell', 1,3)

/*
Mensagem 547, N�vel 16, Estado 0, Linha 567
A instru��o INSERT conflitou com a restri��o do FOREIGN KEY "FK_Fornecedor". O conflito ocorreu no banco de dados "db_estudo", tabela "dbo.Fornecedor", column 'Id_Fornecedor'.
A instru��o foi finalizada.
*/

-- RETORNANDO A DESCRI��O DE OUTRAS TABELAS COM JOINS
SELECT  
	P.Nm_Produto, 
	T.Nm_Tipo_Produto, 
	F.Nm_Fornecedor
FROM [dbo].[Produto] AS P

JOIN [dbo].[Tipo_Produto] AS T ON T.Id_Tipo_Produto = P.Id_Tipo_Produto
JOIN [dbo].[Fornecedor] AS F ON F.Id_Fornecedor = P.Id_Fornecedor
ORDER BY Nm_Produto

-- 4) FOREIGN KEY REFERENCIADO A PROPRIA TABELA

