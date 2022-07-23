CREATE TABLE [agr].[ESTABLECIMIENTO] (
    [sntIdEstablecimiento]  SMALLINT     IDENTITY (1, 1) NOT NULL,
    [varCodEstablecimiento] VARCHAR (12) NOT NULL,
    [varDescrip]            VARCHAR (32) NOT NULL,
    [intNoSocio]            INT          NULL,
    CONSTRAINT [PK_sntIdEstablecimiento_EST] PRIMARY KEY CLUSTERED ([sntIdEstablecimiento] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_NC_varCodEstablecimiento_X1]
    ON [agr].[ESTABLECIMIENTO]([varCodEstablecimiento] ASC)
    INCLUDE([sntIdEstablecimiento], [varDescrip], [intNoSocio]);

