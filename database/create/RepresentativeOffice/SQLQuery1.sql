CREATE DATABASE RepresentativeOffice;
USE RepresentativeOffice;
CREATE TABLE Customers(
 CustomerId char(10) not null,
 CustomerName nvarchar(50) not null,
 CityID char(4) not null,
 FirstOrderDate DATE,
 CONSTRAINT PK_Customers
 PRIMARY KEY (CustomerID)
);
CREATE TABLE TravelCustomers(
	CustomerId char(10) not null,
	TourGuide nvarchar(50) not null,
	TravelTime DATE,
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
	PostTime DATE,
	CONSTRAINT PK_PostalCustomers
	PRIMARY KEY (CustomerId),
	CONSTRAINT FK_PostalCustomers_Customers
	FOREIGN KEY (CustomerId)
	REFERENCES Customers(CustomerId)
	ON DELETE CASCADE
	ON UPDATE CASCADE
)
;