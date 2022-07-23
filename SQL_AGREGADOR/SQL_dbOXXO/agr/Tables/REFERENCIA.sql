CREATE TABLE [agr].[REFERENCIA] (
    [numIdReferencia]      NUMERIC (15)   IDENTITY (1, 1) NOT NULL,
    [numDifReferencia]     NUMERIC (20)   NOT NULL,
    [intIdProcessControl]  NUMERIC (15)   NOT NULL,
    [numNoTransaccion]     NUMERIC (32)   NOT NULL,
    [chrIdMoneda]          CHAR (3)       NOT NULL,
    [sntIdEstablecimiento] SMALLINT       NOT NULL,
    [sntIdCliente]         SMALLINT       NOT NULL,
    [varNoBeneficiario]    VARCHAR (26)   NOT NULL,
    [decMonto]             DECIMAL (8, 2) NOT NULL,
    [numNoReferencia]      NUMERIC (16)   NOT NULL,
    [sdtFecExpiracion]     SMALLDATETIME  NOT NULL,
    [sdtFecRegistro]       SMALLDATETIME  CONSTRAINT [DF_FecRegistro_REF] DEFAULT (getdate()) NOT NULL,
    [varURLQR]             VARCHAR (140)  NULL,
    [varJSON]              VARCHAR (600)  NULL,
    [tnyIdEstatus]         TINYINT        NOT NULL,
    CONSTRAINT [PK_numIdReferencia_REF] PRIMARY KEY CLUSTERED ([numIdReferencia] ASC),
    CONSTRAINT [FK_chrIdMoneda_REF] FOREIGN KEY ([chrIdMoneda]) REFERENCES [agr].[MONEDA] ([chrIdMoneda]),
    CONSTRAINT [FK_intIdProcessControl_REF] FOREIGN KEY ([intIdProcessControl]) REFERENCES [agr].[PROCESSCONTROL] ([intIdProcessControl]),
    CONSTRAINT [FK_sntIdCliente_REF] FOREIGN KEY ([sntIdCliente]) REFERENCES [agr].[CLIENTE] ([sntIdCliente]),
    CONSTRAINT [FK_sntIdEstablecimiento_REF] FOREIGN KEY ([sntIdEstablecimiento]) REFERENCES [agr].[ESTABLECIMIENTO] ([sntIdEstablecimiento]),
    CONSTRAINT [FK_tnyIdEstatus_REF] FOREIGN KEY ([tnyIdEstatus]) REFERENCES [agr].[ESTATUS] ([tnyIdEstatus]),
    CONSTRAINT [UQ_numDifReferencia_REF] UNIQUE NONCLUSTERED ([numDifReferencia] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_NC_COMB_X1]
    ON [agr].[REFERENCIA]([tnyIdEstatus] ASC, [sdtFecExpiracion] ASC)
    INCLUDE([numIdReferencia], [intIdProcessControl], [numNoTransaccion], [chrIdMoneda], [varNoBeneficiario], [decMonto], [numNoReferencia], [sdtFecRegistro], [varURLQR], [varJSON], [sntIdEstablecimiento], [sntIdCliente]);


GO
CREATE NONCLUSTERED INDEX [IX_NC_numNoReferencia_X3]
    ON [agr].[REFERENCIA]([numNoReferencia] ASC)
    INCLUDE([numIdReferencia], [intIdProcessControl], [numNoTransaccion], [chrIdMoneda], [sntIdEstablecimiento], [sdtFecRegistro], [varURLQR], [varJSON], [tnyIdEstatus], [sntIdCliente], [varNoBeneficiario], [decMonto], [sdtFecExpiracion]);


GO
CREATE NONCLUSTERED INDEX [IX_NC_sntIdEstablecimiento_X2]
    ON [agr].[REFERENCIA]([sntIdEstablecimiento] ASC)
    INCLUDE([numIdReferencia], [intIdProcessControl], [numNoTransaccion], [chrIdMoneda], [sntIdCliente], [numNoReferencia], [sdtFecExpiracion], [sdtFecRegistro], [varURLQR], [varJSON], [tnyIdEstatus], [varNoBeneficiario], [decMonto]);


GO
CREATE NONCLUSTERED INDEX [IX_NC_numDifReferencia_X4]
    ON [agr].[REFERENCIA]([numDifReferencia] ASC)
    INCLUDE([numIdReferencia], [intIdProcessControl], [numNoTransaccion], [chrIdMoneda], [sntIdEstablecimiento], [varURLQR], [varJSON], [tnyIdEstatus], [sntIdCliente], [varNoBeneficiario], [decMonto], [numNoReferencia], [sdtFecExpiracion], [sdtFecRegistro]);

