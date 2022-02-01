show databases;
use zhuravel;
show tables;
select * from cars; -- глянув як посортовано 
-- найти все машины старше 2000 г
select * from cars where year > 2000;
-- найти все машины млатше 2015 г
select * from cars where year < 2015;
-- найти все машины 2008, 2009, 2010 годов
select * from cars where year in (2008,2009,2010);
-- найти все машины не с этих годов 2008, 2009, 2010 годов
select * from cars where year not in (2008,2009, 2010);
-- найти все машины год которых совпадает с ценой
select * from cars where year = price;
-- найти все машины bmw старше 2014 года 
select * from cars where model = 'bmw' and year = 2014;
-- найти все машины audi младше 2014 года
select * from cars where model = 'audi' and year < 2014;
-- найти первые 5 машин
select * from cars limit 5;
-- найти последнии 5 машин
select * from cars  order by id desc limit 5;
-- найти среднее арифметическое цен машин модели KIA
select avg(price) as 'середнє ариф' from cars where model = 'KIA';
-- найти среднее арифметическое цен каждой машины
select avg(price) as 'avg ALL cars'from cars;
-- посчитать количество каждой марки машин
select count(*), model from cars group by model;
-- найти марку машины количество которых больше всего
select count(*), as count model from cars group by model; -----
-- найти все машины в модели которых вторая и предпоследняя буква "а"
select * from cars where model like '_a%a__';
-- найти все машины модели которых больше 8 символов
select * from cars where length(model) = 8;
-- ***найти машины цена которых больше чем цена среднего арифметического всех машин
select avg(price) from cars where price > 3;
