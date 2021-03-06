USE [PROOSH]
GO
/****** Object:  StoredProcedure [dbo].[utsp_GenerateScriptforInsertUpdateDelete]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Parameters 
@Schemaname            - SchemaName to which the table belongs to. Default value 'dbo'. 
@Tablename            - TableName for which the procs needs to be generated. 
@ProcName            - Procedure name. Default is blank and when blank the procedure name generated will be sp_<Tablename> 
@IdentityInsert        - Flag to say if the identity insert needs to be done to the table or not if identity column exists in the table. 
                      Default value is 0. 
*/ 
CREATE PROC [dbo].[utsp_GenerateScriptforInsertUpdateDelete] 
	(
		@Schemaname Sysname = 'dbo' 
		,@Tablename  Sysname 
		,@ProcName     Sysname = '' 
		,@IdentityInsert  bit  = 0  
	)
AS 
	BEGIN
		SET NOCOUNT ON 

		--IF OBJECT_ID('utsp_GenerateScriptforInsertUpdateDelete','P') IS NOT NULL 
		--   DROP PROC utsp_GenerateScriptforInsertUpdateDelete 
		
		DECLARE @PKTable TABLE 
			( 
				TableQualifier SYSNAME 
				,TableOwner       SYSNAME 
				,TableName       SYSNAME 
				,ColumnName       SYSNAME 
				,KeySeq           int 
				,PKName           SYSNAME 
			)
		INSERT INTO @PKTable 
		Exec sp_pkeys @Tablename,@Schemaname 

		--SELECT * FROM @PKTable 
		DECLARE @columnNames              VARCHAR(MAX) 
		DECLARE @columnNamesWithDatatypes VARCHAR(MAX) 
		DECLARE @InsertcolumnNames          VARCHAR(MAX) 
		DECLARE @UpdatecolumnNames          VARCHAR(MAX) 
		DECLARE @IdentityExists              BIT 
 
		SELECT @columnNames = '' 
		SELECT @columnNamesWithDatatypes = '' 
		SELECT @InsertcolumnNames = '' 
		SELECT @UpdatecolumnNames = '' 
		SELECT @IdentityExists = 0 

		DECLARE @MaxLen INT 


		SELECT @MaxLen =  MAX(LEN(SC.NAME)) 
			FROM sys.schemas SCH 
			JOIN sys.tables  ST 
			ON SCH.schema_id =ST.schema_id 
			JOIN sys.columns SC 
			ON ST.object_id = SC.object_id 
			WHERE SCH.name = @Schemaname 
			AND ST.name  = @Tablename  
			AND SC.is_identity = CASE 
							WHEN @IdentityInsert = 1 THEN SC.is_identity 
							ELSE 0 
							END 
			AND SC.is_computed = 0 
	
	SELECT @columnNames = @columnNames + SC.name + ',' 
      ,@columnNamesWithDatatypes = @columnNamesWithDatatypes +'@' + SC.name  
                                                             + REPLICATE(' ',@MaxLen + 5 - LEN(SC.NAME)) + STY.name  
                                                             + CASE  
                                                               WHEN STY.NAME IN ('Char','Varchar') AND SC.max_length <> -1 THEN '(' + CONVERT(VARCHAR(4),SC.max_length) + ')' 
                                                               WHEN STY.NAME IN ('Nchar','Nvarchar') AND SC.max_length <> -1 THEN '(' + CONVERT(VARCHAR(4),SC.max_length / 2 ) + ')' 
                                                               WHEN STY.NAME IN ('Char','Varchar','Nchar','Nvarchar') AND SC.max_length = -1 THEN '(Max)' 
                                                               ELSE '' 
                                                               END  
                                                               + CASE 
                                                                 WHEN NOT EXISTS(SELECT 1 FROM @PKTable WHERE ColumnName=SC.name) THEN  ' = NULL,' + CHAR(13) 
                                                                 ELSE ',' + CHAR(13) 
                                                                 END 
       ,@InsertcolumnNames = @InsertcolumnNames + '@' + SC.name + ',' 
       ,@UpdatecolumnNames = @UpdatecolumnNames  
                             + CASE 
                               WHEN NOT EXISTS(SELECT 1 FROM @PKTable WHERE ColumnName=SC.name) THEN  
                                    CASE  
                                    WHEN @UpdatecolumnNames ='' THEN '' 
                                    ELSE '       ' 
                                    END +  SC.name +  + REPLICATE(' ',@MaxLen + 5 - LEN(SC.NAME)) + '= ' + '@' + SC.name + ',' + CHAR(13) 
                               ELSE '' 
                               END  
      ,@IdentityExists  = CASE  
                          WHEN SC.is_identity = 1 OR @IdentityExists = 1 THEN 1  
                          ELSE 0 
                          END 
	  FROM sys.schemas SCH 
	  JOIN sys.tables  ST 
		ON SCH.schema_id =ST.schema_id 
	  JOIN sys.columns SC 
		ON ST.object_id = SC.object_id 
	  JOIN sys.types STY 
		ON SC.user_type_id     = STY.user_type_id 
	   AND SC.system_type_id = STY.system_type_id 
	 WHERE SCH.name = @Schemaname 
	   AND ST.name  = @Tablename 
	   AND SC.is_identity = CASE 
							WHEN @IdentityInsert = 1 THEN SC.is_identity 
							ELSE 0 
							END 
	   AND SC.is_computed = 0 
	
	DECLARE @InsertSQL VARCHAR(MAX) 
	DECLARE @UpdateSQL VARCHAR(MAX) 
	DECLARE @DeleteSQL VARCHAR(MAX) 
	DECLARE @PKWhereClause VARCHAR(MAX) 
 
	SELECT @PKWhereClause = '' 
 
	SELECT @PKWhereClause = @PKWhereClause + ColumnName + ' = ' + '@' + ColumnName + CHAR(13) + '   AND '  
	  FROM @PKTable 
	ORDER BY KeySeq 

	SELECT @columnNames          = SUBSTRING(@columnNames,1,LEN(@columnNames)-1) 
	SELECT @InsertcolumnNames = SUBSTRING(@InsertcolumnNames,1,LEN(@InsertcolumnNames)-1) 
	SELECT @UpdatecolumnNames = SUBSTRING(@UpdatecolumnNames,1,LEN(@UpdatecolumnNames)-2) 
	SELECT @PKWhereClause      = SUBSTRING(@PKWhereClause,1,LEN(@PKWhereClause)-5) 
	SELECT @columnNamesWithDatatypes = SUBSTRING(@columnNamesWithDatatypes,1,LEN(@columnNamesWithDatatypes)-2) 
	SELECT @columnNamesWithDatatypes = @columnNamesWithDatatypes + ',' +  CHAR(13) + '@DMLFlag     VARCHAR(1)' 
 
 
	SELECT @InsertSQL = 'INSERT INTO ' + @Schemaname +'.' + @Tablename  
									   + CHAR(13) + '(' + @columnNames + ')' +  
									   + CHAR(13) + 'SELECT ' + @InsertcolumnNames  
 
	SELECT @DeleteSQL = 'DELETE FROM ' + @Schemaname +'.' + @Tablename  
									   + CHAR(13) + ' WHERE ' + @PKWhereClause 
 
	SELECT @UpdateSQL = 'UPDATE '  + @Schemaname +'.' + @Tablename  
								   + CHAR (13) + '   SET ' + @UpdatecolumnNames  
								   + CHAR (13) + ' WHERE ' + @PKWhereClause 

	IF LTRIM(RTRIM(@ProcName)) = ''  
	 SELECT @ProcName = 'SP_' + @Tablename 
	 PRINT 'IF OBJECT_ID(''' + @ProcName + ''',''P'') IS NOT NULL' 
	 PRINT 'DROP PROC ' + @ProcName 
	 PRINT 'GO' 
	 PRINT 'CREATE PROCEDURE ' + @ProcName +  CHAR (13) +  @columnNamesWithDatatypes +  CHAR (13) + 'AS' +  CHAR (13) 
	 PRINT 'IF @DMLFlag = ''I''' 
	 PRINT 'BEGIN' 
	 IF @IdentityExists = 1 AND @IdentityInsert = 1  
	 PRINT 'SET IDENTITY_INSERT ' + @Schemaname + '.' + @Tablename + ' ON ' 
	 PRINT '' 
	 PRINT @InsertSQL 
	 PRINT '' 
	 IF @IdentityExists = 1 AND @IdentityInsert = 1  
	 PRINT 'SET IDENTITY_INSERT ' + @Schemaname + '.' + @Tablename + ' OFF ' 
	 PRINT 'END' 
	 PRINT '' 
	 PRINT 'IF @DMLFlag = ''U''' 
	 PRINT 'BEGIN' 
	 PRINT '' 
	 PRINT @UpdateSQL 
	 PRINT '' 
	 PRINT 'END' 
  
	 PRINT '' 
	 PRINT 'IF @DMLFlag = ''D''' 
	 PRINT 'BEGIN' 
	 PRINT '' 
	 PRINT @DeleteSQL 
	 PRINT '' 
	 PRINT 'END' 
	 PRINT 'GO' 
  
	SET NOCOUNT OFF 
END;
GO
/****** Object:  StoredProcedure [dbo].[utsp_CreateModelFromTable]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Parameters 
@Tablename            - TableName for which the procs needs to be generated. 
                      Default value is 0. 
*/
CREATE PROCEDURE [dbo].[utsp_CreateModelFromTable]
(  
     @TableName SYSNAME ,  
     @CLASSNAME VARCHAR(500)   
)  
AS  
BEGIN  
    DECLARE @Result VARCHAR(MAX)  
    SET @Result = @CLASSNAME + Replace(@TableName,'tbl_','') + '  
{'  
SELECT @Result = @Result + '  
    public ' + ColumnType + NullableSign + ' ' + ColumnName + ' { get; set; }'  
FROM  
(  
    SELECT   
        REPLACE(col.NAME, ' ', '_') ColumnName,  
        column_id ColumnId,  
        CASE typ.NAME   
            WHEN 'bigint' THEN 'long'  
            WHEN 'binary' THEN 'byte[]'  
            WHEN 'bit' THEN 'bool'  
            WHEN 'char' THEN 'string'  
            WHEN 'date' THEN 'DateTime'  
            WHEN 'datetime' THEN 'DateTime'  
            WHEN 'datetime2' then 'DateTime'  
            WHEN 'datetimeoffset' THEN 'DateTimeOffset'  
            WHEN 'decimal' THEN 'decimal'  
            WHEN 'float' THEN 'float'  
            WHEN 'image' THEN 'byte[]'  
            WHEN 'int' THEN 'int'  
            WHEN 'money' THEN 'decimal'  
            WHEN 'nchar' THEN 'char'  
            WHEN 'ntext' THEN 'string'  
            WHEN 'numeric' THEN 'decimal'  
            WHEN 'nvarchar' THEN 'string'  
            WHEN 'real' THEN 'double'  
            WHEN 'smalldatetime' THEN 'DateTime'  
            WHEN 'smallint' THEN 'short'  
            WHEN 'smallmoney' THEN 'decimal'  
            WHEN 'text' THEN 'string'  
            WHEN 'time' THEN 'TimeSpan'  
            WHEN 'timestamp' THEN 'DateTime'  
            WHEN 'tinyint' THEN 'byte'  
            WHEN 'uniqueidentifier' THEN 'Guid'  
            WHEN 'varbinary' THEN 'byte[]'  
            WHEN 'varchar' THEN 'string'  
            ELSE 'UNKNOWN_' + typ.NAME  
        END ColumnType,  
        CASE   
            WHEN col.is_nullable = 1 and typ.NAME in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier')   
            THEN '?'   
            ELSE ''   
        END NullableSign  
    FROM SYS.COLUMNS col join sys.types typ on col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id  
    where object_id = object_id(@TableName)  
) t  
ORDER BY ColumnId  
SET @Result = @Result  + '  
}'  
print @Result  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_FindRecord]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_FindRecord]
	(
		@tablename varchar(100),
		@clause varchar(500),
		@rowcount int OUTPUT
	)
AS
BEGIN	
	DECLARE @SQLQuery AS NVARCHAR(500)
	
	Set @SQLQuery = 'SELECT * FROM ' + @tablename + ' WHERE ' + @clause
	
	EXEC (@SQLQuery)
	SET @Rowcount = @@ROWCOUNT
	SELECT @Rowcount

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddErrorTracer]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Purpose    : Insert the error details occurred in the SQL query
Input      : Insert the details which receives from the TRY...CATCH block
Output     : Insert the details of received errors into the ErrorTracer table
Created By : Priyaranjan Bhoi
Created On : March 23, 2017
*/
CREATE PROCEDURE [dbo].[sp_AddErrorTracer]
@ErrorMessage varchar(Max) out
AS
BEGIN
  
  DECLARE @error_number VARCHAR(MAX)  
  DECLARE @error_state VARCHAR(MAX)  
  DECLARE @error_severity VARCHAR(MAX)  
  DECLARE @error_line VARCHAR(MAX)  
  DECLARE @error_proc VARCHAR(MAX)  
  DECLARE @error_mesg VARCHAR(MAX)  
  DECLARE @user_name VARCHAR(MAX)  
  DECLARE @host_name VARCHAR(MAX) 

  SELECT  @error_number = ERROR_NUMBER()  
       ,@error_state = ERROR_STATE()  
       ,@error_severity = ERROR_SEVERITY()  
       ,@error_line = ERROR_LINE()  
       ,@error_proc = ERROR_PROCEDURE()  
       ,@error_mesg = ERROR_MESSAGE()  
       ,@user_name = SUSER_SNAME()  
       ,@host_name = Host_NAME()  
  
	INSERT INTO tbl_ErrorTracer( ErrorNumber
								,ErrorState
								,ErrorSeverity
								,ErrorLine
								,ErrorProc
								,ErrorMsg
								,UserName
								,HostName
								,ErrorDate)  
						VALUES( @error_number
								,@error_state
								,@error_severity
								,@error_line
								,@error_proc
								,@error_mesg
								,@user_name
								,@host_name
								,GETDATE())  ;
	select
		@ErrorMessage = cast((' Error Detail >> Error Number :' + convert(nvarchar(20), @error_number) + ' Error Message: ' + @error_mesg)as nvarchar(4000));

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateCommonCode]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCommonCode]
(
	@ComId			int, 	@ShortDesc      nvarchar(50),	@LongDesc       nvarchar(500),	@Position       int = NULL,	@IsActive       bit = NULL,	@CreatedBy      int = NULL,	@CreatedOn      datetime = NULL,	@ModifiedBy     int = NULL,	@ModifiedOn     datetime = NULL,	  
	@Error_Code		varchar(10) OUT,
	@Error_Message	varchar(1000) OUT
)

AS
BEGIN
  SET NOCOUNT ON 
	SET XACT_ABORT OFF 
	DECLARE	@exceptionMessage nvarchar(4000);
	
	DECLARE @tablename varchar(50)
	DECLARE @paramforrecordexist  varchar(100);
	DECLARE @rowcount  int;
	
	SET	@Error_Code = 0;
	SET @Error_Message = '';
		
	SET	@tablename = 'tbl_cm_code';
	
	SET	
		@paramforrecordexist = 'ComId = '''+cast(@ComId as varchar(10))+'''';
	
	
   		
	Exec sp_FindRecord @tablename , @paramforrecordexist, @rowcount OUTPUT;
	
	IF (@rowcount >=0 )
		BEGIN
			SELECT
			@Error_Code = 1,
			@Error_Message = 'The Common Code doesnot exist. Please enter valid information.';
			RETURN;
		END
		    
		
	BEGIN TRANSACTION trans 
	BEGIN TRY 
	
		UPDATE tbl_cm_code		   SET ShortDesc      = @ShortDesc,			   LongDesc       = @LongDesc,			   Position       = ISNULL(@Position,Position),			   IsActive       = ISNULL(@IsActive,IsActive),			   CreatedBy      = ISNULL(@CreatedBy,CreatedBy),			   CreatedOn      = ISNULL(@CreatedOn,CreatedOn),			   ModifiedBy     = ISNULL(@ModifiedBy,ModifiedBy),			   ModifiedOn     = ISNULL(@ModifiedOn,ModifiedOn)		 WHERE ComId = @ComId					  
							  
	IF(@@TRANCOUNT > 0) 
			BEGIN
				SAVE TRANSACTION trans ;
				COMMIT TRANSACTION	;
			END		
		
	--SELECT ComId ,ShortDesc ,LongDesc ,Position ,IsActive ,CreatedBy ,CreatedOn ,ModifiedBy ,ModifiedOn FROM tbl_cm_code
	-- where ComId=@ComId
						  
	END TRY
	BEGIN CATCH
		Exec sp_AddErrorTracer @ErrorMessage = @exceptionMessage out;
				SELECT
					@Error_Code = 1,
					@Error_Message = cast( 'An unknown error has occurred. Failed to Update Common Code.' + @exceptionMessage  as nvarchar(4000));

				IF (@@TRANCOUNT > 0) 
					BEGIN
						ROLLBACK TRANSACTION;
				    	
					END
	
	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertCommonCode]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCommonCode]
(
	@ShortDesc      nvarchar(50) = NULL,	@LongDesc       nvarchar(500) = NULL,	@Position       int = NULL,	@IsActive       bit = NULL,	@CreatedBy      int = NULL,	@CreatedOn      datetime = NULL,	@ModifiedBy     int = NULL,	@ModifiedOn     datetime = NULL,	  
	@Error_Code		varchar(10) OUT,
	@Error_Message	varchar(1000) OUT
)

AS
BEGIN
  SET NOCOUNT ON; 
	SET XACT_ABORT OFF ;
	DECLARE	@exceptionMessage nvarchar(4000);
	
	SELECT	@Error_Code = 0,
		    @Error_Message = '';
	
	BEGIN TRANSACTION trans 
	BEGIN TRY 
	
		INSERT INTO dbo.tbl_cm_code(ShortDesc,LongDesc,Position,IsActive,CreatedBy,CreatedOn,ModifiedBy,ModifiedOn)							  values(@ShortDesc,@LongDesc,@Position,@IsActive,ISNULL(@CreatedBy,1),ISNULL(@CreatedOn,GETDATE()),ISNULL(@ModifiedBy,1),ISNULL(@ModifiedOn,GETDATE()))
							  
							  
	IF(@@TRANCOUNT > 0) 
			BEGIN
				SAVE TRANSACTION trans ;
				COMMIT TRANSACTION	;
			END		
		
		SELECT ComId ,ShortDesc ,LongDesc ,Position ,IsActive ,CreatedBy ,CreatedOn ,ModifiedBy ,ModifiedOn FROM tbl_cm_code
		 where ComId=ident_current('tbl_cm_code')
							  
	END TRY
	BEGIN CATCH
		Exec sp_AddErrorTracer @ErrorMessage = @exceptionMessage out;
				SELECT
					@Error_Code = 1,
					@Error_Message = cast( 'An unknown error has occurred. Failed to Save Information.' + @exceptionMessage  as nvarchar(4000));

				IF (@@TRANCOUNT > 0) 
					BEGIN
						ROLLBACK TRANSACTION;
				    	
					END
	
	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[GetCommonCodeById]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCommonCodeById]
(
	@Id int,
	@Error_Code varchar(10) OUT,
	@Error_Message varchar(1000) OUT
)
AS
BEGIN
    SET NOCOUNT ON 
	SET XACT_ABORT OFF 
	DECLARE	@exceptionMessage	nvarchar(4000);

	SELECT
		@Error_Code = 0,
		@Error_Message = '';
		
	BEGIN TRY 
			SELECT 
			   ComId
			  ,ShortDesc
			  ,LongDesc
			  ,Position
			  ,IsActive
			  ,CreatedBy
			  ,CreatedOn
			  ,ModifiedBy
			  ,ModifiedOn
		  FROM tbl_cm_code
		  Where ComId = @Id
			
	END TRY
	BEGIN CATCH
			Exec sp_AddErrorTracer @ErrorMessage = @exceptionMessage out;
			SELECT
				@Error_Code = 1,
				@Error_Message = cast( 'An unknown error has occurred. Failed to fetch Infomation.' + @exceptionMessage  as nvarchar(4000));

		END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAllCommonCode]    Script Date: 06/06/2021 23:07:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllCommonCode]
(
	@Error_Code varchar(10) OUT,
	@Error_Message varchar(1000) OUT
)
AS
BEGIN
    SET NOCOUNT ON 
	SET XACT_ABORT OFF 
	DECLARE	@exceptionMessage	nvarchar(4000);

	SELECT
		@Error_Code = 0,
		@Error_Message = '';
		
	BEGIN TRY 
	SELECT [ComId]
      ,[ShortDesc]
      ,[LongDesc]
      ,[Position]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedOn]
      ,[ModifiedBy]
      ,[ModifiedOn]
  FROM [PROOSH].[dbo].[tbl_cm_code]
			
	END TRY
	BEGIN CATCH
			Exec sp_AddErrorTracer @ErrorMessage = @exceptionMessage out;
			SELECT
				@Error_Code = 1,
				@Error_Message = cast( 'An unknown error has occurred. Failed to fetch Infomation.' + @exceptionMessage  as nvarchar(4000));

		END CATCH
END;
GO
