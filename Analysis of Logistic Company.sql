create database Logistics;
use Logistics;

-- Q1) Select count of customers based on customer type?
select * from customer;
select c_type,count(c_type) as No_of_Customer from customer group by c_type;

-- Q2) Select branch wise count of emp in descending order of count?
select * from employee_details;
select e_branch,count(e_name) as No_of_Employee from employee_details group by e_branch order by No_of_Employee desc;

-- Q3) Select designation wise count of emp ID in descending order of count
select e_designation,count(e_id) as No_of_Employee_Id from employee_details group by e_designation order by No_of_Employee_Id desc;

-- Q4) Select Count of customer based on payment status in descending order of count?
select payment_status,count(c_id) as No_of_customer from payment_details group by payment_status order by No_of_customer desc;

-- Q5) Select Count of customer based on payment mode in descending order of count?
select payment_mode,count(c_id) as No_of_customer from payment_details group by payment_mode order by No_of_customer desc;

-- Q6) Select Count of customer based on shipment_domain in descending order of count?
select sh_domain,count(c_id) as No_of_customer from shipment_details group by sh_domain order by No_of_customer desc;

-- Q7) Find C_ID,M_ID and tenure for those customers whose membership tenure is over 10 years.Sort them in decreasing order of Tenure?
select * from membership;
select * from customer;
select c.c_id,m.m_id,round(datediff(m.End_date,m.start_date)/365,0) as tenure from membership m inner join customer c on c.m_id=m.m_id having tenure>10 order by tenure desc;

-- Q8) Find average payment amount based on Customer Type where payment mode as COD?
select c.c_type,avg(p.amount) as Average_Amount,p.payment_mode 
from customer c inner join payment_details p on c.c_id=p.c_id where p.payment_mode like "COD" group by c.c_type;

-- Q9) Find avg payment amount based on payment mode where payment date is not null?
select payment_mode,avg(amount) as Average_Amount from payment_details where
 payment_date is not null group by payment_mode;

-- Q10) Find sum of shipment charges based on payment_mode where service type is not regular?
select p.payment_mode,sum(s.sh_charges) as Total_Shipment_charges from
 payment_details p inner join shipment_details s  on p.c_id=s.c_id where s.ser_type!='regular' group by payment_mode;
 
-- Q11) Find avg shipment weight based on payment_status where shipment domain does not start with H?
select p.payment_status,avg(s.sh_weight) as Average_Shipment_weight from 
payment_details p inner join shipment_details s  on p.c_id=s.c_id where 
sh_domain not like"h%" group by p.payment_status;

-- Q12) Find mean of payment amount based on shipping domain where service type 
-- is Express and payment status is paid?
select s.sh_domain,avg(p.amount) as Average_Payment_Amount from 
payment_details p inner join shipment_details s  on p.c_id=s.c_id where 
s.ser_type  like"Express" and p.payment_status like "paid" group by s.sh_domain;

-- Q13) Find avg of shipment weight and shipment charges based on shipment status?
select s.current_status,avg(sh.sh_weight) as Average_shipment_weight,avg(sh.sh_charges) as Average_shipment_charges from
shipment_details sh inner join status s on  sh.sh_id = s.sh_id group by s.current_status;

-- Q14) Display Sh_ID, shipment status,shipment_weight and delivery date where 
-- shipment weight is over 100 and payment is done in Quarter 3?
select sh.sh_id,s.current_status,sh.sh_weight,s.delivery_date,p.payment_date from
shipment_details sh inner join status s on  sh.sh_id = s.sh_id inner join payment_details p on p.sh_id = s.sh_id
where sh.sh_weight>100 and month(p.payment_date) in (06,07,08);

-- Q15) Display Sh_ID, shipment charges and shipment_weight and sent date where 
-- current_status is Not delivered and payment mode is Card_Payment?
select p.sh_id,sh.sh_charges,sh.sh_weight,s.sent_date from
shipment_details sh inner join status s on  sh.sh_id = s.sh_id inner join payment_details p on p.sh_id = s.sh_id
where s.current_status like "Not Delivered" and p.payment_mode like "card_payment";

-- Q16) Select all records from shipment_details where shipping charges is greater than 
-- avg shipping charges for all the customers?
select * from shipment_details where sh_charges>(select avg(sh_charges) from shipment_details);

-- Q17) Find customer names, their email, contact,c_type and payment amount where C_type 
-- is either Wholesale or Retail
select c.c_name,c.c_email_id,c.c_cont_no,c.c_type,p.amount from
customer c inner join payment_details p on c.c_id=p.c_id 
where c.c_type in ("wholesale","retail");


