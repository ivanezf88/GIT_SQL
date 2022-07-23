CREATE TABLE [agr].[LVAL] (
    [numIdLval]  NUMERIC (3)   IDENTITY (1, 1) NOT NULL,
    [varDescrip] VARCHAR (60)  NOT NULL,
    [varValor]   VARCHAR (60)  NULL,
    [varMensaje] VARCHAR (130) NULL,
    CONSTRAINT [PK_IdLval_LVA] PRIMARY KEY CLUSTERED ([numIdLval] ASC)
);

