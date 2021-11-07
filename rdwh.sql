drop database Bookstore;
create database Bookstore;
use Bookstore;
-- drop database Bookstore;

 -- 1
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(20) NOT NULL
);

-- 2
CREATE TABLE state (
    state_id INT AUTO_INCREMENT PRIMARY  KEY,
    state_name VARCHAR(25) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country (country_id)
);

-- 3
CREATE TABLE city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(20) NOT NULL,
    state_id INT NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (state_id) REFERENCES state (state_id),
    FOREIGN KEY (country_id) REFERENCES country (country_id)
);

-- 4
CREATE TABLE authors (
    author_id VARCHAR(20) PRIMARY KEY,
    author_name VARCHAR(20) NOT NULL,
    author_email VARCHAR(30) NOT NULL,
    author_city INT NOT NULL,
    author_commission DOUBLE NOT NULL,
    FOREIGN KEY (author_city)
        REFERENCES city (city_id)
);

-- 5
CREATE TABLE language_of_book (
    language_of_book_id INT AUTO_INCREMENT PRIMARY KEY,
    language_of_book_name VARCHAR(20) NOT NULL
);

-- 6
CREATE TABLE book_quality (
    book_quality_id INT AUTO_INCREMENT PRIMARY KEY,
    book_quality_name VARCHAR(20) NOT NULL
);
-- 24
create table book_type(
book_type_id int not null auto_increment primary key,
book_type_name varchar(20) not null
);

-- alter table books modify book_type int NOT NULL;
-- alter table books add constraint book_type foreign key (book_type) references book_type(book_type_id);

-- 7
CREATE TABLE books (
    book_id VARCHAR(20) PRIMARY KEY DEFAULT 'B100',
    book_name VARCHAR(50) NOT NULL,
    book_type int NOT NULL,
    author_id VARCHAR(20) NOT NULL,
    book_price INT NOT NULL,
    book_language_id INT NOT NULL,
    book_stock INT NOT NULL,
    book_status INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors (author_id),
    FOREIGN KEY (book_language_id) REFERENCES language_of_book (language_of_book_id),
    FOREIGN KEY (book_status) REFERENCES book_quality (book_quality_id),
    foreign key (book_type) references book_type(book_type_id)
);

-- alter table bookstore add city_id int not null;
-- alter table bookstore add constraint city_id foreign key (city_id) references city(city_id);
-- 8
CREATE TABLE bookstore (
    store_id VARCHAR(20) PRIMARY KEY,
    store_name VARCHAR(30) NOT NULL,
    store_address VARCHAR(20) NOT NULL,
    no_of_books int8 not null,
	city_id INT not null,
    foreign key (city_id) references city(city_id)
);

-- alter table customers add customer_city_id int not null;
-- alter table customers add constraint customer_city_id foreign key (customer_city_id) references city(city_id);
-- 9
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(20) NOT NULL,
    customer_address VARCHAR(20) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL
);

-- alter table orders add column orders_customer_id int not null;
-- alter table orders add constraint orders_store_id foreign key (orders_store_id) references bookstore(store_id);
-- alter table orders add constraint orders_customer_id foreign key (orders_customer_id) references customers(customer_id);
-- 10
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME NOT NULL DEFAULT now(),
    customer_id VARCHAR(20) NOT NULL DEFAULT 1000000,
    book_id VARCHAR(20) NOT NULL DEFAULT 'B100',
    orders_store_id VARCHAR(20) NOT NULL DEFAULT 'S1',
    order_quantity VARCHAR(20) NOT NULL DEFAULT 0
    
);

-- 11
CREATE TABLE supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(20) NOT NULL,
    supplier_country_id VARCHAR(20) NOT NULL
);

-- 12
CREATE TABLE jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_level INT NOT NULL
);

-- 13
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    job_id INT NOT NULL,
    pub_id INT NOT NULL,
    hire_date DATETIME NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs (job_id)
);

-- 14
CREATE TABLE genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(20) NOT NULL
);

-- 15
CREATE TABLE wishlist (
    wishlist_id INT NOT NULL,
    wishlist_bookname VARCHAR(25) NOT NULL,
    wishlist_booktype VARCHAR(20) NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

create table discount_type(
	discount_type_id int auto_increment not null primary key,
    discount_type_name varchar(20) not null default 'percentage',
    discount_type_details varchar(40) not null
);
-- 16
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_date DATETIME NOT NULL DEFAULT now(),
    discount_type VARCHAR(20) NOT NULL DEFAULT 'percentage',
    discount_percentage FLOAT NOT NULL,
    book_id VARCHAR(20) NOT NULL DEFAULT 'B100',
    store_id VARCHAR(20) NOT NULL DEFAULT 'S1',
    order_quantity VARCHAR(20) NOT NULL DEFAULT 0,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (store_id) REFERENCES bookstore(store_id)
    -- FOREIGN KEY (order_quantity) REFERENCES orders (order_quantity)
);

create table distributors
(
distributors_id int Primary key Auto_increment not null,
distributors_name varchar(20) not null
);

create table vehicles(
	vehicle_id int not null primary key auto_increment,
    vehicle_type varchar(20) not null,
    vehicle_number varchar(25) not null
);
drop table vehicles;

create table drivers(
	driver_id int not null auto_increment ,
    driver_first_name varchar(25) not null,
    driver_last_name varchar(25) not null,
    driver_vehicle_id int not null,
    driver_phone_number int not null,
    primary key(driver_id, driver_vehicle_id),
    foreign key (driver_vehicle_id) references vehicles(vehicle_id)
);

drop table drivers;

create table transport( 
transport_vehicle_id int not null primary key,
transport_driver_id int not null,
transport_vehicle int not null,
foreign key (transport_vehicle) references vehicles(vehicle_id),
foreign key (transport_driver_id) references drivers(driver_id)
);

-- 17
CREATE TABLE shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    shipping_method VARCHAR(20) NOT NULL,
    shipping_date DATETIME NOT NULL DEFAULT now(),
    shipping_city VARCHAR(20) NOT NULL,
    cost FLOAT
);

drop table shipping;
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

-- 18
CREATE TABLE publishers (
    pub_id INT AUTO_INCREMENT PRIMARY KEY,
    pub_first_name VARCHAR(20) NOT NULL,
    pub_last_name VARCHAR(20) NOT NULL,
    city_id INT NOT NULL,
    zipcode INT NOT NULL,
    phone_number INT NOT NULL,
    book_id VARCHAR(20) NOT NULL DEFAULT 'B100',
    FOREIGN KEY (city_id) REFERENCES city (city_id),
    FOREIGN KEY (book_id)  REFERENCES books (book_id)
);

-- 19
CREATE TABLE titles (
    title_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    pub_id INT NOT NULL,
    price INT NOT NULL,
    royalty INT NOT NULL,
    FOREIGN KEY (pub_id)
        REFERENCES publishers (pub_id)
);

create table issue
(
issue_id int primary key not null,
issue_date date not null,
emp_id int not null,
Foreign key(emp_id) references employees(emp_id)
);

create table book_return(
return_id int not null AUTO_INCREMENT primary key,
return_date DATETIME not null DEFAULT now(),
customer_id int not null,
book_id varchar(20) NOT NULL DEFAULT 'B100',
issue_id int not null,
foreign key(customer_id) references customers(customer_id),
foreign key(book_id) references books(book_id),
foreign key(issue_id) references issue(issue_id)
);
-- 20
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    order_status VARCHAR(20) NOT NULL,
    tracking_id INT NOT NULL,
    shipping_id int not null,
    order_id INT not null,
    foreign key(shipping_id) references shipping(shipping_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- 21
drop table cart;
CREATE TABLE cart (
    cart_id INT NOT NULL primary key auto_increment,
    price INT NOT NULL,
    customer_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

-- 22
create table payments(
	payment_id INT AUTO_INCREMENT primary key,
    payment_mode varchar(20) not null
);

drop table transactions;

CREATE TABLE transactions (
    transaction_id INT NOT NULL primary key auto_increment,
    transaction_date DATE,
    amount DOUBLE NOT NULL,
    quantity INT NOT NULL,
    payment_mode int not null,
    order_id INT NOT NULL,
    discount_id int not null,
    foreign key(discount_id) references discounts(discount_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    foreign key (payment_mode) references payments(payment_id)
);

drop table sales;
-- 23
CREATE TABLE sales (
	sales_id int not null auto_increment,
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    payterms varchar(10) NOT NULL,
    book_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id),
	primary key(sales_id, book_id, order_id)
);

create table alertTo(
	alert_id INT AUTO_INCREMENT primary key,
    date_of_alert_request datetime not null,
    customer_id int not null,
    author_id varchar(20) not null,
    foreign key(customer_id) references customers(customer_id),
    foreign key(author_id) references authors(author_id)
);

create table account(
	account_id INT AUTO_INCREMENT primary key,
    shipping_id int not null,
    customer_id int not null,
    foreign key(customer_id) references customers(customer_id),
    foreign key(shipping_id) references shipping(shipping_id)
);

Create Table shelf_details  
(  
    shelf_id int not null PRIMARY KEY auto_increment,  
    shelf_number int not null,
	book_id varchar(20),
	foreign key(book_id) references books(book_id)
);

Create table visitor(
visitor_id int primary key not null auto_increment, 
visitor_name varchar(20) not null,
Intime datetime,
Outtime datetime,
Duration_in_mins int,
store_id varchar(20),
foreign key (store_id) references bookstore(store_id)
);

create table customer_feedback(
	feedback_id INT not null AUTO_INCREMENT primary key,
    feedback_message varchar(20) not null,
    feedback_datetime DATETIME not null DEFAULT now(),
    feedback_book_id varchar(20) not null,
    foreign key(feedback_book_id) references books(book_id)
);

create table replacement(
	replacement_id INT not null AUTO_INCREMENT primary key,
    replacement_reason varchar(100) not null,
    replacement_datetime DATETIME not null,
    replacement_order_id int not null,
    replacement_shipping_id int not null,
    foreign key(replacement_order_id) references orders(order_id),
    foreign key(replacement_shipping_id) references shipping(shipping_id)
);


-- ------------------------------------------------ Dummy Data ------------------------------------------------
insert into authors(author_id, author_name, author_email, author_commission) values ('A1', 'William', 'William@gmail.com', 0.2);
insert into authors values ('A2', 'George R.', 'GeorgeR.@gmail.com', 0.1);
insert into authors values ('A3', 'Tiago S.', 'Tiago@gmail.com', 0.3);
insert into authors values ('A4', 'Stephen King', 'Stephen@gmail.com', 0.25);
insert into authors values ('A5', 'J.K. Rowling', 'Rowling@gmail.com', 0.15);
insert into authors values ('A6', 'J.R.R. Tolkien', 'Tolkien@gmail.com', 0.2);
insert into authors values ('A7', 'George Lucas', 'GeorgeLucas@gmail.com', 0.1);



insert into books(book_id, book_name, book_type, author_id, book_price, book_stock) values ('B1', 'Snow White', 'Romance', 'A1', 20, 500);
insert into books values ('B2', 'Junkie', 'Psychology', 'A1' , 30 , 300);
insert into books values ('B3', 'Romeo and Julliet', 'Romance', 'A1' , 25 , 400);
insert into books values ('B4', 'Song of Ice and Fire', 'Fantasy', 'A2' , 26 , 200);
insert into books values ('B5', 'Total War', 'Action', 'A2' , 15 , 130);
insert into books values ('B6', 'Data Design', 'Learning', 'A3' , 100 , 300);
insert into books values ('B7', 'It', 'Horror', 'A4' , 18 , 200);
insert into books values ('B8', 'Harry Potter Collection', 'Fantasy and Drama', 'A5' , 20 , 300);
insert into books values ('B9', 'The lord of Rings', 'Fantasy', 'A6' , 21 , 150);
insert into books values ('B10', 'Star Wars', 'Science Fiction', 'A7' , 20 , 300);



insert into customers(customer_name, customer_address, customer_phone) values ('Cestar School', 'L6G 0W5', '647_XXXXX01');
insert into customers(customer_name, customer_address, customer_phone) values ('Bill Company', 'L0G 0W1', '647_XXXXX02');
insert into customers(customer_name, customer_address, customer_phone) values ('James', 'A37 4L1', '647_XXXXX03');
insert into customers(customer_name, customer_address, customer_phone) values ('David', 'L1F 4P5', '647_XXXXX04');
insert into customers(customer_name, customer_address, customer_phone) values ('Josh', 'F1R 0R1', '647_XXXXX05');
insert into customers(customer_name, customer_address, customer_phone) values ('Thomas', 'G1H 0R1', '647_XXXXX06');
insert into customers(customer_name, customer_address, customer_phone) values ('Fake', 'K1L 9K1', '647_XXXXX07');
insert into customers(customer_name, customer_address, customer_phone) values ('Lambton College', 'P1L 4W1', '647_XXXXX08');
insert into customers(customer_name, customer_address, customer_phone) values ('Jane', 'M1F M47', '647_XXXXX09');
insert into customers(customer_name, customer_address, customer_phone) values ('Tim', 'L01 PG3', '647_XXXXX10');



insert into orders(customer_id, book_id, store_id, order_quantity) values (1, 'B3', 'S1' , 2);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 3 , 'B3', 'S1' , 1);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 2 , 'B1', 'S1' , 2);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 4 , 'B4', 'S1' , 3);
insert into orders(customer_id, book_id, store_id, order_quantity) values (5 , 'B6', 'S1' , 1);
insert into orders(customer_id, book_id, store_id, order_quantity) values (6 , 'B2', 'S1' , 1);
insert into orders(customer_id, book_id, store_id, order_quantity) values (7 , 'B4', 'S1' , 2);
insert into orders(customer_id, book_id, store_id, order_quantity) values (7 , 'B6', 'S1' , 3);
insert into orders(customer_id, book_id, store_id, order_quantity) values (7 , 'B3', 'S1' , 1);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 8 , 'B6', 'S1' , 50);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 8 , 'B3', 'S1' , 35);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 9 , 'B4', 'S1' , 50);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 9, 'B7', 'S1' , 40);
insert into orders(customer_id, book_id, store_id, order_quantity) values (9, 'B10', 'S1' , 35);
insert into orders(customer_id, book_id, store_id, order_quantity) values ( 10 , 'B1', 'S1' , 35);
insert into orders(customer_id, book_id, store_id, order_quantity) values (10 , 'B2', 'S1' , 35);



insert into bookstore(store_id, store_name, store_address ) values ('S1', 'Dave book store', 'Q03 EY3'); drop database if exists Bookstore;
 