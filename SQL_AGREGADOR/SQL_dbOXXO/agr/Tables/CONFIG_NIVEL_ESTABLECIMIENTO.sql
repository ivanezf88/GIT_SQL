CREATE TABLE [agr].[CONFIG_NIVEL_ESTABLECIMIENTO] (
    [intIdConNivEstable]   INT          IDENTITY (1, 1) NOT NULL,
    [sntIdEstablecimiento] SMALLINT     NOT NULL,
    [tnyNivel]             TINYINT      NOT NULL,
    [Descrip]              VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_intIdRegistro_CNE] PRIMARY KEY CLUSTERED ([intIdConNivEstable] ASC),
    CONSTRAINT [FK_sntIdEstablecimiento_CNE] FOREIGN KEY ([sntIdEstablecimiento]) REFERENCES [agr].[ESTABLECIMIENTO] ([sntIdEstablecimiento])
);


GO
CREATE NONCLUSTERED INDEX [IX_sntIdEstablecimiento_X1]
    ON [agr].[CONFIG_NIVEL_ESTABLECIMIENTO]([sntIdEstablecimiento] ASC)
    INCLUDE([intIdConNivEstable], [tnyNivel], [Descrip]);

