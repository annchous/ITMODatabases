/* Examples */
SELECT Name
FROM Production.Product
WHERE Color = 'Red' AND ListPrice =
(SELECT MAX(ListPrice)
FROM Production.Product
WHERE Color = 'Red')

SELECT Name
FROM Production.Product
WHERE Color != 'Red' AND ListPrice = ANY
(SELECT ListPrice
FROM Production.Product
WHERE Color = 'Red')

SELECT Name
FROM Production.Product
WHERE ListPrice > ALL
(SELECT ListPrice
FROM Production.Product
WHERE Color = 'Red')

SELECT Name
FROM Production.Product
WHERE Color IN
(SELECT Color
FROM Production.Product
WHERE ListPrice > 3000)

SELECT Name
FROM Production.ProductCategory
WHERE ProductCategoryID IN
(SELECT ProductCategoryID
FROM Production.ProductSubcategory
WHERE ProductSubcategoryID IN
(SELECT ProductSubcategoryID
FROM Production.Product
WHERE ListPrice = 
(SELECT MAX(ListPrice)
FROM Production.Product)))

SELECT Name
FROM Production.Product
WHERE Color IN
(SELECT Color
FROM Production.Product
WHERE ListPrice = 
(SELECT MAX(ListPrice)
FROM Production.Product))
AND Style IN
(SELECT Style
FROM Production.Product
WHERE ListPrice = 
(SELECT MAX(ListPrice)
FROM Production.Product))

SELECT ProductSubcategoryID
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING COUNT(*) =
(SELECT TOP 1 COUNT(*)
FROM Production.Product
GROUP BY ProductSubcategoryID
ORDER BY 1 DESC)

SELECT Name
FROM Production.Product AS P1
WHERE ListPrice =
(SELECT MAX(ListPrice)
FROM Production.Product AS P2
WHERE P1.ProductSubcategoryID = P2.ProductSubcategoryID)

SELECT Name,
(SELECT Name
FROM Production.ProductSubcategory AS PS
WHERE P1.ProductSubcategoryID = PS.ProductSubcategoryID)
FROM Production.Product AS P1

SELECT Name
FROM Production.Product
WHERE ProductSubcategoryID IN
(SELECT ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING COUNT(*) = 
(SELECT TOP 1 COUNT(*) 
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
ORDER BY 1 DESC))

SELECT CustomerID, COUNT(*)
FROM Sales.SalesOrderHeader AS SOH1
GROUP BY CustomerID
HAVING COUNT(*) > 1 AND COUNT(*) = ALL
(SELECT COUNT(*)
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID, SOD.ProductID
HAVING SOH.CustomerID = SOH1.CustomerID)

SELECT p.ProductID,
(SELECT COUNT(DISTINCT SOH.CustomerID)
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOD.ProductID = p.ProductID),
(SELECT COUNT(DISTINCT SOH.CustomerID)
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.CustomerID NOT IN
(SELECT DISTINCT SOH.CustomerID
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOD.ProductID = p.ProductID))
FROM Production.Product AS p

SELECT Name
FROM Production.Product
WHERE ProductID IN
(SELECT SOD.ProductID
FROM Sales.SalesOrderDetail AS SOD
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.CustomerID IN
(SELECT SOH.CustomerID
FROM Sales.SalesOrderDetail AS SOD
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN Production.Product AS P
ON SOD.ProductID = P.ProductID
GROUP BY SOH.CustomerID
HAVING COUNT(DISTINCT P.ProductSubcategoryID) = 1)
GROUP BY SOD.ProductID
HAVING COUNT(DISTINCT SOH.CustomerID)>1)

SELECT DISTINCT CustomerID
FROM Sales.SalesOrderHeader
WHERE CustomerID NOT IN
(SELECT SOH.CustomerID
FROM Sales.SalesOrderDetail AS SOD
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE EXISTS
(SELECT ProductID
FROM Sales.SalesOrderDetail AS SOD1
JOIN Sales.SalesOrderHeader AS SOH1
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH1.CustomerID = SOH.CustomerID
AND SOD1.ProductID = SOD.ProductID
AND SOD.SalesOrderID != SOD1.SalesOrderID))

SELECT DISTINCT SOH.CustomerID
FROM Sales.SalesOrderHeader AS SOH
WHERE SOH.CustomerID NOT IN
(SELECT DISTINCT SOH.CustomerID
FROM Sales.SalesOrderDetail AS SOD
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE ProductID NOT IN
(SELECT SOD.ProductID
FROM Sales.SalesOrderDetail AS SOD
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID
HAVING COUNT(DISTINCT SOH.CustomerID) = 1))
/* Tasks */

/* 1 */
SELECT Name
FROM Production.Product
WHERE ProductID =
(SELECT TOP 1 ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY COUNT(SalesOrderID) DESC)

/* 2 */
SELECT CustomerID
FROM Sales.SalesOrderHeader
WHERE SalesOrderID =
(SELECT SalesOrderID
FROM Sales.SalesOrderDetail
WHERE UnitPrice * OrderQty = 
(SELECT TOP 1 UnitPrice * OrderQty
FROM Sales.SalesOrderDetail
ORDER BY 1 DESC))

/* 3 */
SELECT Name
FROM Production.Product
WHERE ProductID IN
(SELECT SOD.ProductID
FROM Sales.SalesOrderDetail AS SOD
JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID
HAVING COUNT(DISTINCT SOH.CustomerID) = 1)

/* 4 */
SELECT Name
FROM Production.Product AS P1
WHERE ListPrice >
(SELECT AVG(ListPrice)
FROM Production.Product AS P2
WHERE P1.ProductSubcategoryID = P2.ProductSubcategoryID)

/* 5 */
select od.ProductIDfrom [Sales].[SalesOrderDetail] as odjoin[Sales].[SalesOrderHeader] ohonod.SalesOrderID=oh.SalesOrderIDwhere oh.CustomerID in (select oh.CustomerIDfrom [Production].[Product] as pjoin [Sales].[SalesOrderDetail] as odonp.productid=od.ProductIDjoin[Sales].[SalesOrderHeader] ohonod.SalesOrderID=oh.SalesOrderIDgroup by oh.CustomerIDhaving count(distinct p.Color)=1)and od.ProductID not in (select od.ProductIDfrom  [Sales].[SalesOrderDetail] as od join[Sales].[SalesOrderHeader] ohonod.SalesOrderID=oh.SalesOrderIDwhere oh.CustomerID in(select oh.CustomerIDfrom [Production].[Product] as pjoin [Sales].[SalesOrderDetail] as odonp.productid=od.ProductIDjoin[Sales].[SalesOrderHeader] ohonod.SalesOrderID=oh.SalesOrderIDgroup by oh.CustomerIDhaving count(distinct p.Color)=2))group by od.ProductIDhaving count(distinct oh.CustomerID)>1

SELECT *
FROM Production.Product

/* 6 */
SELECT Name
FROM Production.Product
WHERE ProductID IN
(SELECT P.ProductID
FROM Production.Product AS P
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOD.ProductID = P.ProductID
GROUP BY P.ProductID
HAVING COUNT(*) = ALL
(SELECT COUNT(*)
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.CustomerID, SOD.ProductID))

/* 7 */

SELECT *
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOD.ProductID

/* 12 */

/* 13 */
SELECT Name
FROM Production.ProductSubcategory AS PS1
WHERE PS1.ProductSubcategoryID IN 
(SELECT PS.ProductSubcategoryID
FROM Production.ProductSubcategory AS PS
INNER JOIN Production.Product AS P
ON PS.ProductSubcategoryID = P.ProductSubcategoryID
WHERE P.ProductID IN
(SELECT ProductID
FROM Production.Product
GROUP BY ProductID
HAVING COUNT(*) > 3))
AND PS1.ProductSubcategoryID IN
(SELECT ProductSubcategoryID
FROM Production.Product
WHERE ProductID IN 
(SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(*) > 3))

/* 14 */
SELECT Name
FROM Production.Product
WHERE ProductID IN 
(SELECT ProductID
FROM Sales.SalesOrderDetail AS SOD
GROUP BY SOD.ProductID
HAVING COUNT(*) <= 3)
AND ProductID IN (SELECT ProductID
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID
HAVING COUNT(DISTINCT SOH.CustomerID) >= 2)

SELECT PC.Name
FROM Production.ProductCategory AS PC
WHERE PC.ProductCategoryID =
(SELECT TOP 1 PC.ProductCategoryID
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PS.ProductCategoryID = PC.ProductCategoryID
WHERE PC.ProductCategoryID IS NOT NULL
GROUP BY PC.ProductCategoryID
ORDER BY COUNT(*) DESC)

SELECT PC.Name
FROM Production.ProductCategory AS PC
WHERE PC.ProductCategoryID =
(SELECT PS.ProductCategoryID
FROM Production.ProductSubcategory AS PS
WHERE PS.ProductSubcategoryID =
(SELECT TOP 1 P.ProductSubcategoryID
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID
HAVING COUNT(*) =
(SELECT TOP 1 COUNT(*)
FROM Production.Product AS P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID
ORDER BY COUNT(*) DESC)))