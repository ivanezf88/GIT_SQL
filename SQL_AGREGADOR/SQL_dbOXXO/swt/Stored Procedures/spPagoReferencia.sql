
CREATE PROC [swt].[spPagoReferencia]
(@P_json NVARCHAR(MAX))
AS
BEGIN
	SET NOCOUNT ON

		DECLARE @V_IdRegistro INT, 
				@V_Sucess BIT = 0
		
		--EXPIRAR REFERENCIAS
		EXEC [agr].[spExpiraReferencia]


		INSERT INTO agr.PROCESSCONTROL (nvarJSON, tnyIdOrigen)
								VALUES (@P_json, 2)

		SET @V_IdRegistro = SCOPE_IDENTITY()

		--VALIDACIONES POR CLIENTE
		EXEC agr.spValGenerales @P_Accion = 3, 
							    @P_IdRegistro = @V_IdRegistro

		IF NOT EXISTS(SELECT TOP 1 1 FROM agr.PROCESSERROR WHERE intIdProcessControl = @V_IdRegistro)
		BEGIN

			--VALIDACIONES POR CLIENTE
			EXEC agr.spValGenerales @P_Accion = 4,
									  @P_IdRegistro = @V_IdRegistro

			IF NOT EXISTS(SELECT TOP 1 1 FROM agr.PROCESSERROR WHERE intIdProcessControl = @V_IdRegistro)
			BEGIN
				SET @V_Sucess = 1
			END

		END

		IF @V_Sucess = 1 
		BEGIN

			--RETORNO DE EXITO
			SELECT '00' AS chrCodError,
				   'OK' AS varMensaje,
				   @V_IdRegistro AS NoTransaccion

		END
		ELSE 
		BEGIN

			--RETORNO DE ERROR
			SELECT TOP 1 chrCodError,
				   varMensaje,
				   @V_IdRegistro AS NoTransaccion
			FROM [agr].[PROCESSERROR]
			WHERE intIdProcessControl = @V_IdRegistro

		END

	SET NOCOUNT OFF

END
