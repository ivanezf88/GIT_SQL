
CREATE FUNCTION swt.fnFormatoJsonCargo
(@P_IdRegistro INT)
RETURNS @tbl_Json TABLE (IdRegistro TINYINT PRIMARY KEY IDENTITY (1,1), Plaza VARCHAR(10), Tienda VARCHAR(10),  FechaCentral SMALLDATETIME, fechaAdmin DATE, FechaPOS SMALLDATETIME, Referencia NUMERIC(16),
						 Monto DECIMAL(8,2), Caja VARCHAR(2), Operador VARCHAR(16), FolioWm NUMERIC(10), EntryMode VARCHAR(5), Currency VARCHAR(5), tiendaFronteriza VARCHAR(5), att1 VARCHAR(10), att3 VARCHAR(10), 
						 idNegocio VARCHAR(5), stan NUMERIC(10), INDEX IX_X1 CLUSTERED (Referencia))
AS
BEGIN

	DECLARE @json NVARCHAR(MAX)

	SET @json = (SELECT nvarJSON FROM agr.PROCESSCONTROL WITH(NOLOCK) WHERE intIdProcessControl = @P_IdRegistro)
		
	INSERT INTO @tbl_Json (Plaza, Tienda, FechaCentral, fechaAdmin, FechaPOS, Referencia, Monto, Caja, Operador, FolioWm, EntryMode, Currency, tiendaFronteriza, att1, att3, idNegocio, stan)
	SELECT crPlaza,
		   crTienda,
		   CONVERT(SMALLDATETIME, fechaCentral) AS fechaCentral,
		   CONVERT(DATE,fechaAdmin) AS fechaAdmin,
		   CONVERT(SMALLDATETIME, fechaPOS) AS fechaPOS,
		   referencia,
		   monto,
		   caja,
		   operador,
		   folioWm,
		   entryMode,
		   currency,
		   tiendaFronteriza,
		   IIF(att1 = '', NULL, att1) AS att1,
		   IIF(att3 = '', NULL, att3) AS att3,
		   idNegocio,
		   stan
	FROM OPENJSON(@json)
	WITH(crPlaza VARCHAR(10) 'strict $.crPlaza',
		 crTienda VARCHAR(10) 'strict $.crTienda',
		 fechaCentral VARCHAR(20) 'strict $.fechaCentral',
		 fechaAdmin VARCHAR(10) 'strict $.fechaAdmin',
		 fechaPOS VARCHAR(20) 'strict $.fechaPOS',
		 referencia NUMERIC(16) 'strict $.referencia',
		 monto DECIMAL(8,2) 'strict $.monto',
		 caja VARCHAR(2) 'strict $.caja',
		 operador VARCHAR(16) 'strict $.operador',
		 folioWm NUMERIC(10) 'strict $.folioWm',
		 entryMode VARCHAR(5) 'strict $.entryMode',
		 currency VARCHAR(5) 'strict $.currency',
		 tiendaFronteriza VARCHAR(5) 'strict $.tiendaFronteriza',
		 att1 VARCHAR(10) 'strict $.att1',
		 att3 VARCHAR(10) 'strict $.att3',
		 idNegocio VARCHAR(5) 'strict $.idNegocio',
		 stan NUMERIC(10) 'strict $.stan'
		 )

	RETURN 

END
