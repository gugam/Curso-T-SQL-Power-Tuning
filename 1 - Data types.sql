------------------------------------------------------------------------------------------------------------------------------
-- CRIA��O DO DATABASE
------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE db_estudo

-- CRIANDO DOIS TIPOS DE DADOS �NICOS (CPF E CEP)
CREATE TYPE [dbo].[CPF] FROM CHAR (11)
CREATE TYPE [dbo].[CEP] FROM CHAR (8)

-- CRIANDO A TABELA
CREATE TABLE curso
(
NOME CHAR (35),
CPF CPF,
CEP CEP
)

-- INSERINDO DADOS NA TABELA
SET NOCOUNT ON
INSERT INTO curso (CPF, NOME, CEP) VALUES 
('05121548720', 'LUIZ GUSTAVO DA SILVA', '15975345'),
('05105567501', 'GUSTAVO DA SILVA SOARES', '15948915'),
('05104235602', 'ANA CAROLINA', '11345615'),
('05103264890', 'JORDE DA CAPADOCIA', '11345615')
SET NOCOUNT OFF

-- ALTERANDO TIPO DE DADOS DE UMA COLUNA
ALTER TABLE curso
ALTER COLUMN CPF CPF

-- CHAMANDO TIPO DOS DADOS DA TABELA
exec sp_columns curso

-- FAZENDO UPDATE DE INFORMA��ES
UPDATE curso
	SET NOME = 'JORGE DA CAPADOCIA'
WHERE CPF = 05103264890

-- ADICIONANDO UMA COLUNA 
ALTER TABLE curso
	ADD APELIDO VARCHAR (35)

-- APAGANDO UMA COLUNA
ALTER TABLE curso
	DROP COLUMN APELIDO

-- DELETANDO INFORMA��ES ESPEC�FICAS
DELETE FROM curso
WHERE CPF = '05121548720'

-- QUQERY
SELECT * FROM curso

-- DECLARANDO VARI�VEIS
DECLARE @var_estudo DATE
SET @var_estudo =  DATEDIFF(DAY, GETDATE(),   1998-04-29)

SELECT @var_estudo;

------------------------------------------------------------------------------------------------------------------------------
-- CHAR / VARCHAR (1 BYTE POR CARACTER - TABELA ASCII)
-- NCHAR / NVARCHAR (2 BYTES POR CARACTER - TABELA UNICODE)
------------------------------------------------------------------------------------------------------------------------------

DECLARE @var_VARCHAR VARCHAR (50), @var_CHAR CHAR(50), @var_NVARCHAR NVARCHAR (50), @var_NCHAR NCHAR (50)

SELECT @var_CHAR = 'Luiz Gustavo'
SELECT @var_VARCHAR = 'Luiz Gustavo'
SELECT @var_NCHAR = 'Luiz Gustavo'
SELECT @var_NVARCHAR = 'Luiz Gustavo'

SELECT 
	@var_CHAR     AS var_CHAR,
	@var_VARCHAR  AS var_VARCHAR,
	@var_NCHAR	  AS var_NCHAR,
	@var_NVARCHAR AS var_NVARCHAR

-- RESULTAOD DAS COLUNAS CHAR E VARCHAR
-- CHAR: 'Luiz Gustavo                                      '
-- VARCHAR: 'Luiz Gustavo'
-- NCHAR: 'Luiz Gustavo                                      '
-- NVARCHAR: 'Luiz Gustavo'

IF (@var_CHAR = @var_VARCHAR)
	SELECT 'S�O IGUAIS!'
ELSE 
	SELECT 'S�O DIFERENTES"'

SELECT 
	@var_CHAR                  AS var_CHAR,
	LEN (@var_CHAR)            AS var_CHAR,
	DATALENGTH (@var_CHAR)     AS TAM_CHAR,
	DATALENGTH (@var_VARCHAR)  AS TAM_VARCHAR,
	DATALENGTH (@var_NCHAR)    AS TAM_NCHAR,
	DATALENGTH (@var_NVARCHAR) AS TAM_NVARCHAR

------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS TESTE_STRING_CHAR

CREATE TABLE TESTE_STRING_CHAR (
	FI_SEXO_CHAR CHAR (3) NOT NULL
)

DROP TABLE IF EXISTS TESTE_STRING_NCHAR

CREATE TABLE TESTE_STRING_NCHAR (
	FI_SEXO_NCHAR NCHAR (3) NOT NULL
)

--- INICIO TABELA INT PARA COMPARA��O 
DROP TABLE IF EXISTS TESTE_INTEIRO_INT

CREATE TABLE TESTE_INTEIRO_INT(
	FI_SEXO_INT INT NOT NULL
)

SET NOCOUNT ON
INSERT INTO TESTE_INTEIRO_INT (FI_SEXO_INT)
VALUES(1)
GO 100000
SET NOCOUNT OFF
-- FIM TABELA INT PARA COMPARA��O


-- POPULANDO AS TABELAS 

SET NOCOUNT ON

INSERT INTO TESTE_STRING_CHAR (FI_SEXO_CHAR)
VALUES ('FEM')
GO 10000

INSERT INTO TESTE_STRING_NCHAR (FI_SEXO_NCHAR)
VALUES ('FEM')
GO 10000

SET NOCOUNT OFF 

-- VALIDA O TAMANHO DAS TABELAS
EXEC sp_spaceused 'TESTE_STRING_CHAR' 
EXEC sp_spaceused 'TESTE_STRING_NCHAR'
EXEC sp_spaceused 'TESTE_INTEIRO_BIT'

------------------------------------------------------------------------------------------------------------------------------
-- DATE (1 BYTE POR CARACTER - TABELA ASCII)
-- DATETIME (2 BYTES POR CARACTER - TABELA UNICODE)
------------------------------------------------------------------------------------------------------------------------------

-- TIPO DATE
DECLARE @var_DATE DATE

-- SELECT @var_DATE = '20230202'
-- SELECT @var_DATE = '2023-02-02'
 SELECT @var_DATE = GETDATE()

SELECT @var_DATE AS var_DATE

------------------------------------------------------------------------------------------------------------------------------
-- TIPO DATETIME
DECLARE @var_DATETIME DATETIME

SELECT @var_DATETIME = GETDATE()

SELECT @var_DATETIME

------------------------------------------------------------------------------------------------------------------------------
-- CUIDADO COM O DATEFORMAT / LANGUAGE 
-- MODIFICANDO O DATEFORMAT

-- DBC USEROPTIONS
-- SET DATEFORMAT mdy	 /* N�O MUDA PARA AS OUTRAS SESS�ES DO BANCO DE DADOS
-- SET DATEFORMAT dmy		 MUDA APENAS PARA SUA SESS�O */

DECLARE @var_DATE DATE

SELECT @var_DATE = '20-02-2022'

SELECT @var_DATE

------------------------------------------------------------------------------------------------------------------------------
-- CUIDADO COM O DATEFORMAT / LANGUAGE 
-- MODIFICANDO A LINGUAGEM

-- DBC USEROPTIONS
-- SET language mdy	 /* N�O MUDA PARA AS OUTRAS SESS�ES DO BANCO DE DADOS
-- SET DATEFORMAT dmy		 MUDA APENAS PARA SUA SESS�O */

DECLARE @var_DATE DATE

SELECT @var_DATE = '20-02-2022'

SELECT @var_DATE

-----------------------------------------------------------------------------------------------------------------------------------------------
-- DADOS NUM�RICOS 
-----------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @var_NUMERIC numeric(8,2)
-- SELECT @var_NUMERIC = 123456.45 
-- SELECT @var_NUMERIC = 1234561.45 -- UMA CASAS ANTES DA V�RGULA A+

SELECT @var_NUMERIC AS var_NUMERIC

-----------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @var_NUMERIC numeric(8,2)

 SELECT @var_NUMERIC = 123.1
-- SELECT @var_NUMERIC = 123.194 -- EXPURGA O N�MERO 4
-- SELECT @var_NUMERIC = 123.195 -- ARREDONDA PARA +

SELECT @var_NUMERIC AS var_NUMERIC

-----------------------------------------------------------------------------------------------------------------------------------------------
-- MESMA PEGADA DO NUMERIC

DECLARE @var_DECIMAL decimal(8,2)

-- SELECT @var_DECIMAL = 123.1
-- SELECT @var_DECIMAL = 123.194 -- EXPURGA O N�MERO 4
SELECT @var_DECIMAL = 123.19999 -- ARREDONDA PARA +

SELECT @var_DECIMAL as var_DECIMAL 

-----------------------------------------------------------------------------------------------------------------------------------------------
-- ISNUMERIC
SELECT ISNUMERIC (12345), ISNUMERIC ('LUIZ'), ISNUMERIC ('1234.5'), ISNUMERIC ('12345')
GO

-----------------------------------------------------------------------------------------------------------------------------------------------
-- FLOAT: CUIDADO N�MEROS APROXIMADOS
DROP TABLE IF EXISTS TesteFloat

CREATE TABLE TesteFloat (
	numFloat FLOAT,
	numNumeric NUMERIC (9,2),
)

INSERT INTO TesteFloat (numFloat, numNumeric) 
VALUES 
	(18.91, 18.91000000000007),
	(18.91, 18.91000000000007)

-- SELECT * FROM TesteFloat
SELECT DISTINCT numFloat FROM TesteFloat
SELECT DISTINCT numNumeric FROM TesteFloat

-----------------------------------------------------------------------------------------------------------------------------------------------
-- UTILIZANDO DATA TYPE 
-----------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Cliente
GO

CREATE TYPE  [dbo].[CPF] FROM VARCHAR (11) NOT NULL
CREATE TYPE [dbo].[CEP] FROM VARCHAR (8) NOT NULL


CREATE TABLE Cliente (
	IdCliente INT IDENTITY(1,1) NOT NULL,
	NmCliente VARCHAR (100) NOT NULL,
	CEP CEP NOT NULL,
	CPF CPF NOT NULL
)

INSERT INTO Cliente (NmCliente, CEP, CPF)
VALUES 
('Luiz Gustavo de Melo', '01234567', '05721568480')

SELECT * FROM Cliente 

-----------------------------------------------------------------------------------------------------------------------------------------------
-- TIPOS DE DADOS - PONTO DE ATEN��O - ESCOLHA DADOS ADEQUADOS
-----------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Cliente_BIG

CREATE TABLE Cliente_BIG (
	IdCliente  BIGINT IDENTITY (1,1) NOT NULL,
	NmCliente VARCHAR (MAX) NOT NULL,
	CEP NVARCHAR (MAX) NOT NULL,
	Endereco NVARCHAR (MAX) NOT NULL,
	Telefone NVARCHAR (MAX)
)

INSERT INTO Cliente_BIG (NmCliente, CEP, Endereco, Telefone)
VALUES 

	('Luiz Gustavo',           '12345678',   'Rua dos DBA Maluco',  '61985631264'),
	('Adelaide Amorim',   '18345108',  'Rua dos DBA Maluco',  '61995631374'),
	('Sheron Felix Melo',   '17350980',  'Rua dos DBA Maluco', '61940531714'),
	('Yasmim Vieira',         '11345778',   'Rua dos DBA Maluco',  '61910531484'),
	('Luiz Antonio',            '16345878',   'Rua dos DBA Maluco',  '6192053159'),
	('Sheila Melo',             '17345978',   'Rua dos DBA Maluco',  '61930531604')

	 
SELECT * FROM Cliente_BIG

CREATE NONCLUSTERED INDEX IX_NmCliente 
ON Cliente_Big (NmCliente)

/*
Mensagem 1919, N�vel 16, Estado 1, Linha 311
Column 'NmCliente' in table 'Cliente_Big' is of a type that is invalid for use as a key column in an index.
*/

-----------------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTE

DROP TABLE IF EXISTS Cliente
GO

CREATE TABLE Cliente (
	IdCliente  INT IDENTITY (1,1) NOT NULL,
	NmCliente VARCHAR (100) NOT NULL,
	CEP CHAR (8) NOT NULL,
	Endereco VARCHAR (100) NOT NULL,
	Telefone VARCHAR (11)
)

INSERT INTO Cliente (NmCliente, CEP, Endereco, Telefone)
VALUES 
	('Luiz Gustavo',           '12345678',   'Rua dos DBA Maluco',  '61985631264'),
	('Adelaide Amorim',   '18345108',  'Rua dos DBA Maluco',  '61995631374'),
	('Sheron Felix Melo',   '17350980',  'Rua dos DBA Maluco', '61940531714'),
	('Yasmim Vieira',         '11345778',   'Rua dos DBA Maluco',  '61910531484'),
	('Luiz Antonio',            '16345878',   'Rua dos DBA Maluco',  '6192053159'),
	('Sheila Melo',             '17345978',   'Rua dos DBA Maluco',  '61930531604')

SELECT * FROM Cliente


-- COMPARA��O TAMANHO DE CADA COLUNA 
SELECT  
	IdCliente,
	DATALENGTH (NmCliente) AS tm_NmCliente,
	DATALENGTH (Endereco) AS tm_Endereco,
	DATALENGTH (CEP) AS tm_CEP,
	DATALENGTH (Telefone) AS tm_Telefone,
	DATALENGTH (NmCliente) + DATALENGTH(Endereco) +
	DATALENGTH (Telefone) + DATALENGTH (CEP)  AS [tm_Total_Linhas (Bytes)}] 
FROM Cliente_BIG

SELECT  
	IdCliente,
	DATALENGTH (NmCliente) AS tm_NmCliente,
	DATALENGTH (Endereco) AS tm_Endereco,
	DATALENGTH (CEP) AS tm_CEP,
	DATALENGTH (Telefone) AS tm_Telefone,
	DATALENGTH (NmCliente) + DATALENGTH(Endereco) +
	DATALENGTH (Telefone) + DATALENGTH (CEP)  AS [tm_Total_Linhas (Bytes)}] 
FROM Cliente

-- CRIA INDICE POR NOME DO CLIENTE
CREATE NONCLUSTERED INDEX IX_NmCliente
ON Cliente (NmCliente)      

-----------------------------------------------------------------------------------------------------------------------------------------------
-- Identificadores 
-- Devem conter de 1 a 128 caracteres no m�ximo. 

-- Regras Gerais:
--				1) O primeiro caractere deve ser um dos seguintes:
--					 - Deve ser uma letra de (A at� Z)
--					 - Sublinhado (_), arroba (@), ou jogo da velha (#).

--				2) O identificador n�o deve ser uma palavra reservada do Transact-SQL.

--				3) N�o s�o perfimitidos espa�os ou caracteres especiais

--				OBS: Se o noem do identificador N�O estiver de acordo com essa regras,
--						 ele dever� ser delimitado por aspas duplas "" ou colchetes []
-----------------------------------------------------------------------------------------------------------------------------------------------
USE db_treinamento_TSQL

DROP TABLE IF EXISTS NmCliente
CREATE TABLE NmCliente (ID INT)

DROP TABLE IF EXISTS _NmCliente 
CREATE TABLE _NmClientet (ID INT)

DROP TABLE IF EXISTS [Nome CLiente]
CREATE TABLE [Nome Cliente] (ID INT)

DROP TABLE IF EXISTS 2Nome Cliente
CREATE TABLE 2Nome Cliente (ID INT )

/*
Mensagem 102, N�vel 15, Estado 1, Linha 397
Incorrect syntax near '2'.
*/
-----------------------------------------------------------------------------------------------------------------------------------------------
-- Literais (Constantes)
-----------------------------------------------------------------------------------------------------------------------------------------------

USE db_treinamento_TSQL

SELECT 32

SELECT 'Luiz Gustavo DBA'

SELECT N'Luiz Gustavo DBA'

SELECT CAST('20210606' AS DATE)

-----------------------------------------------------------------------------------------------------------------------------------------------
-- Express�es

--			� uma conbina��o de s�mbolos e operadaores que retorna um �nico valor.

--			Os tipos de dados precisam ser COMPAT�VEIS: 
--				- Tipo de dados IGUAIS
--				- O tipo de dados com a menor preced�ncia pode ser IMPLICITAMENTE CONVERTIDO com o  de MAIOR preced�ncia.
--				- Ex: Combinar INT e BIGINT. 

--			Podemos usar as fun��es CAST e CONVERT para converter EXPLICITAMENTE o tipo de dados. 
--			Ex: VARCHAR para INT. 

--			A ordena��o de execu��o em uma express�o segue as regras de preced�ncia  
-----------------------------------------------------------------------------------------------------------------------------------------------
USE db_treinamento_TSQL

-- CONVERS�O IMPLICITA 
-- INT + BIGINT

SELECT 32 + 123456789123456789

-- CONVERS�O EXPL�CITA, CONVERTE STRING EM N�MERO E SOMA
-- INT + STRING

SELECT  8 + '32'  

SELECT 32 + CAST('8' AS INT) 


-- DUAS STRINGS (TEXTOS)
-- CONCATENA 

SELECT '8' + '32'

-- CONVERS�O STRING + INTEIRO
SELECT 'Luiz' + 32

/*Mensagem 245, N�vel 16, Estado 1, Linha 453
Conversion failed when converting the varchar value 'Luiz' to data type int.
*/

-- DUAS STRINGS (TEXTOS)
-- CONCATENA 
SELECT 'Luiz ' + 'Gustavo'


-- CONVERTER STRING COM DATA

SELECT 'Luiz' + GETDATE()
/*Mensagem 241, N�vel 16, Estado 1, Linha 467
Conversion failed when converting date and/or time from character string.
*/

SELECT 'Luiz - ' + CONVERT(VARCHAR (10), GETDATE(), 120)

-----------------------------------------------------------------------------------------------------------------------------------------------
-- Utilizando vari�veis

-- Precisa do comando DECLARRE para ser declarada antes de ser utilizada;
-- O nome d a vari�vel deve inciar com o caractere "@";
-- Por fim, deve informar o TIPO da vari�vel.
-----------------------------------------------------------------------------------------------------------------------------------------------

-- ATRIBUINDO VALOR COM SET
DECLARE @var_Teste INT
SET @var_Teste = 100
SELECT @var_Teste

GO

-- ATRIBUINDO VALOR COM SELECT
DECLARE @var_Teste INT
SELECT @var_Teste = 100
SELECT @var_Teste

GO

-- ATRIBUINDO VALOR NO TIPO DE DADO(DIRETO)
DECLARE @var_Teste INT = 100
SELECT @var_Teste

-- DECLARANDO V�RIAS VARI�VEIS UTILIZANDO SET
DECLARE @var_Teste1 INT, @var_Teste2 INT, @var_Teste3 INT
SET @var_Teste1 = 100, @var_Teste2 = 200, @var_Teste3 = 300
SELECT @var_Teste1, @var_Teste2,  @var_Teste3

/*
Mensagem 102, N�vel 15, Estado 1, Linha 502
Incorrect syntax near ','.
*/

-- DECLARANDO V�RIAS VARI�VEIS UTILIZANDO SELECT
DECLARE @var_Teste1 INT, @var_Teste2 INT, @var_Teste3 INT
SELECT @var_Teste1 = 100, @var_Teste2 = 200, @var_Teste3 = 300
SELECT @var_Teste1 AS var_Teste1, 
			 @var_Teste2 AS var_Teste2,  
			 @var_Teste3 AS var_Teste3

-- ATRIBUI��O UTILIZANDO VARI�VEL ANTES DE SER ATRIBU�DO ALGUM VALOR
DECLARE @var_Teste1 INT, @var_Teste2 INT, @var_Teste3 INT
SELECT @var_Teste1 = @var_Teste3,  @var_Teste2 = 100, @var_Teste3 = 200
SELECT @var_Teste1 AS var_1, @var_Teste2 AS var_2, @var_Teste3 AS var_3

-- VARI�VEL ATRIBU�DA FOI DECLARADA ANTES DA A��O
DECLARE @var_Teste1 INT, @var_Teste2 INT, @var_Teste3 INT
SELECT @var_Teste3 = 200, @var_Teste1 = @var_Teste3, @var_Teste2 = 200
SELECT @var_Teste1 AS var_1, @var_Teste2 AS var_2, @var_Teste3 AS var_3

-- DECLARA��O COM TIPOS DISTINTOS 
DECLARE @var_Teste1 INT = 100, @var_Teste2 INT = 200, @var_Teste3 INT = 300, @var_Teste4 VARCHAR (20) = 'Luiz Gustavo'
SELECT @var_Teste1 AS Teste1, @var_Teste2 AS Teste2, @var_Teste3 AS Teste3, @var_teste4 AS Teste4

-- CUIDADO QUANDO N�O ATRIBUIR VALORES PARA AS VARI�VEIS!
DECLARE @var_Teste1 INT, @var_Teste2 INT, @var_Teste3 INT, @var_Teste4 VARCHAR (20)
SELECT @var_Teste1 AS Teste1, @var_Teste2 AS Teste2, @var_Teste3 AS Teste3, @var_Teste4 AS Teste4

SELECT 'ADM DE BD - ' + @var_Teste4 

-- RESOLVENDO O PROBLEMA DO NULO
SELECT 'ADM DE BD - ' + ISNULL(@var_Teste4, '')

GO

-- VARIAVEIS x MULTIPLOS VALORES
-- EXEMPLO: 01
DROP TABLE IF EXISTS [dbo].[Cliente]
GO

CREATE TABLE [dbo].[Cliente] (
	Id_Cliente INT IDENTITY (1,1) NOT NULL,
	Nm_Cliente VARCHAR(100) NOT NULL,
	Dt_Nascimento DATE NOT NULL,
	Fl_Sexo TINYINT NOT NULL
	)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento,Fl_Sexo)
VALUES ('Luiz Gustavo', '19980429', 1)

INSERT INTO [dbo].[Cliente] (Nm_Cliente, Dt_Nascimento,Fl_Sexo)
VALUES ('Yasmim Vieira', '19990511', 2)

SELECT * FROM Cliente

GO

DECLARE @Nm_Cliente VARCHAR(100)
SELECT @Nm_Cliente =[Nm_Cliente]
FROM Cliente

SELECT @Nm_Cliente -- NESTE CASO POR TER MAIS DE UM NOME, A CONSULTA SEMPRE IR� PEGAR O �LTIMO NOME

-- EXEMPLO 2 - MAIS DE UMA COLUNA
DECLARE @Nm_Cliente VARCHAR(100)

SET @Nm_Cliente = (SELECT * FROM Cliente)

/*Mensagem 116, N�vel 16, Estado 1, Linha 572
Somente uma express�o pode ser especificada na lista de sele��o quando a subconsulta n�o � introduzida com EXISTS.
*/

-- EXEMPLO 3 - MAIS DE UM RESULTADO

DECLARE @Nm_Cliente VARCHAR (100)
SET @Nm_Cliente = (SELECT Nm_Cliente FROM Cliente)

SELECT @Nm_Cliente
/*
Mensagem 512, N�vel 16, Estado 1, Linha 581
A subconsulta retornou mais de 1 valor. Isso n�o � permitido quando a subconsulta segue um =, !=, <, <= , >, >= ou quando ela � usada como uma express�o.
*/

-- EXEMPLO 4 
DECLARE @Nm_Cliente VARCHAR (100)
SET @Nm_Cliente = (SELECT Nm_Cliente FROM Cliente WHERE Id_Cliente = 1)

SELECT @Nm_Cliente

-- EXEMPLO 5
DECLARE @Nm_Cliente VARCHAR (100)

SELECT @Nm_Cliente = Nm_Cliente 
FROM Cliente
WHERE Id_Cliente = 1

SELECT @Nm_Cliente

-- ORDEM DE PRRECED�NCIA 
/*
Ordem de Preced�ncia (1 � o n�vel MAIS ALTO e 8 � o n�vel MAIS BAIXO):

	1) () (Par�nteses)
	2) * (Multiplica��o), / (Divis�o), % (M�dulo)
	3) + (Positivo), � (Negativo), + (Adi��o), + (Concatena��o), � (Subtra��o)
	4) =, >, <, >=, <=, <>, !=, !>, !< (Operadores de Compara��o)
	5) NOT
	6) AND
	7) BETWEEN, IN, LIKE, OR
	8) = (Atribui��o)

Observa��es:
-> Quando uma express�o complexa tiver v�rios operadores, a preced�ncia de operador determinar� a sequ�ncia de opera��es. 
-> A ordem de execu��o pode afetar o valor resultante significativamente.
-> Quando dois operadores em uma express�o tiverem o mesmo n�vel de preced�ncia, 
   eles ser�o avaliados da ESQUERDA para a DIREITA em sua posi��o na express�o.
-> Se uma express�o tiver par�nteses aninhados, a express�o mais aninhada ser� avaliada primeiro. 
*/


SELECT 5 * (2 + 3)

SELECT 5 + 2 * 3

SELECT 5 + (5 + (2*2)) + 2 * 10

SELECT 5 / 2 -- RESULTADO N�O � 2.5 POIS � UMA DIVIS�O DE N�MEROS INTEIROS

SELECT 5 / 2.0 -- RESULTADO � 2.5 PPOIS H� A CONVERS�O IMPLICITA, POIS UM DOS N�MEROS � DECIMAL

-- RESTO DA DIVIS�O
SELECT 17 % 3 

SELECT 6 % 2

DECLARE @VarX1 INT = 0
SELECT 5 / @VarX1

/*Mensagem 8134, N�vel 16, Estado 1, Linha 642
Erro de divis�o por zero.
*/

DECLARE @VarX2 INT = 0 
SELECT
		CASE WHEN @VarX2 = 0
				  THEN 0
				  ELSE 5 / @VarX2
		END 
GO

-- OU --

DECLARE @VarX3 INT = 0
SELECT 
		CASE WHEN @VarX3 <> 0
				  THEN 5 / @VarX3  
				  ELSE 0
		END 

-- SEM ZERO --
DECLARE @VarX4 INT = 2
SELECT 
		CASE WHEN @VarX4 = 0
				  THEN 0
				  ELSE 5 / @VarX4
		END
-- EXEMPLO 2 - OPERADORES NO MESMO N�VEL
SELECT 5 * 2 / 3 -- 3

SELECT 5 / 2 * 3 -- 6

--EXEMPLO 3 - OPERADORES DE COMPARA��O:
-- CRIA TABELA EXEMPLO
DROP TABLE IF EXISTS Vendas

CREATE TABLE Vendas (
	IdVenda INT IDENTITY (1,1) NOT NULL,
	Cd_Loja INT NOT NULL,
	DtVenda DATETIME NOT NULL,
	Vl_Venda NUMERIC (9,2) NOT NULL)

	INSERT INTO Vendas (Cd_Loja, DtVenda, Vl_Venda)
	VALUES
				(1 , GETDATE(), 100.00),
				(1 , GETDATE(), 232.17),
				(2 , GETDATE(), 597.52),
				(2 , GETDATE(), 304.63)

-- SELECT * FROM Vendas

SELECT * 
FROM Vendas
WHERE 
			Cd_Loja = 2
			AND Vl_Venda > 500

SELECT * 
FROM Vendas
WHERE 
			Cd_Loja = 2
			AND Vl_Venda >100 + 50 * 2

-- EXEMPLO 4 - CUIDADO COM O OR
SELECT *
FROM Vendas
WHERE 
			Cd_Loja = 1 
			OR Vl_Venda > 500

SELECT *
FROM Vendas
WHERE
			Cd_Loja = 1
			OR 
				(Vl_Venda > 500
				AND Cd_Loja = 2
				AND Vl_Venda > 600)

-- OPERADOR NOT / NOT IN
SELECT *
FROM Vendas
WHERE
			NOT (Cd_Loja = 1)

SELECT * 
FROM Vendas
WHERE
			Cd_Loja NOT IN (2)