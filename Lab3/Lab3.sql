/* Examples */
SELECT p.Name, s.Name
FROM Production.Product p INNER JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM Production.Product p LEFT JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM Production.Product p RIGHT JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM Production.Product p FULL OUTER JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p1.Name
FROM Production.Product p1 JOIN Production.Product p2
ON p1.Name = p2.Name
AND p1.ProductID != p2.ProductID

SELECT P.Name, PSC.Name
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE ListPrice > 100

SELECT P.Name, PSC.Name
FROM Production.Product AS P
LEFT JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE ListPrice > 100

SELECT P.Name, PC.Name
FROM Production.Product AS P 
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID

SELECT P.Name, P.ListPrice, PV.LastReceiptCost
FROM Production.Product AS P
INNER JOIN Purchasing.ProductVendor AS PV
ON P.ProductID = PV.ProductID

SELECT P.Name, P.ListPrice, PV.LastReceiptCost
FROM Production.Product AS P
INNER JOIN Purchasing.ProductVendor AS PV
ON P.ProductID = PV.ProductID
WHERE P.ListPrice != 0 
AND P.ListPrice < PV.LastReceiptCost

SELECT COUNT(DISTINCT PV.ProductID)
FROM Purchasing.ProductVendor AS PV
INNER JOIN Purchasing.Vendor AS V
ON PV.VendorID = V.VendorID
WHERE CreditRating = 1

SELECT CreditRating, COUNT(DISTINCT PV.ProductID)
FROM Purchasing.ProductVendor AS PV
INNER JOIN Purchasing.Vendor AS V
ON PV.VendorID = V.VendorID
GROUP BY CreditRating

SELECT TOP 3 ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
ORDER BY COUNT(*) DESC

SELECT TOP 3 PC.ProductCategoryID
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.ProductCategoryID
ORDER BY COUNT(*) DESC

SELECT TOP 3 PSC.Name, COUNT(*)
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID, PSC.Name
ORDER BY COUNT(*) DESC

SELECT 1.0 * COUNT(*) / COUNT(DISTINCT ProductSubcategoryID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

SELECT CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT ProductSubcategoryID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

SELECT CAST((CAST(COUNT(p.ProductID) AS FLOAT) / COUNT(DISTINCT p.ProductSubcategoryID))
AS DECIMAL(6, 3))
FROM Production.Product AS p
WHERE p.ProductSubcategoryID IS NOT NULL

SELECT COUNT(*) / COUNT(DISTINCT PC.ProductCategoryID)
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
RIGHT JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID

SELECT COUNT(DISTINCT Color)
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
RIGHT JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.ProductCategoryID

/* Tasks */

/* 1 */
SELECT P.Name, PC.Name
FROM Production.Product AS P 
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
WHERE P.Color like 'Red' AND P.ListPrice >= 100

/* 2 */
SELECT PSC.Name
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.Name = PSC.Name
INNER JOIN Production.ProductCategory AS PC
ON PSC.Name = PC.Name

/* 3 */
SELECT PC.Name, COUNT(*)
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.Name

/* 4 */
SELECT DISTINCT PSC.Name, COUNT(*)
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
GROUP BY PSC.Name

/* 5 */
SELECT TOP 3 PSC.Name
FROM Production.Product AS P
INNER JOIN Production.Product AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
GROUP BY PSC.Name
ORDER BY COUNT(*) DESC

/* 6 */
SELECT PSC.Name, MAX(ListPrice)
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE Color like 'Red'
GROUP BY PSC.Name

/* 7 */
SELECT V.Name, COUNT(*)
FROM Production.Product AS P
INNER JOIN Purchasing.ProductVendor AS PV
ON P.ProductID = PV.ProductID
INNER JOIN Purchasing.Vendor AS V
ON PV.VendorID = V.VendorID
GROUP BY V.Name

/* 8 */
SELECT P.Name
FROM Purchasing.ProductVendor AS PV
INNER JOIN Production.Product AS P
ON P.ProductID = PV.ProductID
GROUP BY P.Name
HAVING COUNT(*) > 1

/* 9 */ 
SELECT TOP 1 P.Name
FROM Purchasing.ProductVendor AS PV
INNER JOIN Production.Product AS P
ON P.ProductID = PV.ProductID
GROUP BY P.Name
ORDER BY COUNT(*) DESC

/* 10 */
SELECT PC.Name
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PSC.ProductCategoryID
GROUP BY PC.Name, PC.ProductCategoryID
ORDER BY COUNT(*) ASC

/* 11 */
SELECT PC.Name, COUNT(PSC.Name), COUNT(P.Name)
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY PC.Name

/* 12 */
