USE [Tasaciones]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateIService_tasacion]    Script Date: 7/20/2022 10:56:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER 
     PROCEDURE [dbo].[sp_CreateIService_tasacion] (@objectIds varchar(200),@tableNewName varchar(max),@initSubstring int = 0, @folderDestino varchar(max))
AS
--create procedure ooo as
DECLARE @TableName VARCHAR(8000)=''
DECLARE @TableNameFilter VARCHAR(8000)=''
DECLARE @NameSpace VARCHAR(8000) = 'Tasaciones.Core.Interfaces.InterfacesServices' -- Replace 'namespace' with your class namespace
DECLARE @TableSchema VARCHAR(8000) = 'dbo' -- Replace 'dbo' with your schema name
DECLARE @result varchar(8000) = ''
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
   'using Tasaciones.Core.CustomEntities;
using Tasaciones.Core.DTOS;
using Tasaciones.Core.QueryFilters;
using Tasaciones.Core.Requests;' + CHAR(13)

    IF (@TableSchema IS NOT NULL) 
    BEGIN
        SET @result = @result + 'namespace ' + @NameSpace  +';'+ CHAR(13) 
    END

    SET @result = @result 		
+ '	/// <summary>
    /// Interfaz para el servicio del mantenimiento de ' + @TableName + '
    /// </summary>
    public interface I' + @TableName + 'Service : ITransientService
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '"></param>
        /// <returns></returns>
        Task<bool> CreateAsync(Create' + @TableName + 'Request ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + ');
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        Task<bool> DeleteAsync(int id);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="filters"></param>
        /// <returns></returns>
        Task<PagedList<' + @TableName + 'Dto>> GetAllAsync(' + @TableName + 'QueryFilter filters);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<bool> UpdateAsync(Update' + @TableName + 'Request request);
    }
		
		' + CHAR(13) + CHAR(13)
    



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
		SET @Archivo = @folderDestino + 'I' + @TableName +'Service.cs'
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

