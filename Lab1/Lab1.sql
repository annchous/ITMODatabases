SELECT COUNT(*) as Colors
FROM Production.Product
WHERE Color is not NULL

SELECT MAX(ListPrice)
FROM Production.Product
WHERE Color = 'Red'

SELECT Name
FROM Production.ProductCategory
WHERE ProductCategoryID in (1,3,7)

SELECT Color, COUNT(*) as 'Amount'
FROM Production.Product
WHERE Color is not NULL
GROUP BY Color

SELECT Name, Color, COUNT(*) as 'Amount'
FROM Production.Product
WHERE Color is not NULL
GROUP BY Color

SELECT Color, Style, COUNT(*) as 'Amount'
FROM Production.Product
WHERE Color is not NULL AND Style is not NULL
GROUP BY Color, Style

SELECT Color, COUNT(*) as 'Amount'
FROM Production.Product
WHERE Color is not NULL
GROUP BY Color
HAVING COUNT(*) > 10

SELECT Color, COUNT(*) as 'Amount'
FROM Production.Product
WHERE Color is not NULL
GROUP BY Color
HAVING COUNT(*) > 10 AND MAX(ListPrice) > 3000

SELECT Color, Style, Class, COUNT(*) as 'Amount'
FROM Production.Product
GROUP BY ROLLUP (Color, Style, Class)

SELECT Color, Style, Class, COUNT(*) as 'Amount'
FROM Production.Product
GROUP BY Color, Style, Class

SELECT TOP 3 WITH TIES ProductSubcategoryID
FROM Production.Product
WHERE ProductSubcategoryID is not NULL
GROUP BY ProductSubcategoryID
ORDER BY COUNT(*) DESC

SELECT len(Name) as 'Длина', COUNT(*) as 'Количество'
FROM Production.Product
GROUP BY len(Name)

SELECT Name
FROM Production.Product
GROUP BY ProductID, Name
HAVING COUNT(*) > 1

SELECT COUNT(*)
FROM Production.Product
WHERE ListPrice > 30
GROUP BY Color

SELECT Color, COUNT(*)
FROM Production.Product
WHERE ListPrice > 100
GROUP BY Color

SELECT ProductSubcategoryID, COUNT (*)
FROM Production.Product
WHERE ListPrice > 100
GROUP BY Color
