CREATE DATABASE EcommerceDB;
USE EcommerceDB;

CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50) NOT NULL,
  Email VARCHAR(50) UNIQUE,
  Phone VARCHAR(15) NOT NULL,
  City VARCHAR(30) 
);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY AUTO_INCREMENT,
  ProductName VARCHAR(50) NOT NULL,
  Price INT NOT NULL,
  Stock INT NOT NULL,
  Category VARCHAR(30)
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  OrderDate DATE,
  TotalAmount DECIMAL(10,2),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
  OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT,
  ProductID INT,
  Quantity INT NOT NULL,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE Payments (
  PaymentID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT,
  PaymentMethod VARCHAR(20),
  PaymentStatus VARCHAR(20),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
-- Customers_values
INSERT INTO Customers (Name, Email, Phone, City) VALUES
('Rahul', 'rahul@gmail.com', '9876543210', 'Saharanpur'),
('Priya', 'priya@gmail.com', '9876543211', 'Delhi'),
('Aman', 'aman@gmail.com', '9876543212', 'Dehradun'),
('Ujjwal', 'ujjwal@gmail.com', '9876543213', 'Saharanpur'),
('Neha', 'neha@gmail.com', '9876543214', 'Roorkee');

-- Products_values
INSERT INTO Products (ProductName, Price, Stock, Category) VALUES
('T-Shirt', 500, 100, 'Clothes'),
('Shoes', 1500, 50, 'Footwear'),
('Watch', 2000, 30, 'Accessories'),
('Jeans', 1200, 60, 'Clothes'),
('Headphones', 999, 40, 'Electronics');

-- Orders_value
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2026-11-20', 3000),
(2, '2026-11-21', 1500),
(3, '2026-11-22', 1200),
(4, '2026-11-22', 2999),
(5, '2026-11-23', 800);

-- Orderdetails_values
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(3, 4, 1),
(4, 5, 1);

-- values_of_Payments
INSERT INTO Payments (OrderID, PaymentMethod, PaymentStatus) VALUES
(1, 'UPI', 'Paid'),
(2, 'Cash on Delivery', 'Pending'),
(3, 'UPI', 'Paid'),
(4, 'Card', 'Paid'),
(5, 'UPI', 'Paid');



SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

-- INNER_JOIN
SELECT Customers.Name, Customers.City, Orders.OrderID, Orders.TotalAmount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- INNER_JOIN
SELECT Customers.Name, Products.ProductName, OrderDetails.Quantity, Products.Price
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID;

-- INNER_JOIN
SELECT Customers.Name, Orders.TotalAmount, Payments.PaymentMethod, Payments.PaymentStatus
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Payments ON Orders.OrderID = Payments.OrderID;

-- INNER_JOIN
SELECT Customers.Name, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 
SELECT SUM(TotalAmount) AS Total_Sales FROM Orders;

-- GROUP BY
SELECT City, COUNT(*) AS Total_Customers FROM Customers GROUP BY City;

-- ORDER BY
SELECT * FROM Products ORDER BY Price DESC LIMIT 1;

-- WHERE
SELECT * FROM Payments WHERE PaymentStatus = 'Pending';

-- SUB QUERY 
SELECT Name, City FROM Customers
WHERE CustomerID = (SELECT CustomerID FROM Orders ORDER BY TotalAmount DESC LIMIT 1);

-- SUB QUERY 
SELECT ProductName, Price FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- SUB QUERY 
SELECT Name FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders);