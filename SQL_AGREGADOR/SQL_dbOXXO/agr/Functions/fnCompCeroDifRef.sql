CREATE FUNCTION agr.fnCompCeroDifRef
(@P_NumDifReferencia NUMERIC(20))
RETURNS VARCHAR(12)
AS
BEGIN

	DECLARE @V_Longitud INT,
			@V_DifNume NUMERIC,
			@V_Cant INT = 1,
			@V_Dif INT,
			@V_Cadena VARCHAR(10) = ''


	SET @V_Longitud = (SELECT CONVERT(INT,varValor) FROM agr.LVAL WHERE numIdLval = 16)
	
	 SET @V_Dif = (@V_Longitud - len(@P_NumDifReferencia))

	 WHILE @V_Cant <= @V_Dif
	 BEGIN

		SET @V_Cadena = @V_Cadena + '0'

		SET @V_Cant += 1

	 END

	RETURN @V_Cadena

	--NUEVO PARA PROBAR

END