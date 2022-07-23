
CREATE PROC agr.spValGenerales
 (@P_Accion INT,
  @P_IdRegistro INT)
 AS
 BEGIN
	SET NOCOUNT ON
	
	--EN EL PARAMETRO @P_Accion SOLAMENTE SE PUEDE RECIBIR 1 Y 2
	DECLARE @tbl_Validaciones AS TABLE (IdRegistro INT PRIMARY KEY IDENTITY (1,1), NumValidacion INT, ScriptSQL varchar(MAX), CodError CHAR(2))
	DECLARE	@tbl_RESVALI AS TABLE (Mensaje VARCHAR(280) INDEX IX_NC_X1 NONCLUSTERED (Mensaje))
	DECLARE	@tbl_RESULTADO AS TABLE (IdRegistro INT PRIMARY KEY IDENTITY(1,1), NumValidacion INT, Mensaje VARCHAR(280), CodError CHAR(2))
	DECLARE @V_Cont INT = 1,
			@V_Limite INT,
			@V_NumValidacion INT,
			@V_ScriptSQL Nvarchar(MAX),
			@V_CodError CHAR(2)

	--EXTRACCIÓN DE VALIDACIONES
	INSERT INTO @tbl_Validaciones (NumValidacion, ScriptSQL, CodError)
	EXEC [agr].spGetValidaciones @P_Accion = @P_Accion,
								 @P_IdRegistro = @P_IdRegistro

	-- EJECUCIÓN DE VALIDACION POR NIVEL Y CLIENTE
	SET @V_Limite = (SELECT COUNT(*) FROM @tbl_Validaciones)

	WHILE @V_Cont <= (@V_Limite)
	BEGIN
		
		SELECT @V_NumValidacion = NumValidacion,
			   @V_ScriptSQL = ScriptSQL,
			   @V_CodError = CodError
		FROM @tbl_Validaciones 
		WHERE IdRegistro = @V_Cont

		INSERT INTO @tbl_RESVALI (Mensaje)
		EXEC SP_EXECUTESQL @statement = @V_ScriptSQL,
						   @params = N'@IdRegistro INT',
						   @IdRegistro = @P_IdRegistro

		INSERT INTO @tbl_RESULTADO (NumValidacion, Mensaje, CodError)
		SELECT @V_NumValidacion,
				Mensaje,
				@V_CodError
		FROM @tbl_RESVALI

		DELETE @tbl_RESVALI

		SET @V_Cont += 1
	END

	INSERT INTO agr.PROCESSERROR (intIdProcessControl, numIdValidacion, varMensaje, chrCodError)
	SELECT @P_IdRegistro,
			NumValidacion,
			Mensaje,
			CodError
	FROM @tbl_RESULTADO

	SET NOCOUNT OFF
 END
