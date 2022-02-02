show databases;
use zhuravel;
show tables;
select * from client;
-- 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів. 
select * from client where FirstName < 6;
-- 2.Вибрати львівські відділення банку.
select * from client where city = 'lviv';
-- 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
select LastName from client where education = 'high';
-- 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
select * from application order by idApplication desc limit 5;
-- 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
select * from client where LastName like '%ov' or '%ova';
-- 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями.
select idClient, FirstName, LastName, DepartmentCity 
from client
	join department d on d.idDepartment = client.Department_idDepartment
    where DepartmentCity = 'Kyiv';
-- 7.Знайти унікальні імена клієнтів.
select distinct firstname, lastname 
from client;
-- 8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
select distinct client.*
from client 
	join application a on a.Client_idClient=client.idClient
    where sum > 5000 and Currency = 'Gryvnia';
-- 9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
select count(*) as kilkist
from client
	left join department d on d.idDepartment = client.idClient;
    
select count(*) as kilkist
from client
	join department d on d.idDepartment = client.idClient
    where d.DepartmentCity like 'lviv';

-- 10.Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
select max(sum) as max_credit, client.*
 from client
	join application a on client.idClient=a.idApplication
    group by idClient, FirstName, LastName;

-- 11. Визначити кількість заявок на крдеит для кожного клієнта.
select count(*) as count, idClient, FirstName, LastName
from client
	join application a on a.idApplication=client.idClient
    group by idClient, FirstName, LastName;
-- 12. Визначити найбільший та найменший кредити.
select max(sum), min(sum) from application;
-- 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
select count(*),  idClient, FirstName, LastName
 from client 
	join application a on a.Client_idClient = client.idClient
    where Education = 'high' 
    group by  idClient, FirstName, LastName;
    
-- 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
select avg(sum) as avg, idClient, FirstName, LastName
from client 
	join application a on a.idApplication=client.idClient
    group by idClient, FirstName, LastName
    order by avg desc limit 1;
    
-- 15. Вивести відділення, яке видало в кредити найбільше грошей
select sum(sum) as sum, idDepartment, DepartmentCity
from department
	join client c on c.Department_idDepartment = department.idDepartment
    join  application a on a.Client_idClient = c.idClient
    group by idDepartment, DepartmentCity
    order by sum desc 
    limit 1;
    
-- 16. Вивести відділення, яке видало найбільший кредит.
select max(sum) as max, idDepartment, DepartmentCity
from department
	join client c on c.Department_idDepartment = department.idDepartment
    join application a on a.Client_idClient = c.idClient
    group by idDepartment, DepartmentCity
    order by max desc 
    limit 1;
    
-- 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
update application 
	join client c on c.idClient = application.Client_idClient
	set Sum = 6000
    where Education = 'high';
    
select (sum) Education, FirstName -- перевірив
from client 
join department d on d.idDepartment = client.idClient
join application a on a.Client_idClient = client.idClient
where Education = 'high';
-- 18. Усіх клієнтів київських відділень пересилити до Києва.
update client 
join department d on d.idDepartment = client.Department_idDepartment
set City = 'Kyiv'
where DepartmentCity = 'Kyiv';
-- 19. Видалити усі кредити, які є повернені.
delete application
from application
where CreditState = 'Returned';
-- 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
delete application
from application 
	join client c on c.idClient = application.Client_idClient
where LastName regexp '^.[eyuoa].*'; -- це я звісно підглянув ))
    
-- 21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
select sum(sum), idDepartment, DepartmentCity
	from department
		join client c on c.Department_idDepartment = department.idDepartment
        join application a on a.Client_idClient = c.idClient
	where DepartmentCity = 'Lviv'
    and sum > 5000
    group by idDepartment, DepartmentCity;

-- 22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
select * 
from client 
	join application a on a.Client_idClient = client.idClient
    where CreditState = 'returned'
    and sum > 5000;

-- 23.Знайти максимальний неповернений кредит.
select max(sum) as sum, FirstName, Age, CreditState
from client 
	join application a on a.Client_idClient = client.idClient
    where CreditState = 'not returned'
    group by FirstName, Age, CreditState
    order by sum desc 
    limit 1;

-- 24.Знайти клієнта, сума кредиту якого найменша
select * , sum
from client
	join application a on a.Client_idClient = client.idClient
order by Sum desc 
limit 1;

select * from client;
select * from application;
select * from department;
-- 25.Знайти кредити, сума яких більша за середнє значення усіх кредитів

-- 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів

-- 27. Місто клієнта з найбільшою кількістю кредитів
