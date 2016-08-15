-- DB initialization

DROP DATABASE IF EXISTS Stomp_test;
CREATE DATABASE Stomp_test;

USE Stomp_test;

DROP TABLE IF EXISTS School;
CREATE TABLE School (
	sid INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	address VARCHAR(50),
	city VARCHAR(20),
	zip INT,
	main_phone CHAR(11),
	PRIMARY KEY ( sid )
);

DROP TABLE IF EXISTS Teacher;
CREATE TABLE Teacher (
	teid INT NOT NULL AUTO_INCREMENT,
	sid INT NOT NULL,
	f_name VARCHAR(30) NOT NULL,
	l_name VARCHAR(30),
	phone CHAR(11),
	email VARCHAR(50) NOT NULL,
	grade INT,
	FOREIGN KEY ( sid ) REFERENCES School(sid),
	PRIMARY KEY ( teid )
);

DROP TABLE IF EXISTS Team;
CREATE TABLE Team (
	tid INT NOT NULL AUTO_INCREMENT,
	sid INT NOT NULL,
	class DATETIME NOT NULL,
	FOREIGN KEY ( sid ) REFERENCES School(sid),
	PRIMARY KEY ( tid )
);

DROP TABLE IF EXISTS Team_Teacher;
CREATE TABLE Team_Teacher (
	zid INT NOT NULL AUTO_INCREMENT,
	teid INT NOT NULL,
	tid INT NOT NULL,
	FOREIGN KEY ( teid ) REFERENCES Teacher(teid),
	FOREIGN KEY ( tid ) REFERENCES Team(tid),
	PRIMARY KEY ( zid )
);

DROP TABLE IF EXISTS Stomper;
CREATE TABLE Stomper (
	uid INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(20) NOT NULL,
	pwd CHAR(40) NOT NULL,
	f_name VARCHAR(30) NOT NULL,
	l_name VARCHAR(30) NOT NULL,
	phone CHAR(11),
	email VARCHAR(50) NOT NULL,
	permissions VARCHAR(30) NOT NULL,
	PRIMARY KEY ( uid )
);

DROP TABLE IF EXISTS Stomper_Team;			
CREATE TABLE Stomper_Team (
	tid INT NOT NULL,
	uid INT NOT NULL,
	FOREIGN KEY ( tid ) REFERENCES Team( tid ),
	FOREIGN KEY ( uid ) REFERENCES Stomper( uid )
);


DROP TABLE IF EXISTS Material;					
CREATE TABLE Material (
	mid INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(40) NOT NULL, 
	q_avail INT NOT NULL, 
	q_reserved INT NOT NULL,
	q_removed INT NOT NULL,
	max_checkout_q INT NOT NULL, 
	low_q_thresh INT NOT NULL, 
	reusable TINYINT(1) NOT NULL,
	PRIMARY KEY ( mid )
);
	 
DROP TABLE IF EXISTS Transaction;
CREATE TABLE Transaction (
	zid INT NOT NULL AUTO_INCREMENT,
	trid INT NOT NULL,
	tid INT NOT NULL,
	uid INT NOT NULL,
	mid INT NOT NULL,
	quantity INT NOT NULL,
	transaction_date DATETIME NOT NULL DEFAULT NOW(),
	res_type enum('remove', 'reserve') NOT NULL DEFAULT 'reserve',
	action_date DATETIME NOT NULL,
	FOREIGN KEY ( tid ) REFERENCES Team( tid ),
	FOREIGN KEY ( uid ) REFERENCES Stomper( uid ),
	FOREIGN KEY ( mid ) REFERENCES Material( mid ),
	PRIMARY KEY ( zid )
);
							