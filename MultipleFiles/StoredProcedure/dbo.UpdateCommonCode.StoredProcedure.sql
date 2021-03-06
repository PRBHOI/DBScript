USE [PROOSH]
GO
/****** Object:  StoredProcedure [dbo].[UpdateCommonCode]    Script Date: 06/06/2021 23:17:28 ******/
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
