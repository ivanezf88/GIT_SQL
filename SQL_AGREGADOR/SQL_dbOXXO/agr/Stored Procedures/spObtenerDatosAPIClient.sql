CREATE PROC [agr].[spObtenerDatosAPIClient]
(@IdProcessControl NUMERIC(15))
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @NoReferencia NUMERIC(16)

	SET @NoReferencia = (SELECT Referencia FROM swt.fnFormatoJsonCargo(@IdProcessControl))


	SELECT CLI.URLAPI, 
		   'Token' AS EPToken,
		   'api/OXXO/Auth/Success' AS EPAutoriza,
		   CLI.UserAPI,
		   CLI.PassAPI
	FROM agr.CLIENTE AS CLI
		INNER JOIN agr.REFERENCIA AS REF ON CLI.sntIdCliente = REF.sntIdCliente
	WHERE REF.numNoReferencia = @NoReferencia


	SET NOCOUNT OFF
END