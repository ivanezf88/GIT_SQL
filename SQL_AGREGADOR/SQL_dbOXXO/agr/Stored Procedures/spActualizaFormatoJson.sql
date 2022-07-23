
CREATE PROC agr.spActualizaFormatoJson
(@P_IdReferencia NUMERIC(15))
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tbl_Resul AS TABLE (IdRegistro INT PRIMARY KEY IDENTITY(1,1), FormatoJSON NVARCHAR(MAX))
	DECLARE @V_ScriptSQL NVARCHAR(MAX) = ''

	SET @V_ScriptSQL = agr.fnGeneraJson (@P_IdReferencia,1)
	SET @V_ScriptSQL = @V_ScriptSQL + agr.fnGeneraJson (@P_IdReferencia,2)
	SET @V_ScriptSQL = @V_ScriptSQL + agr.fnGeneraJson (@P_IdReferencia,3)
	SET @V_ScriptSQL = @V_ScriptSQL + agr.fnGeneraJson (@P_IdReferencia,4)

	INSERT INTO @tbl_Resul (FormatoJSON)
	EXEC SP_EXECUTESQL @V_ScriptSQL

	UPDATE agr.REFERENCIA SET varJSON = (SELECT FormatoJSON FROM @tbl_Resul)
	WHERE numIdReferencia = @P_IdReferencia

	SET NOCOUNT OFF
END
