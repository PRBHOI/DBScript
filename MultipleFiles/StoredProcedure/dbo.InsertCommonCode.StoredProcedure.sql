USE [PROOSH]
GO
/****** Object:  StoredProcedure [dbo].[InsertCommonCode]    Script Date: 06/06/2021 23:17:28 ******/
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
