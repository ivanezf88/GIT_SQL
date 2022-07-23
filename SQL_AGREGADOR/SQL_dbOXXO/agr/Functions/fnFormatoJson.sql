
 CREATE FUNCTION agr.fnFormatoJson
 (@P_IdRegistro INT)
 RETURNS @tbl_Json TABLE (IdRegistro INT PRIMARY KEY IDENTITY(1,1), ExpiryDate VARCHAR(20), CurrencyCode VARCHAR(4), Amount DECIMAL(8,2), TransactionId NUMERIC(32), GUIDClient VARCHAR(46), BeneficiaryId VARCHAR(26), EstablecimientoId SMALLINT,
						  INDEX IX_NC_X1 NONCLUSTERED (GUIDClient))
 AS
 BEGIN
	
	DECLARE @json NVARCHAR(MAX)
	
	SET @json = (SELECT nvarJSON FROM agr.PROCESSCONTROL WITH(NOLOCK) WHERE intIdProcessControl = @P_IdRegistro)

	INSERT INTO @tbl_Json (ExpiryDate, CurrencyCode, Amount, TransactionId, GUIDClient, BeneficiaryId, EstablecimientoId)
	SELECT IIF(TRY_CAST(ExpiryDate AS SMALLDATETIME) IS NULL, ExpiryDate, IIF (CONVERT(SMALLDATETIME,ExpiryDate) = '1900-01-01 00:00:00', NULL,ExpiryDate)) AS ExpiryDate,
		   CurrencyCode, 
		   Amount, 
		   TransactionId, 
		   GUIDClient, 
		   BeneficiaryId, 
		   EstablecimientoId
	FROM OPENJSON(@json)
	WITH(ExpiryDate VARCHAR(20) 'strict $.ExpiryDate',
	     CurrencyCode VARCHAR(4) 'strict $.CurrencyCode',
		 Amount DECIMAL(8,2) 'strict $.Amount',
		 TransactionId NUMERIC(32) 'strict $.TransactionId',
		 GUIDClient VARCHAR(46) 'strict $.GUIDClient',
		 BeneficiaryId VARCHAR(26) 'strict $.BeneficiaryId',
		 EstablecimientoId SMALLINT 'strict $.EstablecimientoId')
	
	RETURN

 END
