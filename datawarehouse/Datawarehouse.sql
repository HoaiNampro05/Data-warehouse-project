CREATE DATABASE datawarehouse
use datawarehouse;
CREATE TABLE DimItem (
	ItemKey char(10) not null,
	Descriptions nvarchar(255) not null,
	Size nvarchar(20) not null,
	Weight int not null,
	Price int not null,
	CONSTRAINT PK_Items
	PRIMARY KEY (ItemKey)
);

CREATE TABLE DimTime (
	TimeKey char(10) not null,
	Day int not null,
	Month int not null,
	Quarter int not null,
	Year int not null
	CONSTRAINT PK_Time
	PRIMARY KEY (TimeKey)
);

CREATE TABLE DimRepresentativeOffice (
	CityKey char(10) not null,
	CityName nvarchar(50) not null,
	OfficeAddress nvarchar(100) not null,
	State nvarchar(100) not null,
	Time date not null,
	CONSTRAINT PK_City
	PRIMARY KEY (CityKey)
);

CREATE TABLE DimStore (
	StoreKey char (10) not null,
	CityKey char (10) not null,
	PhoneNumber char(12) not null,
	CONSTRAINT PK_Store
	PRIMARY KEY (StoreKey),
	CONSTRAINT FK_City
	FOREIGN KEY (CityKey)
	REFERENCES DimRepresentativeOffice(CityKey)
);

CREATE TABLE DimCustomers (
	CustomerKey char(10) not null,
	FullName nvarchar(50) not null,
	CityKey char(10) not null,
	TravelCustomer bit not null,
	PostalAddress bit not null,
	CONSTRAINT PK_Customers
	PRIMARY KEY (CustomerKey),
	CONSTRAINT PK_CustomerOfCity
	FOREIGN KEY (CityKey)
	REFERENCES DimRepresentativeOffice(CityKey)
);

CREATE TABLE FactStoreItems(
	TimeKey char(10) not null,
	ItemKey char(10) not null,
	StoreKey char(10) not null,
	Quantity int not null,
	CONSTRAINT PK_TimeOfStoreItems
	FOREIGN KEY (TimeKey)
	REFERENCES DimTime(TimeKey),
	CONSTRAINT PK_ItemsOfStore
	FOREIGN KEY (ItemKey)
	REFERENCES DimItem(ItemKey),
	CONSTRAINT PK_StoreItem
	FOREIGN KEY (StoreKey)
	REFERENCES DimStore(StoreKey)
);

CREATE TABLE FactOrderItems (
	TimeKey char(10) not null,
	ItemKey char(10) not null,
	CustomerKey char(10) not null,
	OrderedQuantity int not null,
	OrderedCost bigint not null,
	Profit bigint not null,
	CONSTRAINT PK_TimeOfOrderItems
	FOREIGN KEY (TimeKey)
	REFERENCES DimTime(TimeKey),
	CONSTRAINT PK_ItemsOfOrder
	FOREIGN KEY (ItemKey)
	REFERENCES DimItem(ItemKey),
	CONSTRAINT PK_OrderOfCustomer
	FOREIGN KEY (CustomerKey)
	REFERENCES DimCustomers(CustomerKey)
)


