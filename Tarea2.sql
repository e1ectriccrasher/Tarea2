-- Obtener un reporte de edades de los empelados para checar su elegibilidad para sguro de gastos medicos menores

select e.first_name , e.last_name , age(now(),e.birth_date )
from employees e;

-- Cual es el orden mas reciente por cliente

select max(o.order_date) , c.company_name 
from orders o 
join customers c on o.customer_id = c.customer_id 
group by c.company_name;

-- De nuestros clientes, qué función desempeñan y cuántos son?

select count(c.customer_id), c.contact_title 
from customers c 
group by c.contact_title;

-- Cuántos productos tenemos de cada categoría?

select c.category_id ,count(p.product_id), c.category_name
from products p 
join categories c ON p.category_id =c.category_id 
group by c.category_name, c.category_id 
order by c.category_id asc;

--Cómo podemos generar el reporte de reorder?

select p.product_name , od.unit_price , od.product_id , od.order_id, c.customer_id , c.company_name 
from order_details od 
join orders o on od.order_id = o.order_id 
join customers c on o.customer_id = c.customer_id
join products p on od.product_id = p.product_id;

-- A donde va nuestro envío más voluminoso?

select max(od.quantity), c.city 
from order_details od 
join orders o on od.order_id = o.order_id 
join customers c on o.customer_id = c.customer_id 
group by c.city 
order by max(od.quantity) desc
limit 1

-- Cómo creamos una columna en customers que nos diga si un cliente es bueno, regular, o malo?

alter table customers 
add rate char(3);

--Qué colaboradores chambearon durante las fiestas de navidad?
-- no se si colaboradores se refiere a supliers o a employee, supongamos que es employee
-- depende de la empresa que dias de vacaciones va dar en navidad no hay un estandar

select o.shipped_date 
from orders o 


select e.employee_id 
from employees e 
join orders o on e.employee_id = o.employee_id 
where (o.shipped_date between '1996-12-23' and '1996-12-25') 
or (o.shipped_date between '1997-12-23' and '1997-12-25') 
or (o.shipped_date between '1996-12-23' and '1996-12-25')
group by e.employee_id 

--Qué productos mandamos en navidad?
select p.product_id, o.shipped_date 
from products p 
join order_details od on p.product_id =od.product_id 
join orders o on od.order_id = o.order_id 
where (o.shipped_date = '1996-12-25') or (o.shipped_date = '1997-12-25') or (o.shipped_date = '1998-12-25') 

-- Qué país recibe el mayor volumen de producto?

select o.ship_country , max(od.quantity)
from orders o 
join order_details od on o.order_id  = od.order_id 
group by o.ship_country 
order by max(od.quantity) desc 
limit 1
