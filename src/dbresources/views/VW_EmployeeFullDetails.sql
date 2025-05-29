/************************************************************************************
================================================================
Author			:	Soumyaranjan
Create date		:   2025-05-29
Description		:	View to get Employee Full Details
================================================================
Change log: Any modification to the View has to be reported here
Date		Name			Jira Ticket No		Description
2025-05-29  Soumyaranjan						Initial Version


************************************************************************************/

Create VIEW VW_EmployeeFullDetails AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Email,
    e.Phone,
    e.HireDate,
    d.DepartmentName,
    j.JobTitle
FROM Employee e
INNER JOIN Department d ON e.DepartmentID = d.DepartmentID
LEFT JOIN EmployeeJob ej ON e.EmployeeID = ej.EmployeeID AND ej.EndDate IS NULL
LEFT JOIN Job j ON ej.JobID = j.JobID;


