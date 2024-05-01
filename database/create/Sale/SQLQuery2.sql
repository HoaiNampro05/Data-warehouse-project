CREATE DATABASE sale;
USE sale;
CREATE TABLE RepresentativeOffices(
	CityId char(4) not null,
	CityName nvarchar(50) not null,
	OfficeAddress nvarchar(100) not null,
	State nvarchar(100) not null,
	Time date not null,
	CONSTRAINT PK_RepresentativeOffices
	PRIMARY KEY (CityId)
);
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
	size varchar(20) not null,
	weight int not null,
	price int not null,
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
	PRIMARY KEY(OrderId)
);
CREATE TABLE OrderedItems(
	OrderId char(10) not null,
	ItemId char(10) not null,
	OrderedQuantity int not null,
	OrderCost int not null,
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
