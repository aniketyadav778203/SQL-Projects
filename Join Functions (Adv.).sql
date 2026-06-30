-- New Databse 'Hospital_Management'
-----------------------------------

create database Hospital_management ;

use hospital_management ;

-- First Table - Patients
------------------------------

create table patients
(
Patient_id int primary key auto_increment ,
Patient_name varchar(50) Not null,
Age int check(age>0) ,
Gender enum('Male','Female','Other') not null,
City varchar(50) default 'Delhi',
Phone varchar(15) unique
);

-- Second Table - Doctors
-------------------------

create Table doctors
(
Doctor_id int primary key auto_increment,
Doctor_name varchar(50) Not Null ,
Specialization varchar(50) not null ,
Fees decimal(10,2) check(fees>0),
city varchar(50),
Email varchar(100) unique
); 

-- Third Table - Appointments
--------------------------------

create Table Appointments
(
Appointment_id int primary key auto_increment ,
Patient_id int not null ,
Doctor_id int not null ,
Appointment_date date not null,
Status varchar(20) default 'Pending',

foreign key (patient_id)
references Patients(patient_id),

foreign key (doctor_id)
references Doctors(Doctor_id)
);

-- Fourth Table - Medicines
---------------------------

create table Medicines
(
Medicine_id int primary key auto_increment,
Medicine_name varchar(50) not null,
Price decimal(10,2) check(Price>0),
Company varchar(50) not null
);

-- Fifth Table - Bills
--------------------------

create table Bills
(
Bill_id int primary key auto_increment,
Appointment_id int not null,
medicine_id int not null ,
Amount decimal(10,2) check(amount>=0),
Payment_status varchar(20) default 'Unpaid',

foreign key (Appointment_id)
references Appointments(Appointment_id),

foreign key (Medicine_id)
references Medicines(Medicine_id)
);

-------------------------------------------------------------------------

-- Insert values into Patient Table
------------------------------------

insert into patients 
(Patient_name,Age,Gender,City,Phone)
Values
('Rahul sharma',25,'Male','Delhi','9876543210'),
('Riya verma',22,'Female','Mumbai','9876543211'),
('Amit Kumar',30,'Male','Kolkata','9876543212'),
('Neha Singh',28,'Female','Chennai','9876543213'),
('Sohan gupta',35,'Male','Pune','9876543214'),
('Kavya Mehta',24,'Female','Delhi','9876543215'),
('Arjun Patel',29,'Male','Hyderabad','9876543216'),
('Pooja yadav',25,'Female','Jaipur','9876543217'),
('Vivek Roy',32,'Male','Patna','9876543218'),
('Sneha Das',26,'Female','Luckmow','9876543219');

-- Insert values into Doctors table
----------------------------------------

insert into Doctors
(Doctor_name,Specialization,Fees,City,Email)
Values
('Dr. Raj Mehta','Cardiologist',1500.00,'Delhi','raj@gmail.com'),
('Dr. Anjali Sharma','Dentist',800.00,'Mumbai','anjali@gmail.com'),
('Dr. Vivek Singh','Neurologist',2000.00,'Kolkata','vivek@gmail.com'),
('Dr. Neha kapoor','Orthopedic',1200.00,'Chennai','neha@gmail.com'),
('Dr. Aman Verma','Pediatrician',1000.00,'Pune','aman@gmail.com'),
('Dr. Kavita Rao','Dermatologist',1200.00,'Hyderabad','kavita@gmail.com'),
('Dr. Rohit Yadav','ENT Specialist',1100.00,'Jaipur','rohit@gmail.com'),
('Dr. Simran Kaur','Gynecologist',1200.00,'Delhi','simran@gmail.com'),
('Dr. Arjun Das','Psychiatrist',1800.00,'Patna','arjun@gmail.com'),
('Dr. Pooja Jain','General Physician',1700.00,'Lucknow','pooja@gmail.com');

-- Insert values into Appointments Table
-----------------------------------------

insert into Appointments
(Patient_id,Doctor_id,Appointment_date,Status)
Values
(12,12,'2026-05-02','Pending'),
(13,13,'2026-05-03','Completed'),
(14,14,'2026-05-04','Cancelled'),
(15,15,'2026-05-05','Completed'),
(16,16,'2026-05-06','Pending'),
(17,17,'2026-05-07','Completed'),
(18,18,'2026-05-08','Pending'),
(19,19,'2026-05-09','Completed'),
(20,20,'2026-05-10','Cancelled'); 

-- Insert values into Medicines Table
-----------------------------------------

insert into Medicines
(Medicine_name,Price,Company)
Values
('Paracetamol',50.00,'Cipla'), 
('Azithromycin',120.00,'Sun pharma'),
('Dolo 650',80.00,'Micro Labs'),
('Amoxicillin',150.00,'Mankind'),
('Cetrizine',40.00,'Dr Reddy'),
('Pantoprazole',90.00,'lupin'),
('Metformin',110.00,'Aurobindo'),
('Ibuprofen',70.00,'Zydus'),
('Vitamin c',60.00,'Himalaya'),
('ORS Powder',30.00,'Dabur');


-- Insert values into Bills Table
--------------------------------------------

Insert into Bills
(Appointment_id,Medicine_id,Amount,Payment_Status)
Values
(11,1,1550,'Paid'),
(12,2,920,'Unpaid'),
(13,3,2080,'Paid'),
(14,4,1350,'Pending'),
(15,5,1450,'Paid'),
(16,6,1650,'Unpaid'),
(17,7,1750,'Paid'),
(18,8,1400,'Pending'),
(19,9,1590,'Paid'),
(20,10,1600,'Unpaid');


----------------------------------------------------------------------------------------------------------------

-- View all Tables
-------------------

-- View All Tables below

SELECT * FROM hospital_management.patients;

SELECT * FROM hospital_management.appointments;

SELECT * FROM hospital_management.doctors;

SELECT * FROM hospital_management.medicines;

SELECT * FROM hospital_management.bills; 

-----------------------------------------------------------------------------------------------------------------------

-- Show all patient details

select * from patients;

-- Show patient name and doctor name

select patient_name,doctor_name from patients
inner join appointments
on Patients.Patient_id=appointments.Patient_id
inner join doctors
on Doctors.Doctor_id=appointments.Doctor_id ;

-- Show completed appointments

select * from appointments
where Status='completed';

-- Show highest bill amount

select max(Amount) as Highest_Bill From bills;

-- Show patient having highest bill

select Patient_name , Amount from patients
inner join appointments
on patients.Patient_id=appointments.Patient_id
inner join Bills
on appointments.Appointment_id=bills.Appointment_id
where Amount = (select max(Amount) as highest_bill from bills) ;

-- Count total patients city-wise

select city , count(*) as Total_patients from patients
group by city ;

-- Show doctor-wise total appointments

select doctor_name , count(appointment_id) as Total_Appointmnets From doctors
left join appointments
on doctors.Doctor_id=appointments.Doctor_id
group by Doctor_name ;

-- Show total paid revenue

select sum(Amount) as Total_Paid_Revenue from bills
where Payment_status='Paid' ;

-- Show medicines price greater than 100

select medicine_name,Price from medicines
where price > 100 ;

-- Show pending appointments

select * from appointments
where Status='Pending' ;

-- Show patients from Delhi

select * from patients
where city = 'Delhi' ;

-- Show doctors whose fees are above average

select doctor_name , Fees from doctors
where Fees > ( select avg(fees) from doctors ) ; 

-- Show medicine-wise bill amount

select medicine_name , sum(amount) as Total_amount from medicines
inner join bills
on medicines.Medicine_id=bills.medicine_id 
group by Medicine_name;

-- Show patients whose name starts with 'R'

select * from patients
where Patient_name like 'R%' ;

-- Show total appointments between 2025 and 2026

select count(*) from appointments
where year(Appointment_date) between 2025 and 2026 ;

-- Show doctor with highest fees

select * from doctors
where fees = ( select max(fees) from doctors ) ;

-- Show unpaid bills

select * from bills 
where Payment_status='Unpaid' ;

-- Show patient count gender-wise

select gender , count(*) from patients
group by gender ;

-- Show appointments with patient and doctor details

select patient_name,appointment_id ,doctor_name from patients
inner join appointments
on patients.Patient_id=appointments.Patient_id
inner join doctors
on appointments.Doctor_id=doctors.Doctor_id ;

-- Show average doctor fees city-wise

select city , avg(fees) as Average_fees from doctors
group by city ;







