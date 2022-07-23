CREATE TABLE [agr].[CONFIGURACION] (
    [sntIdConfiguracion] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [varDescrip]         VARCHAR (60) NOT NULL,
    CONSTRAINT [PK_IdConfiguracion_CON] PRIMARY KEY CLUSTERED ([sntIdConfiguracion] ASC)
);

