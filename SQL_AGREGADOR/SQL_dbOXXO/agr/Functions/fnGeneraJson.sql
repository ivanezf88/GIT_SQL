
 CREATE FUNCTION agr.fnGeneraJson
 (@P_IdReferencia numeric(15),
  @P_Opcion TINYINT)
  RETURNS NVARCHAR(MAX)
 AS
 BEGIN
	
	DECLARE @tbl_Ordeado AS TABLE (IdRegistro INT PRIMARY KEY IDENTITY(1,1), String VARCHAR(200))
	DECLARE @V_IdEstablecimiento smallint,
			@V_SQL NVARCHAR(MAX), 
			@V_Col VARCHAR(MAX), 
			@V_Cont INT = 1, 
			@V_Lim INT = 1,
			@V_IdNivel SMALLINT
		
	--1 - CREACIÓN DE TABLA
	--2 - CREACIÓN INSERT
	--3 - SELECT - INSERT
	--4 - SELECT RESULTADO

	SET @V_IdEstablecimiento = (SELECT sntIdEstablecimiento	FROM agr.REFERENCIA WHERE numIdReferencia = @P_IdReferencia)

	SET @V_SQL = CASE	
					 WHEN @P_Opcion = 1 THEN 'DECLARE @V_Json NVARCHAR(MAX)  CREATE TABLE #Formato (' 
					 WHEN @P_Opcion = 2 THEN 'INSERT INTO #Formato ('
					 WHEN @P_Opcion = 3 THEN 'SELECT '
					 WHEN @P_Opcion = 4 THEN 'SET @V_Json = (SELECT '
				 END

	INSERT INTO @tbl_Ordeado (String)
	SELECT CASE
			   WHEN @P_Opcion = 1 THEN ('[' + varColumna + '] ' + varTipoDato)
			   WHEN @P_Opcion IN (2, 4) THEN ('[' + varColumna + '] ')
			   WHEN @P_Opcion = 3 THEN varValor
			END
	FROM agr.CONFIG_COL_ESTABLECIMIENTO
	WHERE sntIdEstablecimiento = @V_IdEstablecimiento AND
		  intIdConNivEstable IS NULL
	ORDER BY tnyOrden
	
	SET @V_Col = (SELECT STRING_AGG(String, ', ') FROM @tbl_Ordeado)

	SET @V_SQL = @V_SQL + @V_Col + ','

	DELETE @tbl_Ordeado

	SET @V_Col = ''
	---------
	
	SET @V_Lim = (SELECT MAX(tnyNivel) FROM agr.CONFIG_NIVEL_ESTABLECIMIENTO WHERE sntIdEstablecimiento = @V_IdEstablecimiento)

	WHILE @V_Cont <= @V_Lim
	BEGIN

		SELECT @V_Col = Descrip,
			   @V_IdNivel = intIdConNivEstable
		FROM agr.CONFIG_NIVEL_ESTABLECIMIENTO 
		WHERE sntIdEstablecimiento = @V_IdEstablecimiento AND 
			  tnyNivel = @V_Cont

		 INSERT INTO @tbl_Ordeado (String)
		 SELECT CASE 
					 WHEN @P_Opcion = 1 THEN ('['+ @V_Col + varColumna + '] ' + varTipoDato)
					 WHEN @P_Opcion IN (2, 4) THEN ('['+ @V_Col + varColumna + '] ')
					 WHEN @P_Opcion = 3 THEN (varValor)
				END
		 FROM agr.CONFIG_COL_ESTABLECIMIENTO
		 WHERE sntIdEstablecimiento = @V_IdEstablecimiento AND
			   intIdConNivEstable = @V_IdNivel
		 ORDER BY intIdConNivEstable

		 SELECT @V_Col = STRING_AGG(String,', ')
		 FROM @tbl_Ordeado

		 SET @V_SQL = @V_SQL + @V_Col + ','

		 DELETE @tbl_Ordeado

		SET @V_Cont += 1
	END

	---------
	
	SET @V_SQL = LEFT(@V_SQL, LEN(@V_SQL) - 1)

	SET @V_SQL = @V_SQL + ' '

	SET @V_SQL = @V_SQL + CASE
							WHEN @P_Opcion IN (1,2) THEN ')'
							WHEN @P_Opcion = 3 THEN 'FROM agr.REFERENCIA AS REF 
								   INNER JOIN agr.ESTABLECIMIENTO AS EST ON REF.sntIdEstablecimiento = EST.sntIdEstablecimiento
								   WHERE numIdReferencia = ' + CONVERT(VARCHAR(18),@P_IdReferencia)
							WHEN @P_Opcion = 4 THEN 'FROM #Formato FOR JSON PATH,INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER) 
													 SELECT @V_Json'
						  END

	RETURN @V_SQL

 END
