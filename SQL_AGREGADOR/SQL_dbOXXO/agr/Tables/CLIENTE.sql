CREATE TABLE [agr].[CLIENTE] (
    [sntIdCliente]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [varGUIDCliente] VARCHAR (46)  CONSTRAINT [DF_GUIDCliente_CLI] DEFAULT (newid()) NOT NULL,
    [varDescrip]     VARCHAR (100) NOT NULL,
    [bitIsRegulada]  BIT           NOT NULL,
    [sdtFecAlta]     SMALLDATETIME CONSTRAINT [DF_dttFecAlta_CLI] DEFAULT (getdate()) NOT NULL,
    [URLAPI]         VARCHAR (400) NULL,
    [UserAPI]        VARCHAR (50)  NULL,
    [PassAPI]        VARCHAR (50)  NULL,
    [bitIsActivo]    BIT           CONSTRAINT [DF_bitIsActivo_CLI] DEFAULT ((1)) NULL,
    [NuevoCampo] CHAR NOT NULL, 
    CONSTRAINT [PK_IdCliente_CLI] PRIMARY KEY CLUSTERED ([sntIdCliente] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_NC_varGUIDCliente_X1]
    ON [agr].[CLIENTE]([varGUIDCliente] ASC)
    INCLUDE([sntIdCliente], [varDescrip], [bitIsRegulada], [sdtFecAlta], [bitIsActivo]);

