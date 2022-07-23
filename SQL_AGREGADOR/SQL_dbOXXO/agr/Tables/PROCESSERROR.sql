CREATE TABLE [agr].[PROCESSERROR] (
    [intIdProcessError]   INT           IDENTITY (1, 1) NOT NULL,
    [intIdProcessControl] NUMERIC (15)  NOT NULL,
    [numIdValidacion]     NUMERIC (3)   NOT NULL,
    [varMensaje]          VARCHAR (120) NOT NULL,
    [chrCodError]         CHAR (2)      NOT NULL,
    [FecRegistro]         SMALLDATETIME CONSTRAINT [DF_FecRegistro_PRE] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_intIdProcessError_PRE] PRIMARY KEY CLUSTERED ([intIdProcessError] ASC),
    CONSTRAINT [FK_intIdProcessControl_PRE] FOREIGN KEY ([intIdProcessControl]) REFERENCES [agr].[PROCESSCONTROL] ([intIdProcessControl]),
    CONSTRAINT [FK_numIdValidacion_PRE] FOREIGN KEY ([numIdValidacion]) REFERENCES [agr].[VALIDACION] ([numIdValidacion])
);

