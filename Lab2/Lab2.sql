/* Examples */
SELECT Color, Style, Class, COUNT(*) as 'Amount'
FROM Production.Product
GROUP BY Color, Style, Class

SELECT Color, Style, Class, COUNT(*) as 'Amount'
FROM Production.Product
GROUP BY ROLLUP (Color, Style, Class)

SELECT Color, Style, Class, COUNT(*)
FROM Production.Product
GROUP BY CUBE (Color, Style, Class)

SELECT COUNT(*)
FROM Production.Product
GROUP BY GROUPING SETS((Color), (Size))

SELECT TOP 3 WITH TIES ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
ORDER BY COUNT(*) DESC

SELECT LEN(Name) as 'Length', COUNT(*) as 'Amount'
From Production.Product
GROUP BY LEN(Name)

SELECT Name
FROM Production.Product
GROUP BY ProductID, Name
HAVING COUNT(*) > 1

/* Tasks */
SELECT Color, COUNT(*)
FROM Production.Product
WHERE ListPrice >= 30
GROUP BY Color

SELECT Color, COUNT(*)
FROM Production.Product
GROUP BY Color
HAVING MIN(ListPrice) > 100

SELECT ProductSubcategoryID as 'Name', COUNT(*) as 'Amount'
FROM Production.Product
GROUP BY ProductSubcategoryID

SELECT ProductID, COUNT(*)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID ASC

SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(*) > 5
ORDER BY ProductID ASC

SELECT CustomerID
FROM Sales.SalesOrderHeader
GROUP BY OrderDate, CustomerID
HAVING COUNT(SalesOrderID) > 1
ORDER BY OrderDate ASC, CustomerID ASC

SELECT SalesOrderID
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(ProductID) > 3
ORDER BY SalesOrderID ASC

SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(SalesOrderID) > 3
ORDER BY ProductID ASC

SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(SalesOrderID) in (3, 5)
ORDER BY ProductID ASC

SELECT ProductSubcategoryID
FROM Production.ProductSubcategory
GROUP BY ProductSubcategoryID
HAVING COUNT(Name) > 10
ORDER BY ProductSubcategoryID ASC

SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID, OrderQty
HAVING MAX(OrderQty) = 1 AND OrderQty is NOT NULL
ORDER BY ProductID ASC

SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING MAX(OrderQty) = 1
ORDER BY ProductID ASC

SELECT TOP 1 SalesOrderID, COUNT(*) as 'Count'
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY COUNT(*) DESC

SELECT TOP 1 SalesOrderID, OrderQty as 'Count', UnitPrice as 'Price', OrderQty * UnitPrice as 'Sum'
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID, OrderQty, UnitPrice
ORDER BY OrderQty * UnitPrice DESC

SELECT COUNT(*)
FROM Production.Product
GROUP BY ProductSubcategoryID, Color
HAVING (ProductSubcategoryID is NOT NULL) AND (Color is NOT NULL)
ORDER BY COUNT(*) DESC

SELECT Color, COUNT(*) as 'Count'
FROM Production.Product
GROUP BY Color
ORDER BY COUNT(*) DESC

SELECT ProductID
FROM Sales.SalesOrderDetail
WHERE OrderQty > 1
GROUP BY ProductID
HAVING COUNT(*) > 2
ORDER BY ProductID ASC