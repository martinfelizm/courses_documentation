USE [Tasaciones]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateController_tasacion]    Script Date: 7/20/2022 10:51:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER 
     PROCEDURE [dbo].[sp_CreateController_tasacion] (@objectIds varchar(200),@tableNewName varchar(max),@initSubstring int = 0, @folderDestino varchar(max))--[dbo].[sp_CreateController_tasacion]686625489, 'Tbl_Tas_AccesoriosTasacion',7,'\\OPPCTEMP2\New folder (2)\Controller' 
AS
--create procedure ooo as
DECLARE @TableName VARCHAR(8000)=''
DECLARE @TableNameFilter VARCHAR(8000)=''
DECLARE @NameSpace VARCHAR(8000) = 'Tasaciones.WebApi.Controllers' -- Replace 'namespace' with your class namespace
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
	SET @result = @result + 'using System.Net;' + CHAR(13)
	SET @result = @result + 'using Microsoft.AspNetCore.Mvc;' + CHAR(13)
	SET @result = @result + 'using Newtonsoft.Json;' + CHAR(13)
	SET @result = @result + 'using NSwag.Annotations;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Api.Responses;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Core.CustomEntities;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Core.DTOS;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Core.Identity.RequestsIdentity;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Core.Interfaces;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Core.Interfaces.InterfacesServices;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Core.QueryFilters;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Core.Requests;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Infrastructure.Identity.Auth.Permissions;' + CHAR(13)
	SET @result = @result + 'using Tasaciones.Infrastructure.Shared.Middleware;' + CHAR(13)

    IF (@TableSchema IS NOT NULL) 
    BEGIN
        SET @result = @result + 'namespace ' + @NameSpace  +';'+ CHAR(13) 
    END

    SET @result = @result 		
+ '	/// <summary>
   /// Procesos de los mantenimientos de '+@TableName+' 
   /// </summary>' + CHAR(13) 
+ 'public class ' + @TableName+ 'Controller : VersionNeutralApiController' + CHAR(13) 
+ '{' + CHAR(13) 

	SET @result = @result 
	+  'private readonly IUriService _uriService; 
		private readonly I' + @TableName + 'Service ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service;
		
		/// <summary>
		/// Contructor 
		/// </summary>
		/// <param name="' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service"></param>
		/// <param name="uriService"></param>
		public '+@TableName+'Controller(I' + @TableName + 'Service ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service, IUriService uriService)
		{

			this.' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service;
			_uriService = uriService;

		}
		
		
    /// <summary>
    /// Para obtener ' + @TableName + '
    /// </summary>
    /// <param name="filters">Para filtrar</param>
    /// <returns>Lista de las ' + @TableName + '</returns>
    [HttpGet("get")]
    [Authorization("Authorization")]
    [OpenApiOperation("Retorna una lista de todos las ' + @TableName + '", "Lista de todos las ' + @TableName + ' si deseas pueden ser filtradas")]
    [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(ApiResponse<IEnumerable<' + @TableName + 'Dto>>))]
    [ProducesResponseType((int)HttpStatusCode.BadRequest, Type = typeof(ErrorResult))]
    public async Task<IActionResult> GetList' + @TableName + 'Async([FromQuery] ' + @TableName + 'QueryFilter filters)
    {
        var ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + ' = await ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service.GetAllAsync(filters);

        var metadata = new Metadata
        {
            TotalCount = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '.TotalCount,
            PageSize = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '.PageSize,
            CurrentPage = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '.CurrentPage,
            TotalPages = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '.TotalPages,
            HasNextPage = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '.HasNextPage,
            HasPreviousPage = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '.HasPreviousPage,
            NextPageUrl = _uriService.GetPaginationUri(new BasePostQueryFilter { PageSize=filters.PageSize, PageNumber = (' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '.HasNextPage)?(filters.PageNumber+1):filters.PageNumber }, "/api/' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + '/get").ToString()
        };

        var response = new ApiResponse<IEnumerable<' + @TableName + 'Dto>>(' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + ')
        {
            Meta = metadata
        };

        Response.Headers.Add("X-Pagination", JsonConvert.SerializeObject(metadata));

        return Ok(response);
    }

    /// <summary>
    /// Inserta una nueva ' + @TableName + '
    /// </summary>/// <remarks>
    /// <param name="request">Objeto ' + @TableName + ' que va a ser agregado</param>
    /// <returns>true o false</returns>
    [HttpPost("create")]
    [Authorization("Authorization")]
    [OpenApiOperation("Inserta una nueva ' + @TableName + '", "")]
    public async Task<IActionResult> Create' + @TableName + 'Async(Create' + @TableName + 'Request request)
    {
        
        var ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Dto = await ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service.CreateAsync(request);
        var response = new ApiResponse<bool>(' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Dto);
        return Ok(response);
    }
    /// <summary>
    /// Actualiza una ' + @TableName + '
    /// </summary>
    /// <param name="request">Objeto ' + @TableName + ' que va a ser agregado</param>
    /// <returns>true o false</returns>
    [HttpPut("update")]
    [Authorization("Authorization")]
    [OpenApiOperation("Actualiza una ' + @TableName + '", "")]
    public async Task<IActionResult> Update' + @TableName + 'Async(Update' + @TableName + 'Request request)
    {
        var result = await ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service.UpdateAsync(request);
        var response = new ApiResponse<bool>(result);
        return Ok(response);
    }

    /// <summary>
    /// Elimina una ' + @TableName + '
    /// </summary>
    /// <param name="id">El Id que de desea eliminar</param>
    /// <returns>true o false</returns>
    [HttpDelete("delete/{id}")]
    [Authorization("Authorization")]
    [OpenApiOperation("Elimina una ' + @TableName + '", "")]
    public async Task<IActionResult> Delete' + @TableName + 'Async(int id)
    {
        var result = await ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + 'Service.DeleteAsync(id);
        var response = new ApiResponse<bool>(result);
        return Ok(response);
    }
		
		' + CHAR(13) + CHAR(13)
    



    SET @result = @result  
+ '}' + CHAR(13)


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
		SET @Archivo = @folderDestino + @TableName + 'Controller.cs'
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

