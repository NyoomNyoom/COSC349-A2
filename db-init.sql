DROP TABLE IF EXISTS lollies;
DROP TABLE IF EXISTS CustomerOrders;
DROP TABLE IF EXISTS employees;

CREATE TABLE lollies(
    prodID varchar(7) NOT NULL,
    prodName varchar(50) NOT NULL,
    prodPrice decimal(5,2) NOT NULL,
    prodimage varchar(50) NOT NULL,
    PRIMARY KEY (prodID)
);

CREATE TABLE CustomerOrders (
    orderID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    custFname VARCHAR(50) NOT NULL,
    custLname VARCHAR(50) NOT NULL,
    custEmail VARCHAR(100) NOT NULL,
    custPhone VARCHAR(20) NOT NULL,
    custAddress VARCHAR(100) NOT NULL,
    custOrder VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    EmployeeID INT NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Pword VARCHAR(50) NOT NULL
);

INSERT INTO lollies (prodID, prodName, prodimage, prodPrice)
VALUES ('L001', 'Warheads cubes', 'product-images/Warheads-Cubes.jpg', 1.20);

INSERT INTO CustomerOrders (custFname, custLname, custEmail, custPhone, custAddress, custOrder)
VALUES (
    'John',
    'Smith',
    'john@smith.com',
    '0277777777',
    '123 Fake Street',
    'Sour warheads x2, nerds rope x3, sour patch kids x1, sour skittles x1, Mystery bag x1'
);

INSERT INTO employees (EmployeeID, FirstName, LastName, Pword)
VALUES (1, 'John', 'Smith', 'password');