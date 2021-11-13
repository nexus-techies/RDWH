 drop database if exists Bookstore;
 -- drop database Bookstore;
create database Bookstore;
use Bookstore;
-- drop database Bookstore;

-- 17
-- drop table city ;
create table city(
city_id int AUTO_INCREMENT primary key,
city_name varchar(20) not null,
state_id int not null,
country_id int not null
-- foreign key(state_id) references state(state_id),
-- foreign key(country_id) references country(country_id)
);
-- 7
create table book_language(
book_language_id INT AUTO_INCREMENT primary key,
book_language_name varchar(20) not null
);

-- 21
create table book_quality(
book_quality_id INT AUTO_INCREMENT primary key,
book_quality_name varchar(20) not null
);
-- 1
create table authors(
author_id varchar(20) primary key,
author_name varchar(20) not null,
author_email varchar(30) not null,
city_id int not null,
author_commission DOUBLE not null,
foreign key(city_id) references city(city_id)
);

-- 2

create table books(
book_id varchar(20) primary key,
book_name varchar(50) not null,
book_type varchar(20) not null,
author_id varchar(20) not null,
book_price INT not null,
book_language_id int not null,
book_stock INT not null,
book_quality_id int not null,
foreign key(author_id) references authors(author_id),
foreign key(book_language_id) references book_language(book_language_id),
foreign key(book_quality_id) references book_quality(book_quality_id)
);

-- 3
create table bookstore(
store_id varchar(20) primary key,
store_name varchar(30) not null,
store_address varchar(20) not null
);

-- 4
create table customers(
customer_id INT AUTO_INCREMENT primary key,
customer_name varchar(20) not null,
customer_address varchar(20) not null,
customer_phone varchar(20) not null
);

-- 5
create table orders(
order_id INT AUTO_INCREMENT primary key,
order_date DATETIME not null DEFAULT now(),
customer_id varchar(20) not null default 1000000,
book_id varchar(20) not null default 'B100',
store_id varchar(20) not null default 'S1',
order_quantity int not null default 0
);

-- 6
create table supplier(
supplier_id INT AUTO_INCREMENT primary key,
supplier_name varchar(20) not null,
supplier_country varchar(20) not null
);

-- 8
create table country(
country_id INT AUTO_INCREMENT primary key,
country_name varchar(20) not null
);

-- 10
create table jobs(
job_id int AUTO_INCREMENT primary key,
job_level int not null
);

-- 9
create table employees(
emp_id INT AUTO_INCREMENT primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
job_id int not null,
pub_id int not null,
hire_Date datetime not null,
foreign key(job_id) references jobs(job_id)
);


-- 11
create table genre(
genre_id int AUTO_INCREMENT primary key,
genre_name varchar(20) not null
);

-- 12
create table wishlist
( wishlist_id int not null,
wishlist_bookname varchar(25) not null,
wishlist_booktype varchar(20) not null,
customer_id int not null,
Foreign key (customer_id) references customers(customer_id)
);

-- 13
create table discounts(
discount_id INT AUTO_INCREMENT primary key,
discount_date DATETIME not null DEFAULT now(),
discount_type varchar(20) not null default 'percentage',
discount_percentage float not null,
book_id varchar(20) not null,
store_id varchar(20) not null,
order_quantity int not null default 0,
foreign key(book_id) references books(book_id),
foreign key(store_id) references bookstore(store_id)
-- foreign key(order_quantity) references orders(order_quantity)
);

-- 24
create table distributors
(
distributors_id int Primary key Auto_increment not null,
distributors_name varchar(20) not null
);

-- 25
create table transport( 
truck_id int primary key not null,
driver_name varchar(25) not null
);

-- 14
create table shipping(
shipping_id INT AUTO_INCREMENT primary key,
shipping_method varchar(20) not null,
distributors_id int not null,
shipping_date DATETIME not null DEFAULT now(),
shipping_city varchar(20) not null,
cost float,
truck_id int not null,
foreign key(distributors_id) references distributors(distributors_id),
foreign key(truck_id) references transport(truck_id)
);

-- 31
create table account(
	account_id INT AUTO_INCREMENT primary key,
    shipping_address varchar(20) not null,
    customer_phone varchar(20) not null,
    customer_id int not null,
    shipping_id int not null,
    foreign key(customer_id) references customers(customer_id),
    foreign key(shipping_id) references shipping(shipping_id)
);

-- 16
-- drop table publishers;
create table publishers(
pub_id int AUTO_INCREMENT primary key,
pub_first_name varchar(20) not null,
pub_last_name varchar(20) not null,
city_id int not null,
zipcode int not null,
phone_number int not null,
book_id varchar(20) not null,
foreign key(city_id) references city(city_id),
foreign key(book_id) references books(book_id)
);
-- 15
-- drop table titles;
create table titles(
title_id int AUTO_INCREMENT primary key,
title varchar(100) not null,
title_type varchar(50) not null,
pub_id int not null,
price int not null,
royalty int not null,
foreign key(pub_id) references publishers(pub_id)
);

-- 18
create table state(
state_id int AUTO_INCREMENT primary key,
state_name varchar(25) not null,
country_id int not null,
foreign key(country_id) references country(country_id)
);

-- 19
create table order_status(
order_status_id INT AUTO_INCREMENT primary key,
order_status varchar(20) not null,
tracking_id int not null,
order_id int not null,
shipping_id int not null,
foreign key(shipping_id) references shipping(shipping_id),
foreign key(order_id) references orders(order_id)
);

-- 20
Create Table cart(cart_id int not null,
price int not null,
customer_id int not null,
quantity int not null,
Foreign key (customer_id) references customers(customer_id)
);

-- 22
Create table transactions(
transaction_id int not null,
transaction_date date,
amount double not null,
quantity int not null,
payment_mode varchar(40),
order_id int not null,
Foreign key (order_id) references orders(order_id)
);

-- 23
create table sales
(
order_id int not null,
order_date date not null,
quantity int not null,
payterms int not null,
book_id varchar(20) not null,
Foreign key(order_id) references orders (order_id),
Foreign key(book_id) references books(book_id)
);



-- 26
create table issue
(
issue_id int primary key not null,
issue_date date not null,
emp_id int not null,
Foreign key(emp_id) references employees(emp_id)
);

-- 27
create table book_return(
return_id int not null AUTO_INCREMENT primary key,
return_date DATETIME not null DEFAULT now(),
customer_id int not null,
book_id varchar(20) not null,
issue_id int not null,
foreign key(customer_id) references customers(customer_id),
foreign key(book_id) references books(book_id),
foreign key(issue_id) references issue(issue_id)
);

-- 28
create table payments(
	payment_id INT AUTO_INCREMENT primary key,
    order_id int not null,
    payment_mode varchar(20) not null,
    discount_id int not null,
    foreign key(discount_id) references discounts(discount_id),
    foreign key(order_id) references orders(order_id)
);

-- 29
Create Table Shelf_Details  
(  
    Shelf_id int PRIMARY KEY,  
    Shelf_No int not null,  
	book_id varchar(20),
	foreign key(book_id) references books(book_id)
);
    
-- 30
create table alertTo(
	alert_id INT AUTO_INCREMENT primary key,
    customer_email varchar(20) not null,
    date_of_alert_request varchar(20) not null,
    author_name varchar(20) not null,
    customer_id int not null,
    author_id varchar(20) not null,
    foreign key(customer_id) references customers(customer_id),
    foreign key(author_id) references authors(author_id)
);

-- 32
Create table visitor(
visitor_id int primary key not null, 
visitor_name varchar(20) not null,
Intime datetime,
Outtime datetime,
Duration_in_mins int
);

-- 33
create table customer_feedback(
	feedback_id INT AUTO_INCREMENT primary key,
    feedback_message varchar(20) not null,
    feedback_datetime DATETIME not null DEFAULT now(),
    book_name varchar(50) not null,
    book_id varchar(20) not null,
    foreign key(book_id) references books(book_id)
);

-- 34
create table replacement(
	replacement_id INT AUTO_INCREMENT primary key,
    reason varchar(20) not null,
    replacement_datetime DATETIME not null ,
    order_id int not null,
    shipping_id int not null,
    shipping_address varchar(20) not null,
    foreign key(order_id) references orders(order_id),
    foreign key(shipping_id) references shipping(shipping_id)
);

show tables; 
describe tables;
-- ------------------------------------------------ Dummy Data ------------------------------------------------

-- insert into authors(author_id, author_name, author_email, author_commission) values ('A1', 'William', 'William@gmail.com', 0.2);
-- insert into authors values ('A2', 'George R.', 'GeorgeR.@gmail.com', 0.1);
-- insert into authors values ('A3', 'Tiago S.', 'Tiago@gmail.com', 0.3);
-- insert into authors values ('A4', 'Stephen King', 'Stephen@gmail.com', 0.25);
-- insert into authors values ('A5', 'J.K. Rowling', 'Rowling@gmail.com', 0.15);
-- insert into authors values ('A6', 'J.R.R. Tolkien', 'Tolkien@gmail.com', 0.2);
-- insert into authors values ('A7', 'George Lucas', 'GeorgeLucas@gmail.com', 0.1);

-- insert into books(book_id, book_name, book_type, author_id, book_price, book_stock) values ('B1', 'Snow White', 'Romance', 'A1', 20, 500);
-- insert into books values ('B2', 'Junkie', 'Psychology', 'A1' , 30 , 300);
-- insert into books values ('B3', 'Romeo and Julliet', 'Romance', 'A1' , 25 , 400);
-- insert into books values ('B4', 'Song of Ice and Fire', 'Fantasy', 'A2' , 26 , 200);
-- insert into books values ('B5', 'Total War', 'Action', 'A2' , 15 , 130);
-- insert into books values ('B6', 'Data Design', 'Learning', 'A3' , 100 , 300);
-- insert into books values ('B7', 'It', 'Horror', 'A4' , 18 , 200);
-- insert into books values ('B8', 'Harry Potter Collection', 'Fantasy and Drama', 'A5' , 20 , 300);
-- insert into books values ('B9', 'The lord of Rings', 'Fantasy', 'A6' , 21 , 150);
-- insert into books values ('B10', 'Star Wars', 'Science Fiction', 'A7' , 20 , 300);

-- insert into customers(customer_name, customer_address, customer_phone) values ('Cestar School', 'L6G 0W5', '647_XXXXX01');
-- insert into customers(customer_name, customer_address, customer_phone) values ('Bill Company', 'L0G 0W1', '647_XXXXX02');
-- insert into customers(customer_name, customer_address, customer_phone) values ('James', 'A37 4L1', '647_XXXXX03');
-- insert into customers(customer_name, customer_address, customer_phone) values ('David', 'L1F 4P5', '647_XXXXX04');
-- insert into customers(customer_name, customer_address, customer_phone) values ('Josh', 'F1R 0R1', '647_XXXXX05');
-- insert into customers(customer_name, customer_address, customer_phone) values ('Thomas', 'G1H 0R1', '647_XXXXX06');
-- insert into customers(customer_name, customer_address, customer_phone) values ('Fake', 'K1L 9K1', '647_XXXXX07');
-- insert into customers(customer_name, customer_address, customer_phone) values ('Lambton College', 'P1L 4W1', '647_XXXXX08');
-- insert into customers(customer_name, customer_address, customer_phone) values ('Jane', 'M1F M47', '647_XXXXX09');
-- insert into customers(customer_name, customer_address, customer_phone) values ('Tim', 'L01 PG3', '647_XXXXX10');

-- insert into orders(customer_id, book_id, store_id, order_quantity) values (1, 'B3', 'S1' , 2);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 3 , 'B3', 'S1' , 1);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 2 , 'B1', 'S1' , 2);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 4 , 'B4', 'S1' , 3);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values (5 , 'B6', 'S1' , 1);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values (6 , 'B2', 'S1' , 1);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values (7 , 'B4', 'S1' , 2);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values (7 , 'B6', 'S1' , 3);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values (7 , 'B3', 'S1' , 1);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 8 , 'B6', 'S1' , 50);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 8 , 'B3', 'S1' , 35);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 9 , 'B4', 'S1' , 50);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 9, 'B7', 'S1' , 40);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values (9, 'B10', 'S1' , 35);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values ( 10 , 'B1', 'S1' , 35);
-- insert into orders(customer_id, book_id, store_id, order_quantity) values (10 , 'B2', 'S1' , 35);

-- insert into bookstore(store_id, store_name, store_address ) values ('S1', 'Dave book store', 'Q03 EY3');
