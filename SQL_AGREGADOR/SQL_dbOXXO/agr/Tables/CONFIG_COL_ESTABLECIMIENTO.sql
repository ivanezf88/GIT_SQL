CREATE TABLE [agr].[CONFIG_COL_ESTABLECIMIENTO] (
    [intIdConColEstable]   INT           IDENTITY (1, 1) NOT NULL,
    [intIdConNivEstable]   INT           NULL,
    [sntIdEstablecimiento] SMALLINT      NOT NULL,
    [tnyOrden]             TINYINT       NOT NULL,
    [varColumna]           VARCHAR (25)  NOT NULL,
    [varTipoDato]          VARCHAR (50)  NOT NULL,
    [varValor]             VARCHAR (200) NULL,
    CONSTRAINT [PK_intIdConColEstable_CCE] PRIMARY KEY CLUSTERED ([intIdConColEstable] ASC),
    CONSTRAINT [FK_intIdConNivEstable_CCE] FOREIGN KEY ([intIdConNivEstable]) REFERENCES [agr].[CONFIG_NIVEL_ESTABLECIMIENTO] ([intIdConNivEstable]),
    CONSTRAINT [FK_sntIdEstablecimiento_CCE] FOREIGN KEY ([sntIdEstablecimiento]) REFERENCES [agr].[ESTABLECIMIENTO] ([sntIdEstablecimiento])
);


GO
CREATE NONCLUSTERED INDEX [IX_sntIdEstablecimiento_X1]
    ON [agr].[CONFIG_COL_ESTABLECIMIENTO]([sntIdEstablecimiento] ASC)
    INCLUDE([intIdConColEstable], [intIdConNivEstable], [tnyOrden], [varColumna], [varTipoDato]);

