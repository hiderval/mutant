
IF DB_ID ('LanchoneteWeb') IS NULL
	CREATE DATABASE LanchoneteWeb
go


use LanchoneteWeb
go


CREATE TABLE Ingrediente (
    ingrediente_cod int IDENTITY (1,1) PRIMARY KEY,
    ingrediente_nome varchar (25),
    ingrediente_descrição varchar (25),
	ingrediente_valor decimal(6,2)
	) 
go


INSERT INTO Ingrediente (ingrediente_nome, ingrediente_descrição, ingrediente_valor)
VALUES('Alface', 'Porção', 0.40);

INSERT INTO Ingrediente(ingrediente_nome, ingrediente_descrição, ingrediente_valor)
VALUES('Bacon', 'Fatia', 2.00);

INSERT INTO Ingrediente(ingrediente_nome, ingrediente_descrição, ingrediente_valor)
VALUES('Hamburguer', 'Unidade', 3.00);

INSERT INTO Ingrediente(ingrediente_nome, ingrediente_descrição, ingrediente_valor)
VALUES('Ovo', 'Unidade', 0.80);

INSERT INTO Ingrediente(ingrediente_nome, ingrediente_descrição, ingrediente_valor)
VALUES('Queijo', 'Fatia', 1.50);


select * from Ingrediente;



CREATE PROCEDURE sp_Lanche
(
	@Combo VARCHAR(20)
)
AS
BEGIN

	IF (@Combo = 'xbacon')
		BEGIN
			SELECT  sum(ingrediente_valor) as valor_xbacon  
			FROM ingrediente
			WHERE ingrediente_cod = 2 or ingrediente_cod = 3 or ingrediente_cod = 5
		END

		ELSE IF (@Combo = 'xburguer')
			BEGIN
			SELECT  sum(ingrediente_valor) as valor_xburguer  
			FROM ingrediente
			WHERE ingrediente_cod = 3 or ingrediente_cod = 5
		END

		ELSE IF (@Combo = 'xegg')
			BEGIN
			SELECT  sum(ingrediente_valor) as valor_xegg  
			FROM ingrediente
			WHERE ingrediente_cod = 3 or ingrediente_cod = 5
		END

		ELSE IF (@Combo = 'xeggbacon')
			BEGIN
			SELECT  sum(ingrediente_valor) as valor_xeggbacon
			FROM ingrediente
			WHERE ingrediente_cod = 2 or ingrediente_cod = 3 or ingrediente_cod = 4 or ingrediente_cod = 5
		END

END


exec sp_Lanche 'xbacon'
exec sp_Lanche 'xburguer'
exec sp_Lanche 'xegg'
exec sp_Lanche 'xeggbacon'



CREATE PROCEDURE sp_Amoda
(
	@amoda VARCHAR(20),
	@ingredientes varchar(20)
)
AS

declare @query varchar(1000)

BEGIN

	IF (@amoda = 'light')
		BEGIN
			select @query = 'SELECT sum(ingrediente_valor)/0.90 as valor_light FROM ingrediente '
			select @query =  @query + 'WHERE ingrediente_cod in (' + @ingredientes + ') and ingrediente_cod not like (2)'
			exec (@query)
		END

	ELSE IF (@Amoda = 'muitacarne')
		BEGIN
			select @query = 'SELECT sum(ingrediente_valor) as valor_light FROM ingrediente '
			select @query =  @query + 'WHERE ingrediente_cod in (' + @ingredientes + ')'
			exec (@query)
		END

	ELSE IF (@amoda = 'muitoqueijo')
		BEGIN
			select @query = 'SELECT sum(ingrediente_valor) as valor_light FROM ingrediente '
			select @query =  @query + 'WHERE ingrediente_cod in (' + @ingredientes + ')'
			exec (@query)
	END

	ELSE IF (@amoda = 'livre')
		BEGIN
			select @query = 'SELECT sum(ingrediente_valor) as valor_light FROM ingrediente '
			select @query =  @query + 'WHERE ingrediente_cod in (' + @ingredientes + ')'
			exec (@query)
	END

END



exec sp_Amoda 'light', '1, 2, 3, 5'
go 


