CREATE TABLE [agr].[CONFIG_CLIENTE] (
    [intIdRegistro]      INT           IDENTITY (1, 1) NOT NULL,
    [sntIdCliente]       SMALLINT      NOT NULL,
    [sntIdConfiguracion] SMALLINT      NOT NULL,
    [varValor]           VARCHAR (200) NOT NULL,
    [varMsgError]        VARCHAR (60)  NULL,
    CONSTRAINT [PK_IdRegistro_COC] PRIMARY KEY CLUSTERED ([intIdRegistro] ASC),
    CONSTRAINT [FK_sntIdCliente_COC] FOREIGN KEY ([sntIdCliente]) REFERENCES [agr].[CLIENTE] ([sntIdCliente]),
    CONSTRAINT [FK_sntIdConfiguracion_COC] FOREIGN KEY ([sntIdConfiguracion]) REFERENCES [agr].[CONFIGURACION] ([sntIdConfiguracion])
);

