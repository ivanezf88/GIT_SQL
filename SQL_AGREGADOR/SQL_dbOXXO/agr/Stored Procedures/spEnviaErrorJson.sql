
CREATE PROC agr.spEnviaErrorJson
(@P_IdRegistro INT)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @tbl_Retorno AS TABLE (Success VARCHAR(10), Code CHAR(2), [Message]	VARCHAR(120))

	INSERT INTO @tbl_Retorno (Success, Code, [Message])
	SELECT TOP 1 'False',
		   chrCodError,
		   varMensaje
	FROM agr.PROCESSERROR
	WHERE intIdProcessControl = @P_IdRegistro
	ORDER BY intIdProcessError ASC

	SELECT *
	FROM @tbl_Retorno
	FOR JSON PATH,INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER

	SET NOCOUNT OFF
END
