CREATE TABLE [agr].[PROCESSCONTROL] (
    [intIdProcessControl] NUMERIC (15)   IDENTITY (1, 1) NOT NULL,
    [nvarJSON]            NVARCHAR (MAX) NOT NULL,
    [tnyIdOrigen]         TINYINT        NOT NULL,
    [sdtFecRegistro]      SMALLDATETIME  CONSTRAINT [DF_sdtFecRegistro_PRO] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_intIdProcessControl_PRO] PRIMARY KEY CLUSTERED ([intIdProcessControl] ASC),
    CONSTRAINT [FK_tnyIdOrigen_PRO] FOREIGN KEY ([tnyIdOrigen]) REFERENCES [agr].[ORIGEN] ([tnyIdOrigen])
);

