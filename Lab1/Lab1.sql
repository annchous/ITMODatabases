SELECT Name, Color, Size
FROM Production.Product

SELECT Name, Color, Size
FROM Production.Product
WHERE ListPrice > 100

SELECT Name, Color, Size
FROM Production.Product
WHERE ListPrice < 100 AND Color = 'Black'

SELECT Name, Color, Size
FROM Production.Product
WHERE ListPrice < 100 AND Color = 'Black'
ORDER BY ListPrice ASC

SELECT TOP 3 Name, Size
FROM Production.Product
WHERE Color = 'Black'
ORDER BY ListPrice DESC

SELECT Name, Color
FROM Production.Product
WHERE Color is NOT NULL AND Size is NOT NULL

SELECT DISTINCT Color
FROM Production.Product
WHERE ListPrice BETWEEN 10 AND 50

SELECT Color
FROM Production.Product
WHERE Name like 'L_N%'

SELECT Name
FROM Production.Product
WHERE Name like '[MD]___%'

SELECT Name
FROM Production.Product
WHERE DATEPART(YEAR, SellStartDate) < 2013

SELECT Name
FROM Production.ProductSubcategory

SELECT Name
FROM Production.ProductCategory

SELECT FirstName
FROM Person.Person
WHERE Title = 'Mr.'

SELECT FirstName
FROM Person.Person
WHERE Title is NULL

