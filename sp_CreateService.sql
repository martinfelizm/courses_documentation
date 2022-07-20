USE [Tasaciones]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateService_tasacion]    Script Date: 7/20/2022 10:58:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER 

     PROCEDURE [dbo].[sp_CreateService_tasacion] (@objectIds varchar(200),@tableNewName varchar(max),@initSubstring int = 0, @folderDestino varchar(max)) -- [dbo].[sp_CreateService_tasacion]686625489, 'AccesoriosTasacion',0,'\\OPPCTEMP2\New folder (2)\Controllers\'  
AS
--create procedure ooo as
DECLARE @TableName VARCHAR(8000)=''
DECLARE @TableNameFilter VARCHAR(8000)=''
DECLARE @NameSpace VARCHAR(8000) = 'Tasaciones.Core.Services' -- Replace 'namespace' with your class namespace
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
   'using AutoMapper;
using Microsoft.Extensions.Options;
using Tasaciones.Core.Constants;
using Tasaciones.Core.CustomEntities;
using Tasaciones.Core.DTOS;
using Tasaciones.Core.Entities;
using Tasaciones.Core.Exceptions;
using Tasaciones.Core.Interfaces;
using Tasaciones.Core.Interfaces.InterfacesServices;
using Tasaciones.Core.QueryFilters;
using Tasaciones.Core.Requests;' + CHAR(13)

    IF (@TableSchema IS NOT NULL) 
    BEGIN
        SET @result = @result + 'namespace ' + @NameSpace  +';'+ CHAR(13) 
    END



	
    SET @result = @result 		
+ '
    /// <summary>
    /// Servicio para el mantenimiento para las ' + @TableName + '
    /// </summary>
    public class ' + @TableName + 'Service : I' + @TableName + 'Service
    {
        private readonly IUnitOfWork unitOfWork;
        private readonly IMapper mapper;
        private readonly PaginationOptions _paginationOptions;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="unitOfWork"></param>
        /// <param name="mapper"></param>
        public ' + @TableName + 'Service(IUnitOfWork unitOfWork, IMapper mapper, IOptions<PaginationOptions> options)
        {
            this.unitOfWork = unitOfWork;
            this.mapper = mapper;
            this._paginationOptions = options.Value;
        }
        /// <summary>
        /// Obtener las ' + @TableName + ' 
        /// </summary>
        /// <param name="filter"> opciones para filtrar la obtencion de datos</param>
        /// <returns> Retorna los datos paginados</returns>
        public async Task<PagedList<' + @TableName + 'Dto>> GetAllAsync(' + @TableName + 'QueryFilter filters)
        {


            filters.PageNumber = filters.PageNumber == 0 ? _paginationOptions.DefaultPageNumber : filters.PageNumber;
            filters.PageSize = filters.PageSize == 0 ? _paginationOptions.DefaultPageSize : filters.PageSize;

            var ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + ' = await unitOfWork.' + @TableName + 'Repository.GetAll();
            if ( ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + ' == null )
                throw new BusinessException(ApiConstants.Messages.DataEmptyError);

			' + CHAR(13)
			
	SELECT @result = @result + ' 
            if ( filters.' + ColumnName + ' != null && filters.' + ColumnName + ' != 0 )
            {
                ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + ' = ' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) 
				+ '.Where(f => f.' + ColumnName + '.Equals(filters.' + ColumnName + '));
            }' +  CHAR(13) +  CHAR(13) 
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




            var reponse = mapper.Map<IEnumerable<' + @TableName + 'Dto>>(' + LOWER(SUBSTRING(@TableName,1,1))+SUBSTRING(@TableName,2,LEN(@TableName)) + ');


            var paged' + @TableName + ' = PagedList<' + @TableName + 'Dto>.Create(reponse, filters.PageNumber, filters.PageSize);
            return paged' + @TableName + ';


        }

        /// <summary>
        /// Elimina una ' + @TableName + '
        /// </summary>
        /// <param name="id">El Id que de desea eliminar</param>
        /// <returns>true o false</returns>
        public async Task<bool> DeleteAsync(int id)
        {
            var existing = await unitOfWork.' + @TableName + 'Repository.GetById(id);
            if ( existing == null )
                throw new BusinessException(ApiConstants.Messages.DeletionNotAllowed);
            await unitOfWork.' + @TableName + 'Repository.Delete(id);
            await unitOfWork.SaveChangesAsync();

            return true;

        }

        /// <summary>
        /// Inserta una nueva ' + @TableName + '
        /// </summary>
        /// <param name="request">Objeto ' + @TableName + ' que va a ser agregado</param>
        /// <returns>true o false</returns>
        public async Task<bool> CreateAsync(Create' + @TableName + 'Request request)
        {


            var param = new ' + @TableName + '
            {' + CHAR(13)
			
	SELECT @result = @result   
				+ ColumnName + ' = request.' + ColumnName + ', ' + CHAR(13) 
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

    SET @result = @result + '};
            if ( request != null )
            {
                await unitOfWork.' + @TableName + 'Repository.Add(param);
                await unitOfWork.SaveChangesAsync();
            }


            return true;
        }

        /// <summary>
        /// Actualiza una ' + @TableName + '
        /// </summary>
        /// <param name="request">Objeto ' + @TableName + ' que va a ser agregado</param>
        /// <returns>true o false</returns>
        public async Task<bool> UpdateAsync(Update' + @TableName + 'Request request)
        {
            var existing = await unitOfWork.' + @TableName + 'Repository.GetById(request.Id);
            
			' + CHAR(13)
			
	SELECT @result = @result 
			+'existing.'+ ColumnName + ' = (request.' + ColumnName + ' != null)? request.' + ColumnName + ' :  existing.'+ ColumnName + '; ' + CHAR(13) 
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
            unitOfWork.' + @TableName + 'Repository.Update(existing);
            await unitOfWork.SaveChangesAsync();

            return true;
        }
' + CHAR(13)




    SET @result = @result 		
+ '}
		
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
		SET @Archivo = @folderDestino + @TableName + 'Service.cs'
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

