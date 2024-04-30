CREATE DATABASE Intergration;
USE Intergration;
CREATE TABLE RepresentativeOffices(
	CityId char(4) not null,
	CityName nvarchar(50) not null,
	OfficeAddress nvarchar(100) not null,
	State nvarchar(100) not null,
	Time date not null,
	CONSTRAINT PK_RepresentativeOffices
	PRIMARY KEY (CityId)
);
CREATE TABLE Customers(
 CustomerId char(10) not null,
 CustomerName nvarchar(50) not null,
 CityId char(4) not null,
 FirstOrderDate DATE,
 CONSTRAINT PK_Customers
 PRIMARY KEY (CustomerID),
 CONSTRAINT FK_Customers_RepresentativeOffices
 FOREIGN KEY (CityId)
 REFERENCES RepresentativeOffices(CityId)
 ON DELETE CASCADE
 ON UPDATE CASCADE
);
CREATE TABLE TravelCustomers(
	CustomerId char(10) not null,
	TourGuide nvarchar(50) not null,
	Time DATE,
	CONSTRAINT PK_TravelCustomers
	PRIMARY KEY (CustomerId),
	CONSTRAINT FK_TravelCustomers_Customers
	FOREIGN KEY (CustomerId)
	REFERENCES Customers(CustomerId)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)
;
CREATE TABLE PostalCustomers(
	CustomerId char(10) not null,
	PostAddress nvarchar(50) not null,
	Time DATE,
	CONSTRAINT PK_PostalCustomers
	PRIMARY KEY (CustomerId),
	CONSTRAINT FK_PostalCustomers_Customers
	FOREIGN KEY (CustomerId)
	REFERENCES Customers(CustomerId)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)
;

CREATE TABLE Stores(
	StoreId char(10) not null,
	CityId char(4) not null,
	PhoneNumber char(12) not null,
	Time date,
	CONSTRAINT PK_Store
	PRIMARY KEY (StoreId),
	CONSTRAINT FK_Stores_RepresentativeOffices
	FOREIGN KEY (CityId)
	REFERENCES RepresentativeOffices(CityId)
);
CREATE TABLE Items(
	ItemId char(10) not null,
	Descriptions nvarchar(255) not null,
	Size nvarchar(20) not null,
	Weight int not null,
	Price int not null,
	Time date not null,
	CONSTRAINT PK_Items
	PRIMARY KEY (ItemId)
);
CREATE TABLE StoredItems(
	ItemId char(10) not null,
	StoreId char(10) not null,
	StoredQuantity int not null,
	Time date,
	CONSTRAINT PK_StoredItems
	PRIMARY KEY(ItemId,StoreId),
	CONSTRAINT FK_StoredItems_Items
	FOREIGN KEY (ItemId) 
	REFERENCES Items(ItemId),
	CONSTRAINT FK_StoredItems_Stored
	FOREIGN KEY (StoreId) 
	REFERENCES Stores(StoreId)
);
CREATE TABLE Orders(
	OrderId char(10) not null,
	OrderDate date not null,
	CustomerId char(10) not null,
	CONSTRAINT PK_Orders
	PRIMARY KEY(OrderId),
	CONSTRAINT FK_Orders_Customers
	FOREIGN KEY (CustomerId)
	REFERENCES Customers(CustomerId)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
CREATE TABLE OrderedItems(
	OrderId char(10) not null,
	ItemId char(10) not null,
	OrderedQuantity int not null,
	OrderPrice int not null,
	Time date,
	CONSTRAINT PK_OrderedItems
	PRIMARY KEY(OrderId,ItemId),
	CONSTRAINT FK_OrderedItems_Orders
	FOREIGN KEY (OrderId) 
	REFERENCES Orders(OrderId),
	CONSTRAINT FK_OrderedItems_Items
	FOREIGN KEY (ItemId) 
	REFERENCES Items(ItemId)
);
