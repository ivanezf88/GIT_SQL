
CREATE PROC agr.spExpiraReferencia
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tbl_Referencia AS TABLE (IdRegistro INT PRIMARY KEY IDENTITY(1,1), IdReferencia NUMERIC(15))
	DECLARE @V_IdReferencia NUMERIC(15),
		@V_Cont INT = 1,
		@V_Lim INT

	INSERT INTO @tbl_Referencia (IdReferencia)
	SELECT numIdReferencia
	FROM agr.REFERENCIA WITH(NOLOCK)
	WHERE tnyIdEstatus = 1 AND
		  sdtFecExpiracion < CONVERT(SMALLDATETIME,GETDATE())

	IF (SELECT COUNT(*) FROM @tbl_Referencia) > 0 
	BEGIN

		UPDATE REF SET REF.tnyIdEstatus = 2
		FROM agr.REFERENCIA AS REF WITH(NOLOCK)
			INNER JOIN @tbl_Referencia AS TRE ON REF.numIdReferencia = TRE.IdReferencia

		SET @V_Lim = (SELECT COUNT(*) FROM @tbl_Referencia)

		WHILE @V_Cont <= @V_Lim
		BEGIN
		
			SET @V_IdReferencia = (SELECT IdReferencia FROM @tbl_Referencia WHERE IdRegistro = @V_Cont)

			EXEC agr.spActualizaFormatoJson @P_IdReferencia = @V_IdReferencia

			SET @V_Cont+= 1
		END

	END

	SET NOCOUNT OFF
END
