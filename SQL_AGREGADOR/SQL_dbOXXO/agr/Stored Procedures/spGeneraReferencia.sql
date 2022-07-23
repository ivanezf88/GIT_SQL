
CREATE PROC agr.spGeneraReferencia
(@P_IdRegistro INT,
 @P_NoReferencia NUMERIC(16) OUTPUT)
 AS
 BEGIN
	SET NOCOUNT ON
	
	DECLARE @V_NoReferencia NUMERIC(16),
			@V_FolioReferencia VARCHAR(8)

	--CONSULTAR EL FOLIO EN EL QUE VA
	SET @V_FolioReferencia = (SELECT varValor FROM [agr].[LVAL] WHERE numIdLval = 6)

	SELECT @V_NoReferencia = CONCAT(EST.intNoSocio,@V_FolioReferencia, FORMAT(CONVERT(INT,LEFT(REPLACE(CONVERT(VARCHAR(12), JSO.Amount),'.',''),LEN(REPLACE(CONVERT(VARCHAR(12), JSO.Amount),'.','')) - 1)),'00000'))
	FROM agr.fnFormatoJson (@P_IdRegistro) AS JSO
		INNER JOIN agr.ESTABLECIMIENTO AS EST ON JSO.EstablecimientoId = EST.sntIdEstablecimiento

	SET @V_NoReferencia = CONCAT(@V_NoReferencia, agr.fnCodValidacion(@V_NoReferencia))
	
	SET @P_NoReferencia = @V_NoReferencia

	SET @V_FolioReferencia = FORMAT(IIF((@V_FolioReferencia + 1) > 9999999, 1, (@V_FolioReferencia + 1)) ,'0000000')
	
	--ACTUALIZAR FOLIO RANDOM
	UPDATE agr.LVAL SET varValor = @V_FolioReferencia 
	WHERE numIdLval = 6

	SET NOCOUNT OFF
 END
