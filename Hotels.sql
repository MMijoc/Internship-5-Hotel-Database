create database HotelsChain

------------------------------------

use HotelsChain

create table Hotels(
	Id int IDENTITY(1,1) PRIMARY KEY,
	HotelName nvarchar(128) NOT NULL,
	NumberOfRooms int NOT NULL,
	HoteAddress nvarchar(128) NOT NULL
)

create table Employees (
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(128) NOT NULL,
	LastName nvarchar(128) NOT NULL,
	JobType nvarchar(128) NOT NULL check(JobType = 'room service' or JobType = 'room maid' or JobType = 'receptionist' or JobType = 'cleaner'),
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
)

create table Buyers (
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(128) NOT NULL,
	LastName nvarchar(128) NOT NULL,
	Oib nvarchar(16) NOT NULL,
	PhoneNumber nvarchar(16),
	Email nvarchar(64)
)

create table Guests (
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(128) NOT NULL,
	LastName nvarchar(128) NOT NULL,
	PhoneNumber nvarchar(16),
	Email nvarchar(64) NOT NULL,
)

create table Reservations (
	Id int IDENTITY(1,1) PRIMARY KEY,
	ReservationDate datetime2 NOT NULL,
	CheckInDate datetime2 NOT NULL,
	CheckOutDate datetime2 NOT NULL,
	StayType nvarchar(128) NOT NULL check(StayType = 'obi?ni boravak' or StayType = 'pansion' or StayType = 'polupansion'),
	Price decimal(9,2) NOT NULL,
	BuyerId int FOREIGN KEY REFERENCES Buyers(Id) NOT NULL,
)

create table GuestReservations (
	GuestId int FOREIGN KEY REFERENCES Guests(Id) NOT NULL,
	ReservationId int FOREIGN KEY REFERENCES Reservations(Id) NOT NULL,
	CONSTRAINT GuestReservationsPrimaryKey PRIMARY KEY(GuestId, ReservationId)
)

create table Rooms (
	Id int IDENTITY(1,1) PRIMARY KEY,
	RoomNumber nvarchar(128) NOT NULL,
	RoomCapacity int NOT NULL,
	RoomPrice decimal(9,2) NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
	ReservationId int FOREIGN KEY REFERENCES Reservations(Id)
)

insert into Hotels (HotelName, HoteAddress, NumberOfRooms) VALUES
('Hotel A', 'Grad A, Ulica A, 1', 5),
('Hotel B', 'Grad B, Ulica B, 2', 10),
('Hotel C', 'Grad C, Ulica C, 3', 100),
('Hotel D', 'Grad D, Ulica D, 4', 200),
('Hotel E', 'Grad E, Ulica E, 5', 1000)

insert into Employees (FirstName, LastName, JobType, HotelId) VALUES 
('EmpolyeeName1', 'EmpolyLastName1', 'cleaner', 1),
('EmpolyeeName2', 'EmpolyLastName2', 'receptionist', 1),
('EmpolyeeName3', 'EmpolyLastName3', 'cleaner', 1),
('EmpolyeeName4', 'EmpolyLastName4', 'room service', 1),
('EmpolyeeName5', 'EmpolyLastName5', 'room maid', 1),
('EmpolyeeName6', 'EmpolyLastName6', 'cleaner', 2),
('EmpolyeeName7', 'EmpolyLastName7', 'room service', 2),
('EmpolyeeName8', 'EmpolyLastName8', 'receptionist', 2),
('EmpolyeeName9', 'EmpolyLastName9', 'cleaner', 3),
('EmpolyeeName10', 'EmpolyLastName10', 'room service', 4)

insert into Buyers (FirstName, LastName, Oib, PhoneNumber, Email) VALUES
('buyerName1', 'buyerLastName1', 'buyerOIB1', '111 111 111', 'buyer1@gamil.com'),
('buyerName2', 'buyerLastName2', 'buyerOIB2', '222 222 222', 'buyer2@gamil.com'),
('buyerName3', 'buyerLastName3', 'buyerOIB3', '333 333 333', 'buyer3@gamil.com'),
('buyerName4', 'buyerLastName4', 'buyerOIB4', '444 444 444', 'buyer4@gamil.com'),
('buyerName5', 'buyerLastName5', 'buyerOIB5', '555 555 555', 'buyer5@gamil.com')

insert into Reservations (ReservationDate, CheckInDate, CheckOutDate, StayType, Price, BuyerId) VALUES
('2019-12-1 12:00', '2019-12-1 12:00', '2019-12-2 12:00', 'polupansion', 500, 1),
(GETDATE(), '2020-12-19 12:00', '2021-01-5 12:00', 'polupansion', 500, 1),
(GETDATE(), '2020-12-1 12:00', '2020-12-3 12:00', 'pansion', 1000, 2),
(GETDATE(), '2020-12-1 12:00', '2020-12-4 12:00', 'obi?ni boravak', 500, 3),
(GETDATE(), '2020-12-1 12:00', '2020-12-5 12:00', 'polupansion', 1000, 4),
(GETDATE(), '2020-12-1 12:00', '2020-12-6 12:00', 'pansion', 1500, 5)

insert into Guests(FirstName, LastName, PhoneNumber, Email) VALUES
('Dennis', 'Ritchie', '111 111 111', 'Dennis@gamil.com'),
('Christopher', 'Tolkien', '222 222 222', 'Christopher@gamil.com'),
('Piet', 'Mondrian', '333 333 333', 'Piet@gamil.com'),
('Gordon', 'Freeman', '444 444 444', 'Gordon@gamil.com'),
('Floor', 'Jansen', '555 555 555', 'Floor@gamil.com')

insert into Rooms (RoomNumber, RoomCapacity, RoomPrice, HotelId, ReservationId) VALUES
(101, 2, 300, 1,1),
(201, 2, 300, 1,2),
(111, 3, 500, 2,3),
(222, 2, 500, 2,4),
(100, 3, 500, 3,5)

insert into GuestReservations(GuestId, ReservationId) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5)


select * from Rooms where HotelId = (select id from Hotels where HotelName = 'Hotel A') order by RoomNumber ASC

select * from Rooms where RoomNumber like '1%'

select FirstName, LastName from Employees where HotelId = (select id from Hotels where HotelName = 'Hotel A') AND JobType = 'cleaner'

select * from Reservations where ReservationDate > '2020-12-1 00:00' AND Price > 1000

select * from Reservations where( CheckInDate < GETDATE() AND GETDATE() < CheckOutDate)

update Rooms set RoomCapacity = 4 where (HotelId = 2 AND RoomCapacity = 3)

select * from Reservations where (StayType = 'panison' or StayType = 'polupansion')

select * from Reservations ORDER BY(CheckInDate)

select * from Employees where JobType = 'room service'
update Employees set JobType = 'receptionist' where JobType = 'room service' and id = 4 or Id = 7

--znam da je dosta loše napravljeno, ovaj tjedan mi je bio pun komplikacija pa nisam ovo stigo nauciti kako treba