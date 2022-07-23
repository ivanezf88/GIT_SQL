
CREATE PROC [agr].[spInsertReferencia]
(@P_IdRegistro INT)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @V_NoReferencia NUMERIC(16),
			@V_IdReferencia	NUMERIC(15),
			@V_ScriptSQL NVARCHAR(MAX),
			@V_IdEstablecimiento SMALLINT
	 
	EXEC [agr].[spGeneraReferencia] @P_IdRegistro = @P_IdRegistro, 
									@P_NoReferencia = @V_NoReferencia OUTPUT

	SET @V_IdEstablecimiento = (SELECT EstablecimientoId FROM agr.fnFormatoJson (@P_IdRegistro))

	 INSERT INTO agr.REFERENCIA (intIdProcessControl, numDifReferencia, numNoTransaccion, chrIdMoneda, sntIdEstablecimiento, sntIdCliente, varNoBeneficiario, decMonto, numNoReferencia, sdtFecExpiracion, sdtFecRegistro, varURLQR, varJSON, tnyIdEstatus)
	 SELECT @P_IdRegistro,
			agr.fnGeneraDifReferencia(RAND()),
			JSO.TransactionId,
			JSO.CurrencyCode,
			JSO.EstablecimientoId,
			CLI.sntIdCliente,
			JSO.BeneficiaryId,
			JSO.Amount,
			@V_NoReferencia AS numNoReferencia,
			CASE
				WHEN JSO.ExpiryDate IS NULL THEN DATEADD(HOUR,CONVERT(INT,CCL.varValor),GETDATE())
				ELSE JSO.ExpiryDate
			END,
			GETDATE(),
			NULL AS [URL],
			NULL AS [JSON],
			1 AS IdEstatus
	 FROM agr.fnFormatoJson (@P_IdRegistro) AS JSO
		INNER JOIN agr.CLIENTE AS CLI ON JSO.GUIDClient = CLI.varGUIDCliente
		LEFT JOIN (SELECT sntIdCliente,
						  varValor
				   FROM [agr].[CONFIG_CLIENTE]
				   WHERE sntIdConfiguracion = 3) AS CCL ON CLI.sntIdCliente = CCL.sntIdCliente
		
	 SET @V_IdReferencia = SCOPE_IDENTITY()
	 
	 --ACTUALIZA EL FORMATO JSON QUE SE GUARDA EN LA TABLA
	 EXEC [agr].[spActualizaFormatoJson] @P_IdReferencia = @V_IdReferencia

	SELECT varJSON
	FROM agr.REFERENCIA
	WHERE numIdReferencia = @V_IdReferencia

	SET NOCOUNT OFF
END
