USE [PROOSH]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddErrorTracer]    Script Date: 06/06/2021 23:17:28 ******/
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
