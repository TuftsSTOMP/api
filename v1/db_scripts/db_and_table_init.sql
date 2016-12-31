-- DB initialization

DROP DATABASE IF EXISTS Stomp_test;
CREATE DATABASE Stomp_test;

USE Stomp_test;


DROP TABLE IF EXISTS UserPermission;
CREATE TABLE UserPermission (
	permission_id INT NOT NULL AUTO_INCREMENT,
	permission_name VARCHAR(30) NOT NULL,
	PRIMARY KEY ( permission_id )
);

DROP TABLE IF EXISTS UserRole;
CREATE TABLE UserRole(
	role_id INT NOT NULL AUTO_INCREMENT,
	role_name VARCHAR(30) NOT NULL,
	PRIMARY KEY	( role_id )
);

DROP TABLE IF EXISTS Role_Permission;
CREATE TABLE Role_Permission (
	zid INT NOT NULL AUTO_INCREMENT,
	role_id INT NOT NULL,
	permission_id INT NOT NULL,
	FOREIGN KEY ( role_id ) REFERENCES UserRole(role_id),
	FOREIGN KEY ( permission_id ) REFERENCES UserPermission(permission_id),
	PRIMARY KEY ( zid )
);

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
	email VARCHAR(50) NOT NULL,
	FOREIGN KEY ( sid ) REFERENCES School(sid),
	PRIMARY KEY ( teid )
);

DROP TABLE IF EXISTS Class;
CREATE TABLE Class (
	cid INT NOT NULL AUTO_INCREMENT,
	teid INT NOT NULL,
	time_start TIME NOT NULL,
	time_end TIME NOT NULL,
	weekday VARCHAR(30) NOT NULL,
	grade INT NOT NULL,
	FOREIGN KEY ( teid ) REFERENCES Teacher(teid),
	PRIMARY KEY ( cid )
);

DROP TABLE IF EXISTS Team;
CREATE TABLE Team (
	tid INT NOT NULL AUTO_INCREMENT,
	cid INT NOT NULL,
	FOREIGN KEY ( cid ) REFERENCES Class(cid),
	PRIMARY KEY ( tid )
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
	role_id INT NOT NULL,
	FOREIGN KEY (role_id) REFERENCES UserRole(role_id),
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
							