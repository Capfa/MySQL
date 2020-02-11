-- 1 ТЕКСТОВОЕ ОПИСАНИЕ И СКРИПТЫ СОЗДАНИЯ СТРУКТУРЫ БД:

-- База данных создана на примере сайта по сдаче-аренде недвижимости по всему миру. Одни и те же пользователи могут быть как клиентами, так и хозяевами. Жилье для аренды можно подбирать исходя из местоположения,типа жилья, требуемых удобств и т.д .Для совершения сделки личность каждого пользователя подтверждается документами, информация о которых содержится в базе сайта.
-- Так же у клиента на сайте есть счет, с которого списываются деньги при подтверждении бронирования у клиентов, и на который зачисляются деньги при подтверждении получения услуги клиентом. С этого же счета сайт взымает комиссию за услуги с клиента и арендодателя при каждом подтвержденном бронировании.
-- Клиенты оставляют оценки и комментарии о снимаемом жилье, а так же могут прикреплять к отзыву фотографии. Клиенты могут делать закладки на заинтересовавшие их предложения, чтобы принять решение после.

DROP DATABASE IF EXISTS kurs;
CREATE DATABASE kurs;
USE kurs;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50), 
    email VARCHAR(120) UNIQUE,
    phone BIGINT unique,
    INDEX users_phone_idx(phone), 
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
	id SERIAL PRIMARY KEY,
    language_ VARCHAR(50)
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    INDEX user_id(user_id)
 );


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    user_id SERIAL PRIMARY KEY,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    language_1_id BIGINT UNSIGNED NOT NULL,
    language_2_id BIGINT UNSIGNED  NULL,
    language_3_id BIGINT UNSIGNED  null,
    INDEX language_id_idx(language_1_id,language_2_id,language_3_id),
    FOREIGN KEY (language_1_id) references languages(id),
    FOREIGN KEY (language_1_id) references languages(id),
    FOREIGN KEY (language_1_id) references languages(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS account;
CREATE TABLE account (
    id SERIAL PRIMARY KEY, 
	user_id  BIGINT UNSIGNED NOT NULL,
	bank_card_N BIGINT unsigned UNIQUE,
    resurs_on_account DECIMAL(11,2) DEFAULT 0,
    INDEX user_id(user_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
     
 );


DROP TABLE IF EXISTS documents;
CREATE TABLE documents (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	document_type VARCHAR(50),
	documet_series VARCHAR(50),
	document_number VARCHAR(50),
  	issue_date DATE,
    metadata JSON,
    CONSTRAINT users_doc UNIQUE (documet_series,document_number),
    INDEX user_id(user_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
 );



DROP TABLE IF EXISTS adress;
CREATE TABLE adress (
	id SERIAL PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    post_index INT UNSIGNED NOT NULL,
    city VARCHAR(50)  NOT NULL,
    street VARCHAR(120) NOT NULL,
    house VARCHAR(50)  NOT NULL,
    apartment VARCHAR(50) , 
    coordinates VARCHAR(50),
    CONSTRAINT full_adress UNIQUE (country,city,street,house, apartment,coordinates),
    INDEX (country),
    INDEX (city)
);


DROP TABLE IF EXISTS house_type;
CREATE TABLE house_type (
	id SERIAL PRIMARY KEY,
    type_name VARCHAR(50)
 );



DROP TABLE IF EXISTS places;
CREATE TABLE places (
	id SERIAL PRIMARY KEY,
	place_name VARCHAR(120) not null,
    host_user_id BIGINT UNSIGNED NOT NULL,
    adress_id BIGINT UNSIGNED NOT NULL,
    house_type_id BIGINT UNSIGNED NOT NULL,
    photo1_id BIGINT UNSIGNED NOT NULL,
    photo2_id BIGINT UNSIGNED,
    photo3_id BIGINT UNSIGNED,
    price_for_1_night DECIMAL(11,2),
    max_gosts_quantity INT UNSIGNED NOT NULL,
    rooms_quantity int UNSIGNED NOT NULL,
    bads_quantity int UNSIGNED NOT NULL,
    bathroom_quantity int UNSIGNED NOT NULL,
    animals_allowed BIT DEFAULT 0,
    kitchen BIT DEFAULT 0,
    washing_mashine BIT DEFAULT 0,
    conditioner BIT DEFAULT 0,
    parking BIT DEFAULT 0,
    TV BIT DEFAULT 0,
    Wi_Fi BIT DEFAULT 0,
    common_rating FLOAT(3,2),
    INDEX (host_user_id),
    INDEX (adress_id),
    INDEX (house_type_id),
    FOREIGN KEY (host_user_id) references users(id),
    FOREIGN KEY (adress_id) references adress(id),
    FOREIGN KEY (house_type_id) references house_type(id),
    FOREIGN KEY (photo1_id) references photos(id),
    FOREIGN KEY (photo2_id) references photos(id),
    FOREIGN KEY (photo3_id) references photos(id)
);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	id SERIAL PRIMARY KEY,
    client_user_id BIGINT UNSIGNED NOT NULL,
    place_id BIGINT UNSIGNED NOT NULL,
    check_in_date DATE,
    check_out_date DATE,
    gosts_quantity INT UNSIGNED NOT NULL,
    order_summ DECIMAL(11,2) DEFAULT 0,
    status  ENUM('requested', 'approved','declined'),
    created_at DATETIME DEFAULT NOW(),
    confirmed_at DATETIME,
    FOREIGN KEY (client_user_id) references users(id),
    FOREIGN KEY (place_id) references places(id)
);    



DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback(
	id SERIAL PRIMARY KEY,
	order_id BIGINT UNSIGNED NOT NULL,
	photo1_id BIGINT UNSIGNED,
	photo2_id BIGINT UNSIGNED,
	photo3_id BIGINT UNSIGNED,
    client_user_id BIGINT UNSIGNED NOT NULL,
    place_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    average_rating FLOAT(2,2),
    location_rating INT(1),
    communication_rating INT(1),
    cleanliness_rating INT(1),
    comment TEXT,
    INDEX (client_user_id),
    INDEX (place_id),
    FOREIGN KEY (order_id) references orders(id),
    FOREIGN KEY (photo1_id) references photos(id),
    FOREIGN KEY (photo2_id) references photos(id),
    FOREIGN KEY (photo3_id) references photos(id)
  );
     
 
 

     
DROP TABLE IF EXISTS comission;
CREATE TABLE comission(
	order_id SERIAL PRIMARY KEY,
    percent DECIMAL(2,2) NOT NULL,
    comission_sum DECIMAL(11,2) DEFAULT 0,
    FOREIGN KEY (order_id) references orders(id)
);  

        
DROP TABLE IF EXISTS bookmarks;
CREATE TABLE bookmarks(
	client_user_id BIGINT UNSIGNED NOT NULL,
	place_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    PRIMARY KEY (client_user_id, place_id),
    FOREIGN KEY (client_user_id) references users(id),
    FOREIGN KEY (place_id) references places(id)
 );    


-- 2 СКРИПТЫ ЗАПОЛНЕНИЯ БД ДАННЫМИ:

insert INTO users (firstname, lastname,email,phone) VALUES
('Ivan','Petrov','petrov@mail.ru',10001001010),
('Petr','Ivanov','ivanov@mail.ru',10001002020),
('Lev','Lvov','lvov@mail.ru',10001002030),
('Lena','Lvova','lvova@mail.ru',10001002040),
('Vera','Smirnova','smirnova@mail.ru',10001002050),
('Liza','Kotova','kotovaa@mail.ru',10001002060),
('Petr','Lavrov','lavrov@mail.ru',10001002070),
('Joe','Black','black@mail.ru',10001002080),
('Mary','Braun','black88@mail.ru',10001002090),
('Jon','Smith','js@mail.ru',10001003090)
;

insert INTO languages (language_) values
('English'),
('Chinese'),
('Italian'),
('German'),
('Italian'),
('Russian'),
('Spanish'),
('Turkish'),
('Finnish'),
('Japanese')
;

insert INTO photos (user_id,filename,size) VALUES
(1,'fe.jpg',10),
(1,'de.jpg',12),
(1,'ee.jpg',11),
(1,'ef.jpg',12),
(2,'11.jpg',18),
(2,'12.jpg',18),
(2,'13.jpg',10),
(2,'14.jpg',10),
(2,'15.jpg',10),
(2,'16.jpg',10),
(3,'a.jpg',9),
(3,'b.jpg',19),
(3,'c.jpg',9),
(3,'d.jpg',6),
(3,'d.jpg',6),
(3,'d.jpg',6),
(4,'1d.jpg',10),
(4,'2d.jpg',10),
(4,'3d.jpg',10),
(5,'gh.jpg',16),
(5,'ght0.jpg',16),
(5,'ght1.jpg',14),
(5,'ght2.jpg',14),
(6,'jjk.jpg',10),
(7,'jkl.jpg',11),
(7,'jklr.jpg',18),
(7,'jklhr.jpg',17),
(7,'jklr.jpg',17),
(8,'00.jpg',14),
(9,'01.jpg',17),
(9,'02.jpg',17),
(9,'03.jpg',17),
(10,'10.jpg',17),
(10,'11.jpg',17),
(10,'12.jpg',17),
(10,'13.jpg',17)
;

insert INTO profiles (photo_id,created_at,language_1_id,language_2_id,language_3_id) values
(1, '2015-10-02',1,6,null),
(5, '2016-11-02',6,3,10),
(11,'2018-12-30',1,2,null),
(17,'2019-12-30',1,6,9),
(20,'2017-01-06',5,2,9),
(24,'2017-01-06',2,9,null),
(25,'2020-01-16',3,7,null),
(29,'2010-10-26',10,8,null),
(30,'2018-04-17',4,null,null),
(33,'2018-05-17',2,9,null)
;

insert INTO account (user_id,bank_card_N,resurs_on_account) values
(1,12345625,5000),
(2,35824963,1000),
(3,45624963,0),
(4,45788903,0),
(5,12367903,100),
(6,98067467,60000),
(7,56034683,70000),
(8,56903672,10000),
(9,89053676,500),
(10,8763672,3000)
;

insert INTO documents(user_id,document_type,documet_series,document_number,issue_date) values
(1,'pasport','40 03',145636,'2001-12-01'),
(2,'pasport','20 02',52336,'2001-02-01'),
(3,'pasport','A1',587412,'2004-01-01'),
(4,'pasport','EF',2547963,'2003-12-01'),
(5,'pasport','B',145636,'2002-09-01'),
(6,'pasport','A',45768,'2001-10-01'),
(7,'pasport','BC',45768,'2003-11-01'),
(8,'pasport','14C',256875335,'2003-02-01'),
(9,'pasport','C',656685,'2001-12-01'),
(10,'pasport','AB',35465325,'2000-12-01')
;

insert INTO adress(country,post_index,city,street,house, apartment) values
('Russia',123456,'St-Petersburg','str.Pribrezhnaya','18','15'),
('Russia',098765,'St-Petersburg','str.Lenina','1','1'),
('Russia',555555,'St-Petersburg','str.Lenina','10','1'),
('France',111111,'Paris','Rue de Rivoli','12/5','1H'),
('France',000000,'Paris','Faubourg Saint-Honore','5','3'),
('German',2222222,'Hamburg','GRINDELHOF','67','3'),
('German',333333,'Lubek','Dapenau','67',null)
;

insert INTO house_type (type_name ) VALUES
('Дом целиком'),
('Квартира целиком'),
('Отдельная комната'),
('Апартаменты'),
('Номер в отеле'),
('Место в хостеле'),
('Замок'),
('Землянка')
;

insert INTO places (place_name,host_user_id,adress_id,house_type_id,photo1_id,photo2_id,  photo3_id,price_for_1_night,max_gosts_quantity,rooms_quantity, bads_quantity,bathroom_quantity,animals_allowed, kitchen, washing_mashine,conditioner, parking,TV,Wi_Fi,common_rating ) VALUES
('A',1,1,2,2,3,4,200,3,2,3,1,0,1,1,0,0,1,1,0),
('B',2,2,4,6,7,8,300,4,1,4,1,1,1,1,1,0,1,1,0),
('C',2,3,3,9,10,null,150,2,1,4,1,1,1,1,1,0,0,1,0),
('D',3,4,1,12,13,14,2500,6,6,8,3,1,1,1,0,0,1,1,5.00),
('E',5,5,2,21,22,23,500,4,3,8,1,1,1,1,0,0,1,1,0),
('F',7,6,2,27,28,null,1000,4,2,3,2,0,1,0,1,0,1,1,0),
('G',10,7,1,36,35,34,1500,6,3,3,3,1,1,1,1,1,1,1,0)
;

insert INTO orders (client_user_id,place_id,check_in_date,check_out_date,gosts_quantity,order_summ,status,confirmed_at) values
(4,1,'2020-02-20','2020-02-28',2,0,'approved','2020-02-10');

insert INTO orders (client_user_id,place_id,check_in_date,check_out_date,gosts_quantity,order_summ,status,confirmed_at) values
(6,1,'2020-03-20','2020-03-28',1,0,'approved','2020-02-10')
;

insert into feedback (order_id,client_user_id,place_id,comment) values
(1,4,1,'dfghyju'),
(2,4,1,'trhj')
;







