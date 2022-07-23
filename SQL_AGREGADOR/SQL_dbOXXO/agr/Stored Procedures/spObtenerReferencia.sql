
CREATE PROC agr.spObtenerReferencia
(@P_json NVARCHAR(MAX))
AS
 BEGIN

	SET NOCOUNT ON

	DECLARE @V_IdRegistro INT, 
			@V_Sucess BIT = 0

	INSERT INTO agr.PROCESSCONTROL (nvarJSON, tnyIdOrigen)
							VALUES (@P_json, 1)

	SET @V_IdRegistro = SCOPE_IDENTITY()

	--VALIDACIONES GENERALES
	EXEC agr.spValGenerales @P_Accion = 1,
							@P_IdRegistro = @V_IdRegistro

	IF NOT EXISTS (SELECT TOP 1 1 FROM agr.PROCESSERROR WITH(NOLOCK) WHERE intIdProcessControl = @V_IdRegistro)
	BEGIN
			
		--VALIDACIONES POR CLIENTE
		EXEC agr.spValGenerales @P_Accion = 2, 
								@P_IdRegistro = @V_IdRegistro

		--VALIDACIONES POR CLIENTE
		IF NOT EXISTS (SELECT TOP 1 1 FROM agr.PROCESSERROR WITH(NOLOCK) WHERE intIdProcessControl = @V_IdRegistro)
		BEGIN
			
			SET @V_Sucess = 1

		END
		
	END

	IF @V_Sucess = 1 
	BEGIN

		--GENERACIÓN DE REFERENCIA
		EXEC agr.spInsertReferencia @P_IdRegistro = @V_IdRegistro

	END
	ELSE
	BEGIN
			
		--GENERAR JSON DE ERROR
		EXEC agr.spEnviaErrorJson @P_IdRegistro  = @V_IdRegistro
	END

	SET NOCOUNT OFF
 END
