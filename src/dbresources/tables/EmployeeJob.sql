CREATE TABLE EmployeeJob (
    EmployeeJobID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    JobID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);