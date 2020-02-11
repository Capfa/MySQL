-- 6 СКРИПТЫ ХАРАКТЕРНЫХ ВЫБОРОК:

   -- Выводит стоимость, точный адрес,тип жилья,титульное фото, стоимость и рейтинг. В условиях отбора название города и рейтинг квартиры. Сортировка по стоимости жилья
select 
place_name,price_for_1_night,street,house,apartment,type_name,p1.filename as photo1,common_rating
from places 
join house_type on house_type.id=places.house_type_id
join photos as p1 on places.photo1_id=p1.id
join adress on adress.id = places.adress_id
where adress.city = 'Paris' and common_rating > 3
order by price_for_1_night;

-- Выводит имя и фамилию хозяина,все фото из описания, имеющиеся удобства, отзывы с рейтингами. Корявый. Не успела обдумать
select 
place_name,concat(firstname,' ',lastname) as hoster_name, p1.filename as photo1,p2.filename as photo2,p3.filename as photo3,comment, average_rating
from users
join places on users.id = places.host_user_id
join photos as p1 on places.photo1_id=p1.id
join photos as p2 on places.photo2_id=p2.id
left join photos as p3 on places.photo3_id=p3.id
left join feedback on places.id=feedback.place_id
;







 