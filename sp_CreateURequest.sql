USE [Tasaciones]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateURequest_tasacion]    Script Date: 7/20/2022 10:58:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER 

     PROCEDURE [dbo].[sp_CreateURequest_tasacion] (@objectIds varchar(200),@tableNewName varchar(max),@initSubstring int = 0, @folderDestino varchar(max))--[dbo].[sp_CreateURequest_tasacion]686625489,'AccesoriosTasacion',0,'\\OPPCTEMP2\New folder (2)\Controllers\'
AS
--create procedure ooo as
DECLARE @TableName VARCHAR(8000)=''
DECLARE @TableNameFilter VARCHAR(8000)=''
DECLARE @NameSpace VARCHAR(8000) = 'Tasaciones.Core.Requests' -- Replace 'namespace' with your class namespace
DECLARE @TableSchema VARCHAR(8000) = 'dbo' -- Replace 'dbo' with your schema name
DECLARE @result varchar(max) = ''
DECLARE @pathfiles varchar(8000)=''
DECLARE @Query varchar(8000)=''
DECLARE @Sql nvarchar(max)=''
DECLARE @Archivo nvarchar(max)=''

DECLARE MODELS_CURSOR CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
	SELECT DISTINCT ( case when @initSubstring > 0 then SUBSTRING([name], @initSubstring, LEN([name]) ) else '' end + @tableNewName )  ,
	[name] 
	from sys.tables where object_id in (SELECT CONVERT(INT, TRIM(value)) FROM STRING_SPLIT(@objectIds,','))
	OPEN MODELS_CURSOR
	FETCH NEXT FROM MODELS_CURSOR INTO @TableName, @TableNameFilter
WHILE @@FETCH_STATUS = 0
	BEGIN		

    
  --  SET @result = @result + 'using System.ComponentModel.DataAnnotations;' + CHAR(13) + CHAR(13) 
	SET @result = @result + 
   '#pragma warning disable 1591
using FluentValidation;
using Tasaciones.Core.Validation;' + CHAR(13)

    IF (@TableSchema IS NOT NULL) 
    BEGIN
        SET @result = @result + 'namespace ' + @NameSpace  +';'+ CHAR(13) 
    END



	
    SET @result = @result 		
+ '
    /// <summary>
    /// 
    /// </summary>
    public class Update' + @TableName + 'Request
    {
        ' + CHAR(13)
			
	SELECT @result = @result   
				 + '
        public ' + ColumnType + '? ' + ColumnName + ' { get; set; } ' + CHAR(13) 
    FROM
    (
	 SELECT  c.COLUMN_NAME   AS ColumnName, 
                dbo.fn_DataTypeEquivalence(c.TABLE_NAME, c.COLUMN_NAME) ColumnType,
                c.IS_NULLABLE AS bRequired,
                CASE c.DATA_TYPE             
                WHEN 'char' THEN  CONVERT(varchar(10),c.CHARACTER_MAXIMUM_LENGTH)
                WHEN 'nchar' THEN  CONVERT(varchar(10),c.CHARACTER_MAXIMUM_LENGTH)
                WHEN 'nvarchar' THEN  CONVERT(varchar(10),c.CHARACTER_MAXIMUM_LENGTH)
                WHEN 'varchar' THEN  CONVERT(varchar(10),c.CHARACTER_MAXIMUM_LENGTH)
                ELSE ''
				END AS MaxLen,
				c.ORDINAL_POSITION, ISNULL(IsPrimaryKey,0) IsPrimaryKey
    FROM    INFORMATION_SCHEMA.COLUMNS c
			LEFT JOIN (
				SELECT COLUMN_NAME, TABLE_NAME, 1 IsPrimaryKey
				FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
				WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA 
				+ '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1 ) pk 
						ON PK.COLUMN_NAME = C.COLUMN_NAME AND C.COLUMN_NAME = 'Id'
						AND PK.TABLE_NAME =c.TABLE_NAME
				WHERE   c.TABLE_NAME = @TableNameFilter and ISNULL(@TableSchema, c.TABLE_SCHEMA) = c.TABLE_SCHEMA  

    ) t
    ORDER BY t.ORDINAL_POSITION

    SET @result = @result + '

    }

    /// <summary>
    /// 
    /// </summary>
    public class Update' + @TableName + 'RequestValidator : CustomValidator<Update' + @TableName + 'Request>
    {
        /// <summary>
        /// Validaciones de agregar una nueva ' + @TableName + '
        /// </summary>
        public Update' + @TableName + 'RequestValidator()
        {

        }
    }' + CHAR(13)
			
	    



    --PRINT @result
		DROP TABLE IF EXISTS ##RESULTADO 

		CREATE TABLE ##RESULTADO (result varchar(max))

		EXEC master.dbo.sp_configure 'show advanced options', 1
		RECONFIGURE
		EXEC master.dbo.sp_configure 'xp_cmdshell', 1
		RECONFIGURE

		DELETE FROM ##RESULTADO

		INSERT INTO ##RESULTADO VALUES(@result)
		SET @result = ''
		SET @Archivo = @folderDestino + @TableName + 'Request.cs'
		SET @Query ='SELECT * FROM ##RESULTADO'

		--set @Sql = 'bcp "'+@Query+'" queryout "'+ @Archivo+ '" -T -c'

		--EXEC xp_cmdshell @Sql;
		SET @Sql = 'EXEC master..xp_cmdshell ' + char(39) + 'bcp "'+ @Query +
				   '" queryout "' + @Archivo 
				   + '" -P qYKsDjkaX3 -U Apps_User_Dev -S DINTERNOSRV\DEVCONFISA -c -C 65001 -t  ' + char(39)

		print @sql		
		EXEC sp_executesql @Sql

		EXEC master.dbo.sp_configure 'xp_cmdshell', 0
		RECONFIGURE

		FETCH NEXT FROM MODELS_CURSOR INTO @TableName, @TableNameFilter
	END
CLOSE MODELS_CURSOR
DEALLOCATE MODELS_CURSOR

