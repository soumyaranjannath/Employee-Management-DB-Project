
/************************************************************************************
================================================================
Author			:	Soumyaranjan
Create date		:   2025-05-29
Description		:	Procedure to Add New Employee 
================================================================
Change log: Any modification to the View has to be reported here
Date		Name			Jira Ticket No		Description
2025-05-29  Soumyaranjan						Initial Version


************************************************************************************/
CREATE PROCEDURE SP_AddNewEmployee
    @FirstName NVARCHAR(255),
    @LastName NVARCHAR(255),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(50),
    @HireDate DATE,
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Employee (FirstName, LastName, Email, Phone, HireDate, DepartmentID)
        VALUES (@FirstName, @LastName, @Email, @Phone, @HireDate, @DepartmentID);
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
