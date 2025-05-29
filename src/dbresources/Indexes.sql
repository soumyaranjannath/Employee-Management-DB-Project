CREATE UNIQUE INDEX IDX_Employee_Email ON Employee(Email);

CREATE INDEX IDX_Salary_EffectiveFrom ON Salary(EmployeeID, EffectiveFrom DESC);

CREATE INDEX IDX_Employee_Dept ON Employee(DepartmentID);
