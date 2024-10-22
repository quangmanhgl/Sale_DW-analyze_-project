USE [retail_project]
Create Schema sales

---- dim_customer
CREATE TABLE Dim_Customer (
    cust_id INT NOT NULL ,
    First_Name VARCHAR(50) NOT NULL ,
    Last_Name VARCHAR(50) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    E_Mail VARCHAR(100) NOT NULL,
    Customer_Since DATE NOT NULL,
    Phone_No VARCHAR(15) NOT NULL,
    Gender CHAR(1),
    age INT

	CONSTRAINT [PK_Dim_Customer] PRIMARY KEY CLUSTERED (cust_id ASC) 

);
GO

---- dim_Region
CREATE TABLE Dim_Region(
    Region_id INT NOT NULL ,
    Place_Name VARCHAR(100) NOT NULL,
    County VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(50),
    Zip VARCHAR(10),
    Region VARCHAR(50)
 CONSTRAINT [PK_Dim_Location] PRIMARY KEY CLUSTERED (Region_id ASC)) ;
GO

---dim_product
CREATE TABLE Dim_Product (
    product_id INT NOT NULL ,
    sku VARCHAR(50) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    discount_percent DECIMAL(5, 2)
	CONSTRAINT [PK_Dim_Product] PRIMARY KEY CLUSTERED (product_id ASC)
);
GO


ALTER TABLE Dim_Product
ALTER COLUMN sku VARCHAR(200) NOT NULL;




--payment_method
CREATE TABLE Dim_Payment_Method (
    payment_method_id INT ,
    payment_method VARCHAR(50)
	CONSTRAINT [PK_Dim_Payment_Method] PRIMARY KEY CLUSTERED (payment_method_id ASC)
);
GO

-- dim_Time Table
CREATE TABLE Dim_Date (
    date_id INT,
    [day] INT,
    [month] INT,
    [year] INT,
	CONSTRAINT [PK_Date_Dimension] PRIMARY KEY CLUSTERED (date_id ASC)
);
GO


---- fact

CREATE TABLE Orders_Fact (
    order_id INT PRIMARY KEY,
    product_id INT,
    cust_id INT,
    date_id INT,
    payment_method_id INT,
    Region_id INT,

	qty_ordered INT,
    price DECIMAL(10, 2), 
    discount_amount DECIMAL(10, 2),
    total DECIMAL(10, 2),
    discount_percent DECIMAL(5, 2),

    FOREIGN KEY (product_id) REFERENCES Dim_Product(product_id),
    FOREIGN KEY (cust_id) REFERENCES Dim_Customer(cust_id),
    FOREIGN KEY (date_id) REFERENCES Dim_Date(date_id),
    FOREIGN KEY (payment_method_id) REFERENCES Dim_Payment_Method(payment_method_id),
    FOREIGN KEY (Region_id) REFERENCES Dim_Region(Region_id)
);
GO

ALTER TABLE Orders_Fact 
ADD  [status] VARCHAR(50) ;

