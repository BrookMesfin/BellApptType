/*
@Author: Brook Mesfin
@Date: November 2013
@Project Description: Create a report that shows daily appointments by type in Chirosoft v11 database (MS SQL Server 2005)
*/


DECLARE @start DATETIME, @end DATETIME;
DECLARE @strPrint VARCHAR(100), @Name VARCHAR(100);
SET NOCOUNT ON;

SET @start = CONVERT(DATE, GETDATE())
SET @end = DATEADD(DAY, 1, @start)

SET @Name ='														BELL Chiropractic';
SET @Name = @Name+ CHAR(10);
SET @strPrint = 
'												Daily Appointments Report by Type';
SET @strPrint = @strPrint + CHAR(13);
SET @strPrint = @strPrint + 
'												  Date: '+ (Cast (Getdate() AS VARCHAR (23)));
SET @strPrint = @strPrint + CHAR(13);

PRINT @Name;
PRINT @strPrint;

USE ChiroSoftDB
SELECT
(Cast (c.Description AS NVARCHAR (25))) AS 'Code Description'
, a.SeenCode
, COUNT(a.ApptTypeCode) AS 'Appointment Type'
FROM         Appointment a INNER JOIN colvalUser c 
ON c.code = a.seencode
WHERE a.ApptDateTime >= @start AND a.ApptDateTime < @end
GROUP BY a.ApptTypeCode, a.SeenCode, c.description