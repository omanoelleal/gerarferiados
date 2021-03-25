CREATE PROCEDURE dbo.PROC_GERAR_TBL_FERIADOS
AS BEGIN
    
 
    -------------------------------
    -- Cria a tabela se não existir
    -------------------------------

    IF (OBJECT_ID('dbo.TBL_FERIADOS') IS NULL)
    BEGIN
        
        CREATE TABLE dbo.TBL_FERIADOS (
            DT_FERIADO DATE NOT NULL,
            ANO INT NOT NULL,
            MES INT NOT NULL,
            DIA INT NOT NULL,
            DESC_FERIADO NVARCHAR(100) NOT NULL,
            TIPO_FERIADO NVARCHAR(2) NOT NULL
        )
        
 
    END

 
    -- Apaga os dados se já tiverem sido populados
    TRUNCATE TABLE dbo.TBL_FERIADOS

 
    DECLARE
        @ano INT,
        @seculo INT,
        @G INT,
        @K INT,
        @I INT,
        @H INT,
        @J INT,
        @L INT,
        @MesDePascoa INT,
        @DiaDePascoa INT,
        @pascoa DATETIME 
 
 
    DECLARE 
        @Dt_Inicial datetime = '1990-01-01',
        @Dt_Final datetime = '2099-12-31'

 
    WHILE(@Dt_Inicial <= @Dt_Final)
    BEGIN
        
        SET @ANO = YEAR(@Dt_Inicial)

        SET @seculo = @ano / 100 
        SET @G = @ano % 19
        SET @K = ( @seculo - 17 ) / 25
        SET @I = ( @seculo - CAST(@seculo / 4 AS int) - CAST(( @seculo - @K ) / 3 AS int) + 19 * @G + 15 ) % 30
        SET @H = @I - CAST(@I / 28 AS int) * ( 1 * -CAST(@I / 28 AS int) * CAST(29 / ( @I + 1 ) AS int) ) * CAST(( ( 21 - @G ) / 11 ) AS int)
        SET @J = ( @ano + CAST(@ano / 4 AS int) + @H + 2 - @seculo + CAST(@seculo / 4 AS int) ) % 7
        SET @L = @H - @J
        SET @MesDePascoa = 3 + CAST(( @L + 40 ) / 44 AS int)
        SET @DiaDePascoa = @L + 28 - 31 * CAST(( @MesDePascoa / 4 ) AS int)
        SET @pascoa = CAST(@MesDePascoa AS varchar(2)) + '-' + CAST(@DiaDePascoa AS varchar(2)) + '-' + CAST(@ano AS varchar(4))

        INSERT INTO TBL_FERIADOS

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-1-1' AS DATE), @ANO, 1, 1, 'Confraternização Universal', 'BR'
             
             UNION
             
             SELECT CAST(CAST(YEAR(DATEADD(DAY , -48, @pascoa)) AS nvarchar(4)) + '-' + CAST(MONTH(DATEADD(DAY , -48, @pascoa)) AS NVARCHAR(2)) + '-' + CAST(DAY(DATEADD(DAY , -48, @pascoa)) AS NVARCHAR(2))  AS DATE), YEAR(DATEADD(DAY , -48, @pascoa)), MONTH(DATEADD(DAY , -48, @pascoa)), DAY(DATEADD(DAY , -48, @pascoa)), 'Carnaval - Segunda', 'BR'
             
             UNION
             
             SELECT CAST(CAST(YEAR(DATEADD(DAY , -47, @pascoa)) AS nvarchar(4)) + '-' + CAST(MONTH(DATEADD(DAY , -47, @pascoa)) AS NVARCHAR(2)) + '-' + CAST(DAY(DATEADD(DAY , -47, @pascoa)) AS NVARCHAR(2))  AS DATE), YEAR(DATEADD(DAY , -47, @pascoa)), MONTH(DATEADD(DAY , -47, @pascoa)), DAY(DATEADD(DAY , -47, @pascoa)), 'Carnaval - Terça', 'BR'
             
             UNION
             
             SELECT CAST(CAST(YEAR(DATEADD(DAY , -46, @pascoa)) AS nvarchar(4)) + '-' + CAST(MONTH(DATEADD(DAY , -46, @pascoa)) AS NVARCHAR(2)) + '-' + CAST(DAY(DATEADD(DAY , -46, @pascoa)) AS NVARCHAR(2))  AS DATE), YEAR(DATEADD(DAY , -46, @pascoa)), MONTH(DATEADD(DAY , -46, @pascoa)), DAY(DATEADD(DAY , -46, @pascoa)), 'Carnaval - Quarta', 'BR'
             
             UNION
             
             SELECT CAST(CAST(YEAR(DATEADD(DAY , -2, @pascoa)) AS nvarchar(4)) + '-' + CAST(MONTH(DATEADD(DAY , -2, @pascoa)) AS NVARCHAR(2)) + '-' + CAST(DAY(DATEADD(DAY , -2, @pascoa)) AS NVARCHAR(2))  AS DATE), YEAR(DATEADD(DAY , -2, @pascoa)), MONTH(DATEADD(DAY , -2, @pascoa)), DAY(DATEADD(DAY , -2, @pascoa)), 'Paixão de Cristo', 'BR'
             
             UNION
             
             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-4-21' AS DATE), @ANO, 4, 21, 'Tiradentes', 'BR'

             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-5-1' AS DATE), @ANO, 5, 1, 'Dia do Trabalhador', 'BR'

             UNION

             SELECT CAST(CAST(YEAR(DATEADD(DAY , 60, @pascoa)) AS nvarchar(4)) + '-' + CAST(MONTH(DATEADD(DAY , 60, @pascoa)) AS NVARCHAR(2)) + '-' + CAST(DAY(DATEADD(DAY , 60, @pascoa)) AS NVARCHAR(2))  AS DATE), YEAR(DATEADD(DAY , 60, @pascoa)), MONTH(DATEADD(DAY , 60, @pascoa)), DAY(DATEADD(DAY , 60, @pascoa)), 'Corpus Christi', 'BR'

             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-9-7' AS DATE), @ANO, 9, 7, 'Independência do Brasil', 'BR'
             
             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-10-12' AS DATE), @ANO, 10, 12, 'Nossa Senhora Aparecida', 'BR'
             
             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-11-2' AS DATE), @ANO, 11, 2, 'Finados', 'BR'
             
             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-11-15' AS DATE), @ANO, 11, 15, 'Proclamação da República', 'BR'

             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-12-25' AS DATE), @ANO, 12, 25, 'Natal', 'BR'

             UNION

             /* FERIADOS DO RJ */

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-4-23' AS DATE), @ANO, 4, 23, 'Dia de São Jorge', 'RJ'

             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-11-20' AS DATE), @ANO, 11, 20, 'Consciência Negra', 'RJ'

             UNION

             SELECT CAST(CAST(@ANO AS nvarchar(4)) + '-1-20' AS DATE), @ANO, 1, 20, 'Dia de São Sebastião', 'RJ'
        
 
        SET @Dt_Inicial = DATEADD(YEAR, 1, @Dt_Inicial)
       
 
    END

    
END
