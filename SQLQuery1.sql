
CREATE TABLE SalesFact (
    Id INT Not Null IDENTITY Primary key ,
    OrderNumber INT,
    StoreID INT,
    RepID INT,
    ProductID INT,
    Sold INT,
    Revenue DECIMAL(18, 2),
    ReturnedReason NVARCHAR(255),
    TransactionTime DATETIME,
     )

 
CREATE TABLE StoresDim (
StoreID INT PRIMARY KEY,
StoreName NVARCHAR(255),
Region NVARCHAR(255))
	
CREATE TABLE RepsDim (
    RepID INT PRIMARY KEY,
    RepName NVARCHAR(255))

CREATE TABLE ProductsDim (
    ProductID INT PRIMARY KEY,
    ProductCode NVARCHAR(255),
    Description NVARCHAR(255),
	Category nvarchar(255),
	subcategory nvarchar(255),
	Brand nvarchar(255)
	)

	CREATE TABLE DateDim (
    DateKey INT PRIMARY KEY,
    DateValue DATEtime,
    Day INT,
    Month INT,
    MonthName VARCHAR(20),
    Quarter INT,
    Year INT,
    DayOfWeek INT,
    DayName VARCHAR(20))

	DECLARE @StartDate DATETime = '2023-02-01'
DECLARE @EndDate DATETime = '2023-5-31'
DECLARE @Date DATE = @StartDate

WHILE @Date <= @EndDate
BEGIN
    INSERT INTO DateDim (DateKey, DateValue, Day, Month, MonthName, Quarter, Year, DayOfWeek, DayName)
    VALUES (
        CONVERT(INT, REPLACE(CONVERT(VARCHAR, @Date, 112), '-', '')), -- DateKey in format YYYYMMDD
        @Date,
        DAY(@Date),
        MONTH(@Date),
        DATENAME(MONTH, @Date),
        DATEPART(QUARTER, @Date),
        YEAR(@Date),
        DATEPART(WEEKDAY, @Date),
        DATENAME(WEEKDAY, @Date)
    )

    SET @Date = DATEADD(DAY, 1, @Date)
END

ALTER TABLE Datedim
add Id Int 


UPDATE DateDim
SET DateDim.id = SalesFact.id
FROM DateDim
JOIN SalesFact ON CAST(DateDim.DateValue AS DATE) = CAST(SalesFact.TransactionTime AS DATE)




