
CREATE PROC [agr].[spGetValidaciones]
(@P_Accion INT,
 @P_IdRegistro INT)
 AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @V_IdCliente SMALLINT,
			@V_ScriptSQL Nvarchar(MAX)

	IF @P_Accion IN (1,2)
	BEGIN

		--1	Validaciones Generales Agregador
		--2	Validaciones Por Cliente Agregador

		SET @V_IdCliente = (SELECT CLI.sntIdCliente 
							FROM agr.fnFormatoJson (@P_IdRegistro) AS JSO 
								INNER JOIN agr.CLIENTE AS CLI ON JSO.GUIDClient = CLI.varGUIDCliente)


		SET @V_ScriptSQL = 'SELECT CON.numIdValidacion,
								   CON.varScriptSQL,
								   VAL.chrCodError
							FROM agr.CONFVALIDACIONES AS CON
								INNER JOIN agr.VALIDACION AS VAL ON CON.numIdValidacion = VAL.numIdValidacion
							WHERE tnyIdNivel = ' + CONVERT(VARCHAR(5),@P_Accion) + 'AND ' + 
							CASE 
								 WHEN @P_Accion = 2 THEN 'CON.sntIdCliente = ' + CONVERT(VARCHAR(5),@V_IdCliente) + ' AND '
								 WHEN @P_Accion = 1 THEN ''
							END + 
							' bitIsActivo = 1'

		EXEC SP_EXECUTESQL @V_ScriptSQL

	END

	ELSE IF @P_Accion IN (3, 4)
	BEGIN
		--3	Validaciones Generales Cobro
		--4	Validaciones Por Cliente Cobro

		SET @V_IdCliente = (SELECT REF.sntIdCliente 
							FROM swt.fnFormatoJsonCargo(@P_IdRegistro) AS JSO
								 INNER JOIN agr.REFERENCIA AS REF ON REF.numNoReferencia = JSO.Referencia AND 
																	 REF.tnyIdEstatus = 1)

		SET @V_ScriptSQL = 'SELECT CON.numIdValidacion,
								   CON.varScriptSQL,
								   VAL.chrCodError
							FROM agr.CONFVALIDACIONES AS CON
								INNER JOIN agr.VALIDACION AS VAL ON CON.numIdValidacion = VAL.numIdValidacion
							WHERE tnyIdNivel = ' + CONVERT(VARCHAR(5),@P_Accion) + 'AND ' +
							CASE
								WHEN @P_Accion = 4 THEN 'CON.sntIdCliente = ' + CONVERT(VARCHAR(5),@V_IdCliente) + ' AND '
								WHEN @P_Accion = 3 THEN ''
							END + 
							' bitIsActivo = 1'

		EXEC SP_EXECUTESQL @V_ScriptSQL
		
	END

	--ELSE IF @P_Accion IN (5,6)
	--BEGIN
		--5	Validaciones Generales Reversa
		--6	Validaciones Por Cliente Reversa
	--END

	ELSE IF @P_Accion IN (7, 8)
	BEGIN
		--7	Validaciones Generales Consulta
		--8	Validaciones Por Cliente Consulta
		
		SET @V_IdCliente = (SELECT REF.sntIdCliente 
							FROM [agr].[fnFormatoJsonConsulta] (@P_IdRegistro) AS JSO 
								INNER JOIN agr.REFERENCIA AS REF ON JSO.IdReferencia = REF.numDifReferencia)

		SET @V_ScriptSQL = 'SELECT CON.numIdValidacion,
								   CON.varScriptSQL,
								   VAL.chrCodError
							FROM agr.CONFVALIDACIONES AS CON
								INNER JOIN agr.VALIDACION AS VAL ON CON.numIdValidacion = VAL.numIdValidacion
							WHERE tnyIdNivel = ' + CONVERT(VARCHAR(5),@P_Accion) + 'AND ' +
							CASE
								WHEN @P_Accion = 8 THEN 'CON.sntIdCliente = ' + CONVERT(VARCHAR(5),@V_IdCliente) + ' AND '
								WHEN @P_Accion = 7 THEN ''
							END + 
							' bitIsActivo = 1'

		EXEC SP_EXECUTESQL @V_ScriptSQL

	END

	SET NOCOUNT OFF
END
