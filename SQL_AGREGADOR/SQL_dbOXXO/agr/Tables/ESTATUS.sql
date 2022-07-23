CREATE TABLE [agr].[ESTATUS] (
    [tnyIdEstatus] TINYINT      IDENTITY (1, 1) NOT NULL,
    [varDescrip]   VARCHAR (46) NOT NULL,
    CONSTRAINT [PK_tnyIdEstatus_EST] PRIMARY KEY CLUSTERED ([tnyIdEstatus] ASC)
);

