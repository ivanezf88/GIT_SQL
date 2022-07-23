CREATE TABLE [agr].[CONFVALIDACIONES] (
    [numIdConfValidacion] NUMERIC (3)   IDENTITY (1, 1) NOT NULL,
    [sntIdCliente]        SMALLINT      NULL,
    [numIdValidacion]     NUMERIC (3)   NULL,
    [tnyIdNivel]          TINYINT       NOT NULL,
    [varScriptSQL]        VARCHAR (MAX) NOT NULL,
    [bitIsActivo]         BIT           CONSTRAINT [DF_bitIsActivo_CVA] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_numIdConfValidacion_CVA] PRIMARY KEY CLUSTERED ([numIdConfValidacion] ASC),
    CONSTRAINT [FK_numIdValidacion_CVA] FOREIGN KEY ([numIdValidacion]) REFERENCES [agr].[VALIDACION] ([numIdValidacion]),
    CONSTRAINT [FK_sntIdCliente_CVA] FOREIGN KEY ([sntIdCliente]) REFERENCES [agr].[CLIENTE] ([sntIdCliente]),
    CONSTRAINT [FK_tnyIdNivel_CVA] FOREIGN KEY ([tnyIdNivel]) REFERENCES [agr].[NIVEL] ([tnyIdNivel])
);


GO
CREATE NONCLUSTERED INDEX [IX_NC_COMB_X1]
    ON [agr].[CONFVALIDACIONES]([tnyIdNivel] ASC, [bitIsActivo] ASC)
    INCLUDE([numIdConfValidacion], [sntIdCliente], [numIdValidacion], [varScriptSQL]);

