/************************************************************************************
================================================================
Author			:	Soumyaranjan
Create date		:   2025-05-29
Description		:	Procedure to Update Employee Salary
================================================================
Change log: Any modification to the View has to be reported here
Date		Name			Jira Ticket No		Description
2025-05-29  Soumyaranjan						Initial Version


************************************************************************************/
CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary Float,
    @Bonus Float = 0
AS
BEGIN
    BEGIN TRY
        INSERT INTO Salary (EmployeeID, BasicSalary, Bonus, EffectiveFrom)
        VALUES (@EmployeeID, @NewSalary, @Bonus, GETDATE());
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
