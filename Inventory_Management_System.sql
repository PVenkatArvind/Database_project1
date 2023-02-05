use `inventory-management-system`;
create table brands( 
	bid int, 
	bname varchar(20) 
	); 
alter table brands add cid int ;
select * from brands;

alter table brands  add primary key(bid); 
create table inv_user( 	user_id varchar(20), 
	name varchar(20), 
	password varchar(20), 
	last_login timestamp, 
	user_type varchar(10) 
	); 
alter table inv_user modify user_id varchar(35);
alter table inv_user modify  last_login date;
alter table inv_user add emp_salary int ;
create table categories( 
	cid int, 
	category_name varchar(20) 
	); 
    
alter table categories add primary key(cid);
alter table inv_user add primary key (user_id); 
drop table product;
create table product( 
	pid int primary key, 	cid int references categories(cid), 
	bid int references brands(bid), 
	sid int, 
	pname varchar(20), 
	p_stock int,
	price int , 
	added_date date); 
select * from product;
create table stores( 
	sid int, 
	sname varchar(20), 
	address varchar(20), 
	mobno int
	); 
    
alter table stores add primary key(sid) ;
alter table stores modify mobno bigint;
alter table product add foreign key(sid) references stores(sid); 

create table provides( 
	bid int references brands(bid), 
	sid int references stores(sid), 
	discount int); 

 create table customer_cart( 
	cust_id int primary key, 
	name varchar(20), 
	mobno int 
	); 
alter table customer_cart modify mobno bigint;
alter table customer_cart add pid int ;
alter table customer_cart add foreign key (pid) references product(pid);
alter table customer_cart add cart_quantity int ;
create table select_product( 	 
	cust_id int references customer_cart(cust_id), 
	pid int references product(pid), 
	quantity int 
	);
    
create table transaction( 
	id int primary key, 
	total_amount int, 
	paid int, 
	due int, 
	gst int, 
	discount int, 
	payment_method varchar(10), 
	cart_id int references customer_cart(cust_id) 
	); 
alter table transaction modify paid bigint  ;
alter table transaction add prod_name varchar(30) ;
alter table transaction add quantity int ;

 create table invoice( 
	item_no int, 
	product_name varchar(20), 
	quantity int, 
	net_price int, 
	transaction_id int references transaction(id) 
	); 
    
alter table invoice add payment_method varchar(10);
alter table invoice add balance_due int;
INSERT INTO `inv_user` (`user_id`, `name`, `password` ,`last_login`, `user_type`,`emp_salary`) VALUES
('pranavshankar@gmail.com','Pranav Shankar' , '1234' , '2022-10-15' , 'admin' , '80000'),
('pvarvind@gmail.com','P Venkat Arvind' , 'boss' , '2022-10-16' , 'manager', '150000'),
('rahul@gmail.com','Rahul' , '4321' , '2022-10-17' , 'accountant' ,'100000'),
('shivshankar@gmail.com','shivShankar' , '1234' , '2022-10-15' , 'admin','75000' ),
('prashant@gmail.com','Prashant' , '1234' , '2022-10-15' , 'admin', '50000' ),
('shreyas@gmail.com','shreyas' , '1234' , '2022-10-15' , 'sales', '30000' ),
('vinayakar@gmail.com','vinayaka' , '1234' , '2022-10-15' , 'sales','40000' ),
('keshav@gmail.com','keshav' , '4321' , '2022-10-16' , 'accountant','80000' ),
('upendra@gmail.com','upendra' , '4321' , '2022-10-17' , 'accountant','60000' );

select * from inv_user;
INSERT INTO `brands` (`bid`, `bname`,`cid`) VALUES
('1' , 'Apple','1' ),
('2' , 'Samsung' ,'1'),
('3' , 'Tesla' , '4'),
('4' , 'Nike' ,'2' ),
('5' , 'uspolo' , '2'),
('6' , 'lays' ,'3' ),
('7' , 'fortune','3');

INSERT INTO `categories` (`cid`, `category_name`) VALUES
('1' , 'Electronics' ),
('2' , 'clothing' ),
('3' , 'Grocery' );


INSERT INTO `stores` (`sid`, `sname`,`address`,`mobno`) VALUES
('1' , 'chroma' , 'Bangalore',9612345678),
('2' , 'Westside','Chennai' ,9787654321),
('3' , 'fresh organics','Hyderabad', 9876543210);

INSERT INTO `product` (`pid`, `cid`,`bid`,`sid` ,`pname`,`p_stock`,`price`,`added_date`,`cost_price` ) VALUES
('1','1','1','1','Iphone','4' , '80000','2022-10-10','60000'),
('2','1','1','1','Airpods','3','19000','2022-10-11','13000'),
('3','1','2','1','smartwatch','4' , '19000','2022-10-12','10000'),
('4','2','4','2','Airmax','6','7000','2022-10-11','5500'),
('5','3','5','3','Refined oil' , '10','750','2022-10-13','500');

select * from product;



select * from select_product ;
INSERT INTO `provides` (`bid`, `sid` ,`discount`) VALUES
('1' , '1' , '12'),
('2' , '2','7' ),
('3' , '3','15' ),
('1' , '2','7' ),
('4' , '3','20' ),
('4' , '2','9' );

INSERT INTO `customer_cart` (`cust_id`, `name` ,`mobno`,`pid`,`cart_quantity`) VALUES
('1' , 'Ram' , '9866332211','1','1'),
('2' , 'Vijay','9363475612','2' ,'1'),
('3' , 'Chandan','9686231288','3','1' );
select * from customer_cart;
INSERT INTO `select_product` (`cust_id`, `pid` ,`quantity`) VALUES
('1' , '2' , '2'),
('1' , '3','1' ),
('3' , '2','1' ),
('2' , '3','3' );

INSERT INTO `transaction` (`id`, `total_amount` ,`paid`,`due`,`gst`,`discount`,
`payment_method`,`cart_id`, `quantity`,`prod_name`)
VALUES
('1','7000','2000','5000','350','350','card','1','1','Airmax'),
('2','80000','80000','0','800','800','cash','2','1','iphone'),
('3','19000','2000','19000','190','190','cash','3','1','smartwatch'),
('4','80000','80000','0','800','800','cash','2','1','iphone'),
('5','19000','19000','0','100','190','cash','3','1','smartwatch');

select * from invoice;

# This displays the amount and amount paid where due is pending 

SELECT total_amount, paid ,id 
FROM transaction
where due > 0;

select * from transaction;


select * from select_product;
select * from product;
select * from brands;
select * from categories;

#This  calculates the profit 
SELECT distinct pname,p_stock, (p_stock*price-
p_stock*cost_price) as profit FROM product ,
(SELECT SUM(p_stock) ,SUM(price)
FROM product
GROUP BY pid ) as profit 
NATURAL JOIN select_product 
having p_stock > 3 order by profit desc  ;

#Displays the employee(Accountant) salary 
SELECT  name,user_type , emp_salary,
MAX(emp_salary)
FROM inv_user
WHERE user_type = 'accountant'
GROUP BY name 
having emp_salary > 60000;


select * from transaction;

#Displays the brands in electronics category

select bname
 from brands join categories on brands.cid = categories.cid 
 where category_name = 'Electronics' order by bname asc ; 
 
 select bname 
from brands join categories on brands.cid = categories.cid 
where category_name = 'clothing' order by bname desc;
select * from categories;
select * from stores;
select * from brands natural join categories where cid = cid;

select * from brands left outer join categories on brands.cid=categories.cid;
 select bname 
from brands join categories on brands.cid = categories.cid 
where category_name = 'clothing' order by bname desc;


SELECT  cid FROM brands WHERE bid='1' or '2'
union 
SELECT  cid FROM brands WHERE bid='6' or '7';

SELECT  cid FROM brands WHERE bid='1' or '2'
union all 
SELECT  cid FROM brands WHERE bid='6' or '7';



SELECT  category_name FROM categories WHERE cid='1'
UNION
SELECT  category_name FROM categories WHERE cid='2';

#4a nested emp who are not boss

select * from brands natural join categories where cid = cid;

select * from brands;
select bname from brands as b where b.cid not in (select brands
.cid from brands join categories on brands.cid=categories.cid  and category_name like 'Electronics'); 
 
#correlated 

SELECT  name,user_type , emp_salary
FROM inv_user
WHERE user_type = 'accountant'
GROUP BY name 
having emp_salary > 60000;

select bname  from brands where 
not exists ( select * from categories where brands.cid = categories.cid);

select * from transaction;

# Trigger that generates bill inserts the data to invoice table (billing) 

CREATE TRIGGER `Billing` AFTER INSERT ON `transaction` 
FOR EACH ROW INSERT INTO invoice 
VALUES(NEW.cart_id,NEW.prod_name,NEW.quantity,
 NEW.total_amount,NEW.id,NEW.payment_method,NEW.due);
 
select * from invoice;
drop procedure cust_cartinfo;

#This Stored Procedure places the product in the customers cart 
#Maintains the record of the store

DELIMITER $$
create procedure cust_cartinfo (in pid INT , in quantity int)
BEGIN 
declare currquant int ;
set currquant = (select p_stock from product as p where p.pid = pid);
update product as p set p_stock = currquant - quantity where p.pid = pid;
END$$
CALL cust_cartinfo(1,1);

select * from product;

#Trigger that generates warning if stock gets over 
DELIMITER $$  
CREATE TRIGGER before_update_checking
BEFORE UPDATE  
ON product FOR EACH ROW  
BEGIN  
    DECLARE error_msg VARCHAR(255);  
    SET error_msg = ('stock over!!');  
    IF new.p_stock <0 THEN  
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END $$

#product to cust_cart
select * from product;
UPDATE product SET p_stock = 0 WHERE pid = 1;
