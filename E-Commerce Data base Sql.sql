-- 1️.Create Database
CREATE DATABASE ECommerceDB;
USE ECommerceDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers VALUES
(1,'Arun','Chennai','India'),
(2,'Priya','Coimbatore','India'),
(3,'Rahul','Bangalore','India'),
(4,'Sneha','Hyderabad','India'),
(5,'Karthik','Madurai','India'),
(6,'Divya','Salem','India'),
(7,'Vijay','Trichy','India'),
(8,'Anitha','Erode','India'),
(9,'Suresh','Tirunelveli','India'),
(10,'Meena','Vellore','India'),
(11,'Ravi','Mumbai','India'),
(12,'Pooja','Delhi','India'),
(13,'Ajay','Pune','India'),
(14,'Kavya','Mysore','India'),
(15,'Hari','Kochi','India'),
(16,'Nisha','Jaipur','India'),
(17,'Arvind','Lucknow','India'),
(18,'Deepa','Nagpur','India'),
(19,'Manoj','Patna','India'),
(20,'Asha','Bhopal','India');

INSERT INTO Products VALUES
(101,'Laptop','Electronics',50000),
(102,'Smartphone','Electronics',25000),
(103,'Headphones','Accessories',2000),
(104,'Keyboard','Accessories',1500),
(105,'Mouse','Accessories',800),
(106,'Tablet','Electronics',18000),
(107,'Smart Watch','Electronics',7000),
(108,'Printer','Electronics',12000),
(109,'Monitor','Electronics',10000),
(110,'USB Drive','Accessories',500),
(111,'Speaker','Accessories',3000),
(112,'Router','Electronics',2500),
(113,'Webcam','Accessories',2200),
(114,'Power Bank','Accessories',1500),
(115,'SSD','Electronics',4500),
(116,'External HDD','Electronics',6000),
(117,'Gaming Chair','Furniture',12000),
(118,'Office Desk','Furniture',15000),
(119,'Microphone','Accessories',3500),
(120,'Graphic Tablet','Electronics',8000);

INSERT INTO Orders VALUES
(1001,1,'2025-06-01'),
(1002,2,'2025-06-02'),
(1003,3,'2025-06-03'),
(1004,4,'2025-06-04'),
(1005,5,'2025-06-05'),
(1006,6,'2025-06-06'),
(1007,7,'2025-06-07'),
(1008,8,'2025-06-08'),
(1009,9,'2025-06-09'),
(1010,10,'2025-06-10'),
(1011,11,'2025-06-11'),
(1012,12,'2025-06-12'),
(1013,13,'2025-06-13'),
(1014,14,'2025-06-14'),
(1015,15,'2025-06-15'),
(1016,16,'2025-06-16'),
(1017,17,'2025-06-17'),
(1018,18,'2025-06-18'),
(1019,19,'2025-06-19'),
(1020,20,'2025-06-20');

INSERT INTO OrderDetails VALUES
(1,1001,101,1),
(2,1002,102,2),
(3,1003,103,3),
(4,1004,104,2),
(5,1005,105,5),
(6,1006,106,1),
(7,1007,107,2),
(8,1008,108,1),
(9,1009,109,2),
(10,1010,110,4),
(11,1011,111,2),
(12,1012,112,1),
(13,1013,113,3),
(14,1014,114,2),
(15,1015,115,1),
(16,1016,116,2),
(17,1017,117,1),
(18,1018,118,1),
(19,1019,119,2),
(20,1020,120,1);

-- SELECT, WHERE, ORDER BY, GROUP BY
SELECT * FROM Customers;

-- where
SELECT * FROM Products
WHERE Price > 2000;

-- orderby
SELECT * FROM Products
ORDER BY Price DESC; 

-- Group by
SELECT Category,
COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

-- b) JOINS
-- INNER JOIN
SELECT C.CustomerName,
O.OrderID,
O.OrderDate
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID; 

-- Left Join
SELECT C.CustomerName,
O.OrderID
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID;

-- Right Join
SELECT C.CustomerName,
O.OrderID
FROM Customers C
RIGHT JOIN Orders O
ON C.CustomerID = O.CustomerID; 

-- Sup query
SELECT CustomerName
FROM Customers
WHERE CustomerID IN
(
SELECT CustomerID
FROM Orders
); 

-- d) Aggregate Functions
-- SUM
SELECT SUM(P.Price * OD.Quantity) AS TotalSales
FROM Products P
JOIN OrderDetails OD
ON P.ProductID = OD.ProductID; 

-- Avg 
SELECT AVG(Price) AS AveragePrice
FROM Products; 

-- Count
SELECT COUNT(*) AS TotalCustomers
FROM Customers; 

-- Max
SELECT MAX(Price) AS HighestPrice
FROM Products; 

-- Create View
CREATE VIEW SalesAnalysis AS
SELECT
O.OrderID,
C.CustomerName,
P.ProductName,
OD.Quantity,
(P.Price * OD.Quantity) AS TotalAmount
FROM Orders O
JOIN Customers C
ON O.CustomerID = C.CustomerID
JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID; 

SELECT * FROM SalesAnalysis; 

-- f) Optimize Queries with Indexes
CREATE INDEX idx_customer
ON Orders(CustomerID);

CREATE INDEX idx_product
ON OrderDetails(ProductID);