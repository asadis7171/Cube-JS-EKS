CREATE DATABASE IF NOT EXISTS employee;
USE employee;

CREATE TABLE IF NOT EXISTS Department (
    DeptId integer PRIMARY KEY,
    DeptName varchar(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Employee (
    EmpId integer PRIMARY KEY,
    FirstName varchar(20),
    LastName varchar(20),
    Email varchar(45),
    PhoneNo varchar(25),
    Salary integer
);

CREATE TABLE IF NOT EXISTS EmployeeDepartment (
    EmpId integer,
    DeptId integer,
    PRIMARY KEY (EmpId, DeptId),
    FOREIGN KEY (EmpId) REFERENCES Employee(EmpId),
    FOREIGN KEY (DeptId) REFERENCES Department(DeptId)
);

INSERT INTO Department (DeptId, DeptName)
VALUES
    (1, 'Human Resources'),
    (2, 'Marketing'),
    (3, 'Finance'),
    (4, 'Information Technology'),
    (5, 'Operations');

INSERT INTO Employee (EmpId, FirstName, LastName, Email, PhoneNo, Salary)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '555-1234', 50000),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '555-5678', 60000),
    (3, 'Bob', 'Johnson', 'bob.johnson@example.com', '555-9876', 55000),
    (4, 'Alice', 'Williams', 'alice.williams@example.com', '555-4321', 65000),
    (5, 'Michael', 'Jones', 'michael.jones@example.com', '555-8765', 70000),
    (6, 'Emily', 'Brown', 'emily.brown@example.com', '555-2345', 55000),
    (7, 'David', 'Taylor', 'david.taylor@example.com', '555-7890', 60000),
    (8, 'Grace', 'Miller', 'grace.miller@example.com', '555-3456', 75000),
    (9, 'Andrew', 'Anderson', 'andrew.anderson@example.com', '555-6789', 60000),
    (10, 'Sophia', 'Moore', 'sophia.moore@example.com', '555-2109', 55000),
    (11, 'Robert', 'Johnson', 'robert.johnson@example.com', '555-5432', 65000),
    (12, 'Olivia', 'Davis', 'olivia.davis@example.com', '555-8765', 70000),
    (13, 'James', 'Thomas', 'james.thomas@example.com', '555-4321', 50000),
    (14, 'Ava', 'White', 'ava.white@example.com', '555-7890', 75000),
    (15, 'Matthew', 'Moore', 'matthew.moore@example.com', '555-1234', 60000),
    (16, 'Emma', 'Clark', 'emma.clark@example.com', '555-5678', 55000),
    (17, 'Daniel', 'Walker', 'daniel.walker@example.com', '555-9876', 65000),
    (18, 'Sophie', 'Lewis', 'sophie.lewis@example.com', '555-2345', 70000),
    (19, 'Ryan', 'Parker', 'ryan.parker@example.com', '555-6789', 50000),
    (20, 'Isabella', 'Hall', 'isabella.hall@example.com', '555-3456', 60000);

INSERT INTO EmployeeDepartment (EmpId, DeptId)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 1),
    (7, 2),
    (8, 3),
    (9, 4),
    (10, 5),
    (11, 1),
    (12, 2),
    (13, 3),
    (14, 4),
    (15, 5),
    (16, 1),
    (17, 2),
    (18, 3),
    (19, 4),
    (20, 5);
