/* Task 1 */
SELECT ProductID
FROM Sales.SalesOrderDetail 
GROUP BY ProductID
HAVING COUNT(SalesOrderID) > 3

/* Task 2 */
SELECT Color, COUNT(*) as 'Count'
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) BETWEEN 2 AND 5

/* Task 3 */
SELECT ProductSubcategoryID
FROM Production.Product
GROUP BY ProductSubcategoryID, Color
HAVING COUNT(Color) > 1 AND Color = 'Red'

/* Task 4 */
SELECT ProductID, COUNT(OrderQty)
FROM Sales.SalesOrderDetail
GROUP BY ProductID, OrderQty, UnitPrice
HAVING COUNT(OrderQty) > 3 AND UnitPrice > 100

/* Task 5 */
SELECT Size
FROM Production.Product
GROUP BY Size, Color
HAVING Color = 'Red'
ORDER BY COUNT(*) DESC

/* Task 6 */
SELECT Size
FROM Production.Product
GROUP BY Size
HAVING COUNT(*) > 10

/* Task 7 */
SELECT TOP 1 ProductID, COUNT(*) AS 'Count'
FROM Sales.SalesOrderDetail
GROUP BY ProductID, UnitPrice
HAVING UnitPrice <= 100

/* Task 8 */
SELECT TOP 1 ProductSubcategoryID
FROM Production.Product
GROUP BY ProductSubcategoryID
ORDER BY COUNT(DISTINCT[Color]) DESC

/* Task 9 */
SELECT ProductID
FROM Sales.SalesOrderDetail
WHERE OrderQty < 3
GROUP BY ProductID
HAVING COUNT(DISTINCT[SalesOrderID]) > 3

/* Task 10 */
SELECT TOP 1 ProductCategoryID, COUNT(ProductSubcategoryID) AS 'Count'
FROM Production.ProductSubcategory
GROUP BY ProductCategoryID
ORDER BY COUNT(ProductSubcategoryID) DESC 

/* Task 11 */
SELECT ProductSubcategoryID, COUNT(*) AS 'Count'
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING COUNT(*) > 5

/* Task 12 */
SELECT ProductSubcategoryID, COUNT(*) AS 'Count'
FROM Production.Product
GROUP BY ProductSubcategoryID, Color
HAVING COUNT(*) > 5 AND Color = 'Red'
