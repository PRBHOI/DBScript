USE [PROOSH]
GO
/****** Object:  StoredProcedure [dbo].[GetAllCommonCode]    Script Date: 06/06/2021 23:17:28 ******/
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
