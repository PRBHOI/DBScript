USE [PROOSH]
GO
/****** Object:  StoredProcedure [dbo].[sp_FindRecord]    Script Date: 06/06/2021 23:17:28 ******/
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
