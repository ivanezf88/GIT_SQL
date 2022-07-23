CREATE FUNCTION [agr].[fnGeneraDifReferencia]
(@P_RAND FLOAT)
RETURNS NUMERIC(20)
AS
BEGIN
	DECLARE @V_DifReferencia NUMERIC(20),
		@V_Cont INT = 1	

	DECLARE @tbl_DifReferencia AS TABLE (IdRegistro INT PRIMARY KEY IDENTITY(1,1), DifReferencia NUMERIC(15))
	DECLARE @V_Cadena VARCHAR(10),
			@V_Valido BIT = 0

		WHILE @V_Valido <> 1
		BEGIN
			
			SET @V_DifReferencia = (@P_RAND * 1000000000000000)

			SET @V_Cadena = (SELECT agr.fnCompCeroDifRef (@V_DifReferencia))
		
			SET @V_DifReferencia = CONCAT(@V_DifReferencia, @V_Cadena)

			INSERT INTO @tbl_DifReferencia (DifReferencia)
			SELECT numDifReferencia
			FROM agr.REFERENCIA

			SET @V_Valido = (SELECT CASE 
									   WHEN COUNT(*) > 0 THEN 0 
									   ELSE 1
									END
							 FROM agr.REFERENCIA
							 WHERE numDifReferencia = @V_DifReferencia)


		END
	
		RETURN @V_DifReferencia

END
