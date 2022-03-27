USE HoltDistributors;
go


--1.
INSERT into Customer
		(CustomerNumber, FName, LName, Address1, Address2, City, State, ZipCode, PhoneNum, MTDSales, YTDSales, CurrentBalance, CreditLimit, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZipCode, CurrentInvoiceTotal, CurrentPaymentTotal, CurrentAmount, Over30, Over60, Over90, PreviousBalance, EmployeeID)
	values
		(12345, 'Mary', 'Poppins', '123 W Main St', '', 'Detroit', 'MI', '45678', '414-777-7777', 2500.00, 35000.00, 3238.45, 5000.00, 'Mary Poppins', '123 W Main St', '', 'Detroit', 'MI', '45678', 120.00, 240.00,255.00, 125.00, 333.00, 803.00, 190.00, 1287456);

--2.
UPDATE Customer
SET Fname = Michelle
WHERE CustomerNumber = 12345;

--3.
UPDATE Customer
SET City = Milwaukee, ZipCode = 53201
WHERE CustomerNumber = 12345;

--4.
DELETE from Customer
WHERE CustomerNumer = 12345;

--5.
UPDATE SalesRep
SET CommissionRate = 0.17;

--6.
ALTER TABLE Vendor
ADD [Status] INT CHECK ([Status] BETWEEN 0 and 10);

--7.
SELECT FName, LName, PhoneNum
FROM Customer
ORDER BY LName ASC;

--8.
SELECT LName, FName
FROM Customer
WHERE CreditLimit > 799;

--9.
SELECT OrderNumber
FROM Orders
WHERE CustomerNumber = 124 and OrderDate = '12-01-00';

--10.
SELECT PartNumber, PartDesc, UnitPrice
FROM Part
WHERE ReorderPoint > 10;

--11.
SELECT CustomerNumber, LName + ', ' + FName AS [Name]
FROM Customer
WHERE FName LIKE 'S%';

--12.
SELECT PartNumber, PartDesc, UnitsOnHand
FROM Part
WHERE UnitsOnHand > (SELECT avg(UnitsOnHand)
					FROM Part);

--13.
SELECT max(UnitPrice)
FROM Part;
/*This is a trick question because the only item in the database 
is the one that I inserted for Part 1 of the Final Project which 
is the Robot 3000 with a Unit Price of $50.00. 
So that is the most expensive item in the database.*/

--14.
SELECT COUNT(*) 
FROM Customer;
/*Technically there is only one customer in the database 
because I inserted one during Part 1 of the final project, 
and in the above exercises I inserted another which would make two customers, 
however I removed that customer above in exercise # 4.*/

--15.
SELECT EmployeeID, sum(CurrentBalance)
FROM Customer
GROUP BY EmployeeID;

--16.
SELECT Orders.OrderNumber, Orders.OrderDate, Customers.FName, Customers.LName
FROM Orders
INNER JOIN Customers ON Orders.CustomerNumber=Customers.CustomerNumber
WHERE Orders.OrderDate = '12/22/02';

--17.
SELECT Orders.OrderNumber, Orders.OrderDate, OrderDetail.PartNumber, Part.PartDesc, OrderDetail.NumberOrdered
FROM Orders, OrderDetail, Part
WHERE Orders.OrderNumber = OrderDetail.OrderNumber and OrderDetail.PartNumber = Part.PartNumber
ORDER BY OrderNumber ASC;

--18.
SELECT PartNumber, PartDesc, UnitPrice, UnitsOnHand
FROM Part
WHERE ANY (SELECT UnitPrice
			FROM Part
			WHERE UnitsOnHand > 0);

--19.
SELECT EmployeeID, EmpName
FROM Employee
WHERE EmployeeID IN (SELECT EmployeeID 
					  FROM Customer 
					  WHERE CreditLimit > 2000);

