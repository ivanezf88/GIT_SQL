CREATE TABLE [agr].[VALIDACION] (
    [numIdValidacion] NUMERIC (3)  IDENTITY (100, 1) NOT NULL,
    [varDescrip]      VARCHAR (60) NOT NULL,
    [chrCodError]     CHAR (2)     NOT NULL,
    CONSTRAINT [PK_IdValidacion_VAL] PRIMARY KEY CLUSTERED ([numIdValidacion] ASC)
);

