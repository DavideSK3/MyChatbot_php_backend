CREATE TABLE users (
  fbid varchar(100) NOT NULL PRIMARY KEY ,
  token text NOT NULL,
  name varchar(50) NOT NULL
);

CREATE TABLE friends (
	id varchar(100) NOT NULL,
	friendid varchar(100) NOT NULL,
	installed boolean DEFAULT TRUE,
	PRIMARY KEY(id, friendid),
	FOREIGN KEY(id) REFERENCES users(fbid),
	FOREIGN KEY(friendid) REFERENCES users(fbid)
);

CREATE TABLE chats (
	chatid int(11) NOT NULL,
	chatname varchar(50) NOT NULL,
	participant varchar(100) NOT NULL,
	time timestamp NOT NULL,
	PRIMARY KEY (chatid,participant),
	FOREIGN KEY(participant) REFERENCES users(fbid)
);

CREATE TABLE messages (
	chatid int(11) NOT NULL,
	sender varchar(100) NOT NULL,
	content text NOT NULL,
	ismedia boolean DEFAULT FALSE,
	time timestamp NOT NULL,
	intent varchar(20),
	restaurant int(11),
	movie int(11),
	image varchar(200),
	day varchar(12),
	PRIMARY KEY(chatid,sender,time),
	FOREIGN KEY(chatid,sender) REFERENCES chats(chatid,participant)
);

CREATE TABLE restaurants (
	NOME varchar(100),
	DESCRIZIONE varchar(500), 
	ENGLISH_DESCRIPTION varchar(500),
	CATEGORIA varchar(50),
	LATITUDINE varchar(20),
	LONGITUDINE varchar(20),
	VIA varchar(50),
	NUMBER varchar(10),
	CAP varchar(10),
	CITTA varchar(20),
	CONTATTO_NOME varchar(100) DEFAULT "",
	CONTATTO_TELEFONO varchar(100) DEFAULT "",
	CONTATTO_EMAIL varchar(100) DEFAULT "",
	CONTATTO_FAX varchar(100) DEFAULT "",
	CONTATTO_URL varchar(100) DEFAULT "",
	ID int(11) PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE movies (
	name varchar(50),
	description varchar(200),
	length varchar(20),
	category varchar(50),
	image varchar(200),
	id int(11) PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE schedule (
	id int(11),
	cinema varchar(50),
	day varchar(12),
	hour varchar(12),
	PRIMARY KEY (id,cinema,day,hour),
	FOREIGN KEY(id) REFERENCES movies(id)
);

LOAD data local infile "C:\\Users\\david\\Desktop\\out.txt" 
INTO TABLE restaurants
fields terminated by ','
lines terminated by '\n';

LOAD data local infile "C:\\Users\\david\\Desktop\\movie.txt" 
INTO TABLE movies
fields terminated by ';'
lines terminated by '\n';

LOAD data local infile "C:\\Users\\david\\Desktop\\schedule.txt" 
INTO TABLE schedule
fields terminated by ','
lines terminated by '\n';


ALTER TABLE messages
ADD intent varchar(20);

ALTER TABLE messages
ADD restaurant int(11);

ALTER TABLE messages
ADD cinema int(11);

ALTER TABLE messages
ADD day varchar(12);