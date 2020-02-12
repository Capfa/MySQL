-- 6 СКРИПТЫ ХАРАКТЕРНЫХ ВЫБОРОК:

   -- 1 Выводит стоимость, точный адрес,тип жилья,титульное фото, стоимость и рейтинг. В условиях отбора название города и рейтинг квартиры. Сортировка по стоимости жилья
select 
place_name,price_for_1_night,street,house,apartment,type_name,p1.filename as photo1,common_rating
from places 
join house_type on house_type.id=places.house_type_id
join photos as p1 on places.photo1_id=p1.id
join adress on adress.id = places.adress_id
where adress.city = 'Paris' and common_rating > 3
order by price_for_1_night;


-- 2 Показывает коментарии с фото и оценкой выбраного места
select 
place_name,concat(firstname,' ',lastname) as comentators_name,p1.filename as photo1,p2.filename as photo2,p3.filename as photo3,comment,average_rating
from places 
join feedback on feedback.place_id=places.id
join users on feedback.client_user_id = users.id
left join photos as p1 on feedback.photo1_id=p1.id
left join photos as p2 on feedback.photo2_id=p2.id
left join photos as p3 on feedback.photo3_id=p3.id
-- where places.id=2
;

-- 3 Показывает доступное для аренды на выбраный период в выбраной стране жилье,где разрешено проживание с животными.

select
places.place_name ,adress.city
from
(SELECT 
   places.id as place_id -- places.adress_id as adress_id,
FROM places  
WHERE places.id NOT IN (
    SELECT DISTINCT
        orders.place_id
    FROM orders 
    WHERE orders.check_in_date >= '2020-01-10'
    AND orders.check_out_date <= '2020-04-28'
    AND orders.status = 'aproved'
)and places.animals_allowed=1) as filtred
join places on filtred.place_id=places.id
join adress on places.adress_id=adress.id where adress.country = 'German'
;
 