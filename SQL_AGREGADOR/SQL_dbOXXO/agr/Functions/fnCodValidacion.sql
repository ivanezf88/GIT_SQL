
 CREATE FUNCTION agr.fnCodValidacion
 (@vcReference VARCHAR(16))
 RETURNS CHAR(1)
 AS
 BEGIN

	DECLARE @iNumber SMALLINT = 0, 
			@vcNumber CHAR(1) = '', 
			@iCont SMALLINT, 
			@iSum SMALLINT = 0, 
			@iChecker SMALLINT

	SET @iCont = LEN(@vcReference)

	WHILE 0 = 0
	BEGIN
		SET @iCont = @iCont - 1

		SET @vcNumber = RIGHT(@vcReference,1)

		SET @iNumber = @vcNumber

		IF @vcNumber = ''
		BEGIN
			BREAK
		END

		IF (@iCont % 2) = 0
		BEGIN
			SET @iNumber = @iNumber * 2

			IF @iNumber > 9
			BEGIN
				SET @iNumber = @iNumber - 9
			END

		END

		SET @iSum = @iSum + @iNumber

		SET @vcReference = LEFT(@vcReference,@iCont)
			
	END

	SET @iChecker = (10 - (@iSum % 10))

	IF @iChecker = 10
	BEGIN
		SET @iChecker = 0
	END


	RETURN @iChecker

 END
