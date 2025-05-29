
/************************************************************************************
================================================================
Author			:	Soumyaranjan
Create date		:   2025-05-29
Description		:	Procedure to Get Employee History
================================================================
Change log: Any modification to the View has to be reported here
Date		Name			Jira Ticket No		Description
2025-05-29  Soumyaranjan						Initial Version


************************************************************************************/

CREATE PROCEDURE SP_GetEmployeeHistory
    @EmployeeID INT
AS
BEGIN
    BEGIN TRY
        SELECT 
            ej.StartDate,
            ej.EndDate,
            j.JobTitle,
            s.BasicSalary,
            s.Bonus,
            s.EffectiveFrom
        FROM EmployeeJob ej
        INNER JOIN Job j ON ej.JobID = j.JobID
        LEFT JOIN Salary s 
            ON s.EmployeeID = ej.EmployeeID 
            AND s.EffectiveFrom >= ej.StartDate 
            AND (ej.EndDate IS NULL OR s.EffectiveFrom <= ej.EndDate)
        WHERE ej.EmployeeID = @EmployeeID
        ORDER BY ej.StartDate DESC;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
