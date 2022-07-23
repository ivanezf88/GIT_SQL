
CREATE FUNCTION [agr].[fnFormatoJsonConsulta]
(@P_IdRegistro INT)
RETURNS @tbl_Json TABLE (IdRegistro INT PRIMARY KEY IDENTITY(1,1), IdReferencia NUMERIC(15))
AS
BEGIN

	DECLARE @json NVARCHAR(MAX)

	SET @json = (SELECT nvarJSON FROM agr.PROCESSCONTROL WITH(NOLOCK) WHERE intIdProcessControl = @P_IdRegistro)
	
	INSERT INTO @tbl_Json (IdReferencia)
	SELECT *
	FROM OPENJSON(@json)
	WITH(ReferenceId NUMERIC(15) 'strict $.ReferenceId')

	RETURN
END
