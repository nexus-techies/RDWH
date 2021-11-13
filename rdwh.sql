-- ---------------------------------------------------------------------------------
-- Relational Data Warehousing Project, 2021
-- Bookstore Database Management System
-- The file includes the schema for SQL database management with various tables in it

-- Project by:
-- 1. Sampada Petkar
-- 2. Pooja Bornarkar
-- 3. Pratiksha Mete
-- 4. Priyanka Sargam
-- 5. Gauri Deshmukh
-- 6. Latika Sawant

-- ---------------------------------------------------------------------------------
drop database if exists bookstore_db;
create database bookstore_db;
use bookstore_db;

-- ---------------------------------------------------------------------------------
 -- 1: countries of members
CREATE TABLE country(
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(20) NOT NULL
);

-- 2: states of members corr to countries
CREATE TABLE state(
    state_id INT AUTO_INCREMENT PRIMARY  KEY,
    state_name VARCHAR(25) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country (country_id)
);

-- 3: cities of members corr to states and countries
CREATE TABLE city(
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(20) NOT NULL,
    state_id INT NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (state_id) REFERENCES state (state_id),
    FOREIGN KEY (country_id) REFERENCES country (country_id)
);

-- 4: book author details
CREATE TABLE authors(
    author_id VARCHAR(20) PRIMARY KEY,
    author_name VARCHAR(20) NOT NULL,
    author_email VARCHAR(30) NOT NULL,
    author_city INT NOT NULL,
    author_commission DOUBLE NOT NULL,
    FOREIGN KEY (author_city) REFERENCES city (city_id)
);

-- 5: book language details
CREATE TABLE language_of_book(
    language_of_book_id INT AUTO_INCREMENT PRIMARY KEY,
    language_of_book_name VARCHAR(20) NOT NULL
);

-- 6: book quality details like torn, second hand, imported etc.
CREATE TABLE book_quality(
    book_quality_id INT AUTO_INCREMENT PRIMARY KEY,
    book_quality_name VARCHAR(20) NOT NULL
);

-- 7: book types like hard cover, pdf, soft copy, loose bind, etc.
create table book_type(
book_type_id int not null auto_increment primary key,
book_type_name varchar(20) not null
);

-- 8: book genre like biography, fiction, travel, etc.
CREATE TABLE genre(
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(20) NOT NULL
);

-- 9: books table storing details about a book
CREATE TABLE books(
    book_id VARCHAR(20) PRIMARY KEY DEFAULT 'B100',
    book_name VARCHAR(50) NOT NULL,
    book_type int NOT NULL,
    author_id VARCHAR(20) NOT NULL,
    book_price INT NOT NULL,
    book_language_id INT NOT NULL,
    book_stock INT NOT NULL,
    book_status INT NOT NULL,
    books_genre_id INT NOT NULL,
    foreign key (book_type) references book_type(book_type_id),
    FOREIGN KEY (author_id) REFERENCES authors (author_id),
    FOREIGN KEY (book_language_id) REFERENCES language_of_book (language_of_book_id),
    FOREIGN KEY (book_status) REFERENCES book_quality (book_quality_id),
    foreign key (books_genre_id) references genre (genre_id)
);

-- 10: bookstore details
CREATE TABLE bookstore(
    store_id VARCHAR(20) not null PRIMARY KEY,
    store_name VARCHAR(30) NOT NULL,
    store_address VARCHAR(20) NOT NULL,
	city_id INT not null,
    foreign key (city_id) references city(city_id)
);

-- 11: customers related to the bookstore
CREATE TABLE customers(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(20) NOT NULL,
    customer_address VARCHAR(20) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    customer_city_id INT not null,
    customer_email_id varchar(20) not null,
    foreign key (customer_city_id) references city(city_id)
);

-- 12: orders placed in the bookstore
CREATE TABLE orders(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME NOT NULL DEFAULT now(),
    order_quantity VARCHAR(20) NOT NULL DEFAULT 0,
    orders_store_id VARCHAR(20) NOT NULL DEFAULT 'S1',
    orders_customer_id int not null,
    orders_book_id VARCHAR(20) DEFAULT 'B100',
    foreign key (orders_store_id) references bookstore(store_id),
    foreign key (orders_customer_id) references customers(customer_id),
    foreign key (orders_book_id) references books(book_id)
);

-- 13: suppliers for the bookstores
CREATE TABLE supplier(
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(20) NOT NULL,
    supplier_city_id INT not null,
    foreign key (supplier_city_id) references city(city_id)
);

-- 14: job posts in every bookstores
CREATE TABLE jobs(
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_level INT NOT NULL
);

-- 15: publishers of the books
CREATE TABLE publishers(
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

-- 16: employeers in the bookstore
CREATE TABLE employees(
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    job_id INT NOT NULL,
    pub_id INT NOT NULL,
    hire_date DATETIME NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs (job_id),
    foreign key (pub_id) references publishers(pub_id)
);

-- 17: wishlist of the customers
CREATE TABLE wishlist(
    wishlist_id INT NOT NULL,
    wishlist_customer_id INT NOT NULL,
    wishlist_book_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (wishlist_customer_id) REFERENCES customers(customer_id),
    foreign key (wishlist_book_id) references books(book_id)
);

-- 18: discount types given on books like %, buy 2 get 1 free, etc
create table discount_type(
	discount_type_id int auto_increment not null primary key,
    discount_type_name varchar(20) not null default 'percentage',
    discount_type_details varchar(40) not null
);

-- 19: discount values and details
CREATE TABLE discounts(
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_date DATETIME NOT NULL DEFAULT now(),
    book_id VARCHAR(20) NOT NULL DEFAULT 'B100',
    store_id VARCHAR(20) NOT NULL DEFAULT 'S1',
    discount_type_id int not null,
    discounts_order_id int not null,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (store_id) REFERENCES bookstore(store_id),
    foreign key (discount_type_id) references discount_type(discount_type_id),
    foreign key (discounts_order_id) references orders(order_id)
);

-- 20: distributors of the books
create table distributors(
distributors_id int Primary key Auto_increment not null,
distributors_name varchar(20) not null
);

-- 21: vehicle details
create table vehicles(
	vehicle_id int not null primary key auto_increment,
    vehicle_type varchar(20) not null,
    vehicle_number varchar(25) not null
);

-- 22: driver details
create table drivers(
	driver_id int not null auto_increment ,
    driver_first_name varchar(25) not null,
    driver_last_name varchar(25) not null,
    driver_vehicle_id int not null,
    driver_phone_number int not null,
    primary key(driver_id, driver_vehicle_id),
    foreign key (driver_vehicle_id) references vehicles(vehicle_id)
);

-- 23: transport facilities for shipping books
create table transport( 
transport_vehicle_id int not null primary key,
transport_driver_id int not null,
transport_vehicle int not null,
foreign key (transport_vehicle) references vehicles(vehicle_id),
foreign key (transport_driver_id) references drivers(driver_id)
);

-- 24: shipping books and details
create table shipping(
	shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    shipping_method VARCHAR(20) NOT NULL,
    shipping_date DATETIME NOT NULL DEFAULT now(),
    cost FLOAT,
    shipping_city_id int not null,
    shipping_distributors_id int not null,
    shipping_vehicle_id int not null,
    foreign key (shipping_city_id) references city(city_id),
    foreign key (shipping_distributors_id) references distributors(distributors_id),
    foreign key (shipping_vehicle_id) references transport(transport_vehicle_id)    
);

-- 25: titles given to the authors like best seller, nov special, etc.
CREATE TABLE titles(
    title_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    pub_id INT NOT NULL,
    price INT NOT NULL,
    royalty INT NOT NULL,
    FOREIGN KEY (pub_id) REFERENCES publishers (pub_id)
);

-- 26: issues regarding books, shipping, etc.
create table issue(
	issue_id int primary key not null,
	issue_date date not null,
	emp_id int not null,
	Foreign key(emp_id) references employees(emp_id)
);

-- 27: returning book
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

-- 28: order placed and the status
CREATE TABLE order_status(
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    order_status VARCHAR(20) NOT NULL,
    tracking_id INT NOT NULL,
    shipping_id int not null,
    order_id INT not null,
    foreign key(shipping_id) references shipping(shipping_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- 29: carts of the customer
CREATE TABLE cart(
    cart_id INT NOT NULL primary key auto_increment,
    price INT NOT NULL,
    customer_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

-- 30: payment methods
create table payments(
	payment_id INT AUTO_INCREMENT primary key,
    payment_mode varchar(20) not null
);

-- 31: trasactions done across the store
CREATE TABLE transactions(
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

-- 32: sales done in the bookstore
CREATE TABLE sales(
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

-- 33: alterting system
create table alertTo(
	alert_id INT AUTO_INCREMENT primary key,
    date_of_alert_request datetime not null,
    customer_id int not null,
    author_id varchar(20) not null,
    foreign key(customer_id) references customers(customer_id),
    foreign key(author_id) references authors(author_id)
);

-- 34: accounts of people
create table account(
	account_id INT AUTO_INCREMENT primary key,
    shipping_id int not null,
    customer_id int not null,
    foreign key(customer_id) references customers(customer_id),
    foreign key(shipping_id) references shipping(shipping_id)
);

-- 35: in store shelf details
Create Table shelf_details(  
    shelf_id int not null PRIMARY KEY auto_increment,  
    shelf_number int not null,
	book_id varchar(20),
	foreign key(book_id) references books(book_id)
);

-- 36: visitor details to store
Create table visitor(
	visitor_id int primary key not null auto_increment, 
	visitor_name varchar(20) not null,
	Intime datetime,
	Outtime datetime,
	Duration_in_mins int,
	store_id varchar(20),
	foreign key (store_id) references bookstore(store_id)
);

-- 37: customer feedbacks
create table customer_feedback(
	feedback_id INT not null AUTO_INCREMENT primary key,
    feedback_message varchar(20) not null,
    feedback_datetime DATETIME not null DEFAULT now(),
    feedback_book_id varchar(20) not null,
    foreign key(feedback_book_id) references books(book_id)
);

-- 38: replacements of the books
create table replacement(
	replacement_id INT not null AUTO_INCREMENT primary key,
    replacement_reason varchar(100) not null,
    replacement_datetime DATETIME not null,
    replacement_order_id int not null,
    replacement_shipping_id int not null,
    foreign key(replacement_order_id) references orders(order_id),
    foreign key(replacement_shipping_id) references shipping(shipping_id)
);

-- ---------------------------------------------------------------------------------