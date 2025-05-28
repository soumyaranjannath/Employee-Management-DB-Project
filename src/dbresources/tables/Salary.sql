CREATE TABLE Salary (
    SalaryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    BasicSalary DECIMAL(10, 2) NOT NULL,
    Bonus DECIMAL(10, 2) NULL DEFAULT 0,
    EffectiveFrom DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);