create database Homework

---------------------------------------

use Homework

create table Hotels (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	HotelName nvarchar(100) NOT NULL,
	HotelCapacity int,
	HotelState nvarchar(100) NOT NULL,
	HotelCity nvarchar(100) NOT NULL,
	HotelAddress nvarchar(100) NOT NULL,
)

create table Employees (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) ON DELETE CASCADE NOT NULL,
	EmployeeFirstName nvarchar(100) NOT NULL,
	EmployeeLastName nvarchar(100) NOT NULL,
	JobType nvarchar(100)
	CHECK(JobType = 'room service' or JobType = 'room maid' or JobType = 'receptionist' or JobType = 'cleaner' or JobType = 'cook') NOT NULL
)


create table Buyers (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	BuyerFirstName nvarchar(100) NOT NULL,
	BuyerLastName nvarchar(100) NOT NULL,
	BuyerOib nvarchar(20) NOT NULL
)

create table Guests (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	GuestFirstName nvarchar(100) NOT NULL,
	GuestLastName nvarchar(100) NOT NULL
)

create table Rooms (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) ON DELETE CASCADE,
	RoomCapacity int NOT NULL,
	RoomNumber nvarchar(5) NOT NULL,
)

create table Stays (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	BuyerId int FOREIGN KEY REFERENCES Buyers(Id) ON DELETE CASCADE NOT NULL,
	GuestId int FOREIGN KEY REFERENCES Guests(Id) ON DELETE CASCADE NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(Id) ON DELETE CASCADE NOT NULL,
	TimeOfTransaction datetime2 NOT NULL,
	CheckInDate datetime2 NOT NULL,
	CheckOutDate datetime2 NOT NULL,
	TypeOfStay nvarchar(100)
		CHECK(TypeOfStay = 'obični boravak' or TypeOfStay = 'polupansion' or TypeOfStay = 'receptionist' or TypeOfStay = 'pansion') NOT NULL,
	Price float NOT NULL
)

insert into Hotels (HotelName, HotelCapacity, HotelState, HotelCity, HotelAddress) VALUES
('Hotel Ladovina', 1000, 'Tunguzija', 'Flegmagrad', 'Vječnog odmora 13'),
('Kod Kraljice', 1000, 'Tigana', 'Stevanien', 'Nemam inspracije BB'),
('Adria ski', 1000, 'BiH', 'Kupres', 'Čajuša BB'),
('Hajdučke vrleti', 1000, 'BiH', 'Blidinje', 'Blidinje BB'),
('Radisson Blu', 1000, 'RH', 'Split', 'Put Trstenika 19')

insert into Employees (EmployeeFirstName, EmployeeLastName, JobType, HotelId) VALUES
('Božo', 'Petrov', 'room service', 1),
('Ivo', 'Sanader', 'room maid', 1),
('Kolinda', 'Grabar-Kitarović', 'receptionist', 1),
('Zoran', 'Milanović', 'cleaner', 1),
('Andrej', 'Plenković', 'room service', 2),
('Vilibor', 'Sinčić', 'room maid', 2),
('Stipe', 'Mesić', 'cleaner', 2),
('Ingrid', 'Antičević', 'room service', 3),
('Davor', 'Božinović', 'cleaner', 3),
('Milan', 'Bandić', 'cook', 1)

insert into Buyers (BuyerFirstName, BuyerLastName, BuyerOib) VALUES
('Dennis', 'Ritchie', 'DR-OIB'),
('Jonh Ronald Reul', 'Tolkine', 'JRRT-OIB'),
('Piet', 'Mondrian', 'PM-OIB'),
('Gordon', 'Freeman', 'GF-OIB'),
('Bruce', 'Dickinson', 'BD-OIB')

insert into Guests(GuestFirstName, GuestLastName) VALUES
('Dennis', 'Ritchie'),
('Jonh Ronald Reul', 'Tolkine'),
('Christopher', 'Christopher'),
('Christoph', 'Waltz'),
('Joe', 'Satriani'),
('Bruce', 'Dickinson'),
('Emiel Regis Rohellec', 'Terzieff-Godefroy'),
('Irene', 'Jansen'),
('Floor', 'Jansen'),
('Antonije', 'Pušić'),
('Piet', 'Mondrian')

insert into Rooms(RoomNumber, RoomCapacity, HotelId) VALUES
('101', 2, 1),
('102', 2, 1),
('201', 2, 1),
('202', 3, 1),
('301', 3, 1),
('302', 4, 1),
('101', 2, 2),
('102', 2, 2),
('201', 3, 2),
('202', 4, 2),
('101', 2, 3),
('102', 2, 3),
('201', 3, 3),
('202', 4, 3),
('101', 2, 4),
('102', 2, 4),
('201', 3, 4),
('202', 4, 4),
('A101', 2, 5),
('A102', 2, 5),
('B101', 3, 5),
('B102', 4, 5)

insert into Stays (GuestId, CheckInDate, CheckOutDate, TypeOfStay, RoomId, BuyerId, Price, TimeOfTransaction) VALUES
(1, '2020-12-11', '2020-12-30', 'pansion', 1, 1, 2000.00, GETDATE()),
(2, '2019-07-11', '2019-07-30', 'polupansion', 2, 2, 1500.00, GETDATE()),
(3, '2019-07-11', '2019-07-30', 'pansion', 3, 4, 2000.00, GETDATE()),
(4, '2019-07-11', '2019-07-30', 'polupansion', 2, 2, 1500.00, GETDATE()),
(5, '2019-07-11', '2019-07-30', 'obični boravak', 7, 5, 1000.00, GETDATE()),
(6, '2019-07-11', '2019-07-30', 'polupansion', 8, 5, 100.00, GETDATE()),
(7, '2019-07-11', '2019-07-30', 'pansion', 12, 4, 2000.00, GETDATE()),
(8, '2019-07-11', '2019-07-30', 'obični boravak', 13, 3, 1000.00, GETDATE()),
(9, '2019-07-11', '2019-07-30', 'pansion', 14, 3, 2000.00, GETDATE()),
(10, '2020-11-11', '2020-11-30', 'polupansion', 15, 3, 1500.00, GETDATE()),
(11, '2020-12-5', '2020-07-30', 'obični boravak', 2, 3, 1000.00, GETDATE()),
(7, '2000-07-11', '2000-07-30', 'pansion', 17, 2, 2500.00, GETDATE()),
(6, '2015-07-11', '2015-07-30', 'obični boravak', 2, 5, 2000.00, GETDATE())

select * from Rooms where HotelId = (select Id from Hotels where HotelName = 'Hotel Ladovina') ORDER BY(RoomNumber)

select * from Rooms where RoomNumber LIKE '1%'

select EmployeeFirstName, EmployeeLastName from Employees where JobType = 'cleaner' AND HotelId = (select Id from Hotels where HotelName = 'Hotel Ladovina')

select * from Stays where CheckInDate > '2020-12-01' AND Price > 1000

select * from Stays where GETDATE() BETWEEN CheckInDate AND CheckOutDate

delete from Stays where  CheckOutDate < '2020-01-01'

update Rooms set RoomCapacity = 4 where RoomCapacity = 3 AND HotelId = 2

select * from Stays where RoomId = 2 ORDER BY CheckInDate

select * from Stays 
JOIN Rooms ON Rooms.Id = Stays.RoomId
where HotelId = (select Id from Hotels where HotelName = 'Hotel Ladovina') AND (TypeOfStay = 'pansion' OR TypeOfStay = 'polupansion')

update TOP(2) Employees set JobType = 'receptionist' where JobType = 'room service'