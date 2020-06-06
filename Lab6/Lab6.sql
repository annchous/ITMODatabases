/* Examples */

/* 1 */
SELECT SalesOrderID, p.ProductID, ProductSubcategoryID,
OrderQty * UnitPrice, OrderQty * UnitPrice / SUM(OrderQty * UnitPrice)
OVER (PARTITION BY SalesOrderID, ProductSubcategoryID)
FROM Sales.SalesOrderDetail AS sod
INNER JOIN Production.Product AS p
ON sod.ProductID = p.ProductID

/* 2 */


/* Tasks */

/* 1 */
SELECT p.ProductID, OrderQty * UnitPrice / SUM(OrderQty * UnitPrice)
OVER (PARTITION BY SalesOrderID) AS "Share of sales"
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
ON sod.ProductID = p.ProductID

/* 2 */
SELECT p.ProductID, OrderQty * UnitPrice AS "Cost", 
(MAX(OrderQty * UnitPrice)
OVER (PARTITION BY p.ProductID, p.ProductSubcategoryID) -
MIN(OrderQty * UnitPrice)
OVER (PARTITION BY p.ProductID, p.ProductSubcategoryID)) AS "Difference"
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
ON sod.ProductID = p.ProductID

/* 3 */
SELECT CustomerID, SalesOrderID, (ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS "Row Number"
FROM Sales.SalesOrderHeader

/* 4 */

/* First Solution */
SELECT p.ProductID
FROM Production.Product AS p
WHERE p.ProductID IN
(SELECT p.ProductID
FROM Production.Product AS p 
JOIN Sales.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE sod.UnitPrice > 
(SELECT AVG(sod.UnitPrice) OVER(PARTITION BY p.ProductSubcategoryID)
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
ON sod.ProductID = p.ProductID))
AND p.ProductSubcategoryID IS NOT NULL

/* Second Solution */

/* 5 */
SELECT *
FROM Sales.SalesOrderDetail AS sod
JOIN Production.Product AS p
ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID

/* Test task */

/* Вывести на экран, для каждого продукта, количество его продаж, 
и соотношение числа покупателей этого продукта, к числу покупателей, 
купивших товары из категории, к которой относится данный товар */

SELECT DISTINCT p.ProductID,  COUNT(sod.SalesOrderID) OVER (PARTITION BY p.ProductID) AS "Sales count", CAST((COUNT(soh.CustomerID) OVER(PARTITION BY p.ProductID)) AS FLOAT) / CAST((COUNT(soh.CustomerID) OVER(PARTITION BY pc.ProductCategoryID)) AS FLOAT)
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesOrderDetail AS sod 
ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader AS soh 
ON sod.SalesOrderID = soh.SalesOrderID
