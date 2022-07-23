
CREATE PROC [agr].[spConsulReferencia]
(@P_json NVARCHAR(MAX))
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @V_IdRegistro INT, 
			@V_Sucess BIT = 0,
			@V_ReferenceId NUMERIC(15)

	--EXPIRACIÓN DE REFERENCIA
	EXEC agr.spExpiraReferencia
	
	INSERT INTO agr.PROCESSCONTROL (nvarJSON, tnyIdOrigen)
							VALUES (@P_json, 4)

	SET @V_IdRegistro = SCOPE_IDENTITY()

	--VALIDACIONES GENERALES
	EXEC agr.spValGenerales @P_Accion = 7,
							@P_IdRegistro = @V_IdRegistro

	IF NOT EXISTS (SELECT TOP 1 1 FROM agr.PROCESSERROR WHERE intIdProcessControl = @V_IdRegistro)
	BEGIN

		--VALIDACIONES GENERALES
		EXEC agr.spValGenerales @P_Accion = 8,
								@P_IdRegistro = @V_IdRegistro
		
			--VALIDACIONES POR CLIENTE
		IF NOT EXISTS (SELECT TOP 1 1 FROM agr.PROCESSERROR WITH(NOLOCK) WHERE intIdProcessControl = @V_IdRegistro)
		BEGIN

			SET @V_Sucess = 1

		END

	END

	IF @V_Sucess = 1 
	BEGIN
		
		SET @V_ReferenceId = (SELECT REF.numIdReferencia 
							  FROM agr.fnFormatoJsonConsulta(@V_IdRegistro) AS JSO
								INNER JOIN agr.REFERENCIA AS REF ON JSO.IdReferencia = REF.numDifReferencia)

		EXEC agr.spActualizaFormatoJson @P_IdReferencia = @V_ReferenceId

		SELECT varJSON
		FROM agr.REFERENCIA
		WHERE numIdReferencia = @V_ReferenceId

	END
	ELSE
	BEGIN
			
		--GENERAR JSON DE ERROR
		EXEC agr.spEnviaErrorJson @P_IdRegistro = @V_IdRegistro

	END

	SET NOCOUNT OFF
END
