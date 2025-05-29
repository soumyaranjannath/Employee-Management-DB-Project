/************************************************************************************
================================================================
Author			:	Soumyaranjan
Create date		:   2025-05-29
Description		:	View to get current Employee Salary
================================================================
Change log: Any modification to the View has to be reported here
Date		Name			Jira Ticket No		Description
2025-05-29  Soumyaranjan						Initial Version


************************************************************************************/
Create VIEW VW_CurrentEmployeeSalary AS
SELECT s.EmployeeID, s.BasicSalary, s.Bonus, s.EffectiveFrom
FROM Salary s
INNER JOIN (
    SELECT EmployeeID, MAX(EffectiveFrom) AS MaxDate
    FROM Salary
    GROUP BY EmployeeID
) latest ON s.EmployeeID = latest.EmployeeID AND s.EffectiveFrom = latest.MaxDate;
