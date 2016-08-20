/*
 *	Script to initialize MySql Database with specific data
 */
 
 
USE Stomp_test;


DELETE FROM Transaction;
DELETE FROM Team_Teacher;
DELETE FROM Stomper_Team;
DELETE FROM Material;
DELETE FROM Teacher;
DELETE FROM Team;
DELETE FROM School;
DELETE FROM Stomper;
DELETE FROM UserPermission;


ALTER TABLE UserPermission AUTO_INCREMENT = 1;
INSERT INTO UserPermission (permissionName) 
	VALUES 
("stomper"),
("getMaterial"),
("createAndEditUser");



ALTER TABLE School AUTO_INCREMENT = 1;
INSERT INTO School (name, address, city, zip, main_phone) 
	VALUES 
("East Somerville","50 Cross Street","Somerville",02145,6176295400),
("Columbus","37 Hicks Ave","Medford",02155,7813932177),
("Stratton","180 Mountain Ave","Arlington",02474,7813163754),
("St. Jos","132 High St","Medford",02155,7813963636),
("Parlin","587 Broadway","Everett",02149,6173942480),
("ISB","17 Irving St","Arlington",02476,7816460510),
("Linden","29 Wescott St","Malden",02148,7813977329),
("Vinson-Owen","75 Johnson Rd","Winchester",01890,7817217019),
("West Somerville","177 Powder House Blvd","Somerville",02144,6176256600),
("Tobin","197 Vassal Lane","Cambridge",02138,6173496600),
("JQS","885 Washington St","Boston",02111,6176358497),
("Acera","5 Lowell Ave","Winchester",01890,7817293489),
("Healey","5 Meacham St","Somerville",02145,6176256600),
("Argenziano","290 Washington St","Somerville",02143,6176256600),
("Brooks","388 High St","Medford",02155,7813932166);



ALTER TABLE Teacher AUTO_INCREMENT = 1;
INSERT INTO Teacher (f_name, l_name, email, grade, sid) 
	VALUES 
("Emma","Mrozicki","emrozicki@k12.somerville.ma.us",4,(SELECT sid from School where name = "East Somerville")),
("Joe","Plati","jplati@medford.k12.ma.us",4,(SELECT sid from School where name = "Columbus")),
("Lisa","dipersio","ldipersio@medford.k12.ma.us",4,(SELECT sid from School where name = "Columbus")),
("Janelle","Ricciuti","jricciuti@arlington.k12.ma.u",5,(SELECT sid from School where name = "Stratton")),
("Amber","Bus","abus@arlington.k12.ma.us",5,(SELECT sid from School where name = "Stratton")),
("Carolyn","Snook","csnook@arlington.k12.ma.us",5,(SELECT sid from School where name = "Stratton")),
("Lauren","Fiore","lillauren0766@yahoo.com",6,(SELECT sid from School where name = "St. Jos")),
("Christine","Whitney","cwhitney@stjosephschoolmedford.com",6,(SELECT sid from School where name = "St. Jos")),
("Katelyn","Crossley","kdondero@everett.k12.ma.us",6,(SELECT sid from School where name = "Parlin")),
("Lizzy","Mayer","emayer@isbos.org",7,(SELECT sid from School where name = "ISB")),
("Judy","Leisk","jleisk@maldenps.org",4,(SELECT sid from School where name = "Linden")),
("Mar","McDonough","MMcDonough@maldenps.org",4,(SELECT sid from School where name = "Linden")),
("Karen","Kiernan","kkiernan@maldenps.org",4,(SELECT sid from School where name = "Linden")),
("Cathleen","Walsh","cwalsh@maldenps.org",4,(SELECT sid from School where name = "Linden")),
("Pam","Wickwire","pwickwire@maldenps.org",4,(SELECT sid from School where name = "Linden")),
("Elaine","Bowler","ebowler@winchesterps.org",5,(SELECT sid from School where name = "Vinson-Owen")),
("Maggie","Jackson","mjackson@winchesterps.org",5,(SELECT sid from School where name = "Vinson-Owen")),
("Jill","Pappas","jpappas@winchesterps.org",5,(SELECT sid from School where name = "Vinson-Owen")),
("Sophia","Carafotes","scarafotes@k12.somerville.ma.us",5,(SELECT sid from School where name = "West Somerville")),
("*","*","LSA",6,(SELECT sid from School where name = "Tobin")),
("Deborah","Aguayo-Delgado","daguayodelgado@bostonpublicschools.org",4,(SELECT sid from School where name = "JQS")),
("Kely","Keefe","kellylkeefe@gmail.com",5,(SELECT sid from School where name = "JQS")),
("Cindy","Lau","clau3@bostonpublicschools.org",4,(SELECT sid from School where name = "JQS")),
("Tinyan","Chan","tchan2@bostonpublicschools.org",5,(SELECT sid from School where name = "JQS")),
("S","Luie","sluie@bostonpublicschools.org___",4,(SELECT sid from School where name = "JQS")),
("Ronnie","Ho","rho@bostonpublicschools.org",4,(SELECT sid from School where name = "JQS")),
("Mimi" ,"Fong","msfongquincy@gmail.com",5,(SELECT sid from School where name = "JQS")),
("Matthew","Lydon","mattmlydon@gmail.com",5,(SELECT sid from School where name = "JQS")),
("Katie","Semine","katie@aceraschool.org",2.5,(SELECT sid from School where name = "Acera")),
("S","Bassett","sbassett@k12.somerville.ma.us",3,(SELECT sid from School where name = "Healey")),
("Susanne","Douglas","sdouglas@k12.somerville.ma.us",3,(SELECT sid from School where name = "Healey")),
("Megan", "Knottingham", "mknottingham@k12.somerville.ma.us",4,(SELECT sid from School where name = "Healey")),
("Julia","Hermann","jhermann@k12.somerville.ma.us",4,(SELECT sid from School where name = "Healey")),
("Carol","Murphy","camurphy@k12.somerville.ma.us",5,(SELECT sid from School where name = "Argenziano")),
("Salazar","*","myteacherathome@gmail.com",5,(SELECT sid from School where name = "Argenziano")),
("Anna","McCormick","anna.t.mccormick@gmail.com",5,(SELECT sid from School where name = "Brooks"));


ALTER TABLE Stomper AUTO_INCREMENT = 1;
INSERT INTO Stomper (f_name, l_name, email, username, pwd, permissions)
	VALUES 
('Devyn', 'Curley', 'InvalidEmail', 'devyn01', 'stomp','011'),
('Alexandria','Trombley','InvalidEmail@tufts.edu','atromb01','stomp','110'),
('Ross','Kamen','Ross.Kamen@tufts.edu','rkamen01','stomp','110'),
('Marc','Bucchieri','marc.bucchieri@tufts.edu','mbucch01','stomp','110'),
('Laura','Fradin','laura.coughlin@tufts.edu','lfradi01','stomp','110'),
('Suneeth','Keerthy','suneeth.keerthy@tufts.edu','skeert01','stomp','110'),
('Akari','Miki','Akari.miki@tufts.edu','amiki01','stomp','110'),
('Jen','Scinto','jennifer.scinto@tufts.edu','jscint01','stomp','110'),
('Emily','Lai','emily.lai@tufts.edu','elai01','stomp','110'),
('Erica','Albert','Erica.albert@tufts.edu','ealber01','stomp','110'),
('Shelley','Kwok','shelley.kwok@tufts.edu','skwok01','stomp','110'),
('Rohan','Joshi','Rohan.Joshi@tufts.edu','rjoshi01','stomp','110'),
('Alex','Klein','Alexander.klein@tufts.edu','aklein01','stomp','110'),
('Katherine','McMurray','katherine.mcmurray@tufts.edu','kmcmur01','stomp','110'),
('Sara','Hogan','sara.hogan@tufts.edu','shogan01','stomp','110'),
('Susan','Bitetti','smbitetti@gmail.com','sbitet01','stomp','110'),
('Camila','Menard','camila.menard@tufts.edu','cmenar01','stomp','110'),
('Tanya','Sinha','tanyasinha23@gmail.com','tsinha01','stomp','110'),
('Daniela','Torres','daniela.torres@tufts.edu','dtorre01','stomp','110'),
('Rohini','Lok','Rohini.Loke@tufts.edu','rlok01','stomp','110'),
('Yash','Gurditta','yash.gurditta@tufts.edu','ygurdi01','stomp','110'),
('Laura','Coughlin','laura.coughlin@tufts.edu','lcough01','stomp','110'),
('Camila','Solorzano','camila.solorzano@tufts.edu','csolor01','stomp','110'),
('Lois','Moon','lois.moon@tufts.edu','lmoon01','stomp','110'),
('Sam','Heilbron','samheilbron@gmail.com','sheilb01','stomp','110'),
('Kirsten','Jorgensen','kirsten.jorgensen@tufts.edu','kjorge01','stomp','110'),
('Brian','Bertini','InvalidEmail@tufts.edu','bberti01','stomp','110'),
('Eva','Philips','eva.philips@tufts.edu','ephili01','stomp','110'),
('Grace','Reilly','grace.reilly@tufts.edu','greill01','stomp','110'),
('Rachel','Kramer','rachelerinkramer@gmail.com','rkrame01','stomp','110'),
('Orian','Sneor','alexandria.trombley@tufts.edu','osneor01','stomp','110'),
('Ty','Nguyen','Nhu_Q.Nguyen@tufts.edu','tnguye01','stomp','110'),
('Mile','Krstev','mile.krstev@tufts.edu','mkrste01','stomp','110'),
('Caroline','Passaacque','caroline.passalacqua@tufts.edu','cpassa01','stomp','110'),
('Emma','Coltoff','emma.coltoff@tufts.edu','ecolto01','stomp','110'),
('Zack','Nassar','zack.nassar@tufts.edu','znassa01','stomp','110'),
('Jillian','Gerke','jillian.gerke@tufts.edu','jgerke01','stomp','110'),
('Caitlin','Duffy','caitlin.duffy@tufts.edu','cduffy01','stomp','110'),
('Lisa','Fantini','lisa.fantini@tufts.edu','lfanti01','stomp','110'),
('Elizabeth','Dossett','Elizabeth.dossett@tufts.edu','edosse01','stomp','110'),
('Jerry','*','brian.bertini@tufts.edu','j*01','stomp','110'),
('Simone(Daisy)','Draper','simone.draper@tufts.edu','sdrape01','stomp','110'),
('Jhanel','Chew','jhanel.chew@gmail.com','jchew01','stomp','110'),
('Sanya','Pradhan','sanyapradhan28@gmail.com','spradh01','stomp','110'),
('Michael','Edegware','Michael.Edegware@tufts.edu','medegw01','stomp','110'),
('Sara','Pearce-Probst','Sara.Pearce_Probst@tufts.edu','spearc01','stomp','110'),
('Emma','Cus','emma.cusack@tufts.edu','ecus01','stomp','110'),
('Jordan-Tate','Thomas','jordan-tate.thomas@tufts.edu','jthoma01','stomp','110'),
('Sonja','Hartmann','InvalidEmail@tufts.edu','shartm01','stomp','110'),
('Tommy','George','Thomas.George@tufts.edu','tgeorg01','stomp','110'),
('Evan','Lorey','Evan.Lorey@tufts.edu','elorey01','stomp','110'),
('Chris','Keyes','christopher.keyes@tufts.edu','ckeyes01','stomp','110'),
('Eleanor','Richard','eleanor.richard@gmail.com','ericha01','stomp','110'),
('Melissa','Moore','melissa.moore@tufts.edu','mmoore01','stomp','110'),
('Lexi','Gilligan','alexandra.gilligan@tufts.edu','lgilli01','stomp','110'),
('Azmina','Karukappadath','azmina.karukappadath@tufts.edu','akaruk01','stomp','110'),
('Terrence','Roh','troh01@tufts.edu','troh01','stomp','110')
('Becca','Larson','rebecca.larson@tufts.edu','blarso01','stomp','110'),
('Vanessa','Pinto','vanessa.pinto@tufts.edu','vpinto01','stomp','110'),
('Camille-Louise','Mbayo','camille-louise.mbayo@tufts.edu','cmbayo01','stomp','110'),
('Edward','Futterman','Edward.Futterman@tufts.edu','efutte01','stomp','110'),
('Michael','Seleman','Michael.Seleman@tufts.edu','mselem01','stomp','110'),
('Rati','Srinivasan','Rati.Srinivasan7@gmail.com','rsrini01','stomp','110'),
('Sam','Slate','Samuel.Slate@tufts.edu','sslate01','stomp','110'),
('Tom','Depalma','thomas.depalms@tufts.edu','tdepal01','stomp','110');
UPDATE Stomper SET pwd = SHA1(pwd);


ALTER TABLE Team AUTO_INCREMENT = 1;
INSERT INTO Team (sid, class) 
	VALUES 
((SELECT sid from School where name = 'East Somerville'),NOW()),
((SELECT sid from School where name = 'Columbus'),NOW()),
((SELECT sid from School where name = 'Columbus'),NOW()),
((SELECT sid from School where name = 'Stratton'),NOW()),
((SELECT sid from School where name = 'St. Jos'),NOW()),
((SELECT sid from School where name = 'St. Jos'),NOW()),
((SELECT sid from School where name = 'Parlin'),NOW()),
((SELECT sid from School where name = 'ISB'),NOW()),
((SELECT sid from School where name = 'Linden'),NOW()),
((SELECT sid from School where name = 'Linden'),NOW()),
((SELECT sid from School where name = 'Linden'),NOW()),
((SELECT sid from School where name = 'Linden'),NOW()),
((SELECT sid from School where name = 'Linden'),NOW()),
((SELECT sid from School where name = 'Vinson-Owen'),NOW()),
((SELECT sid from School where name = 'Vinson-Owen'),NOW()),
((SELECT sid from School where name = 'Vinson-Owen'),NOW()),
((SELECT sid from School where name = 'West Somerville'),NOW()),
((SELECT sid from School where name = 'Tobin'),NOW()),
((SELECT sid from School where name = 'JQS'),NOW()),
((SELECT sid from School where name = 'JQS'),NOW()),
((SELECT sid from School where name = 'JQS'),NOW()),
((SELECT sid from School where name = 'JQS'),NOW()),
((SELECT sid from School where name = 'JQS'),NOW()),
((SELECT sid from School where name = 'Acera'),NOW()),
((SELECT sid from School where name = 'Healey'),NOW()),
((SELECT sid from School where name = 'Healey'),NOW()),
((SELECT sid from School where name = 'Healey'),NOW()),
((SELECT sid from School where name = 'Healey'),NOW()),
((SELECT sid from School where name = 'Argenziano'),NOW()),
((SELECT sid from School where name = 'Argenziano'),NOW()),
((SELECT sid from School where name = 'Argenziano'),NOW()),
((SELECT sid from School where name =  'Brooks'),NOW());

ALTER TABLE Stomper_Team AUTO_INCREMENT = 1;
INSERT INTO Stomper_Team (tid, uid)
	VALUES 
(1,(SELECT uid from Stomper where l_name = 'Trombley')),
(2,(SELECT uid from Stomper where l_name = 'Kamen')),
(3,(SELECT uid from Stomper where l_name = 'Bucchieri')),
(4,(SELECT uid from Stomper where l_name = 'Fradin')),
(5,(SELECT uid from Stomper where l_name = 'Keerthy')),
(6,(SELECT uid from Stomper where l_name = 'Miki')),
(7,(SELECT uid from Stomper where l_name = 'Scinto')),
(8,(SELECT uid from Stomper where l_name = 'Lai')),
(9,(SELECT uid from Stomper where l_name = 'Albert')),
(10,(SELECT uid from Stomper where l_name = 'Kwok')),
(11,(SELECT uid from Stomper where l_name = 'Joshi')),
(12,(SELECT uid from Stomper where l_name = 'Klein')),
(13,(SELECT uid from Stomper where l_name = 'McMurray')),
(14,(SELECT uid from Stomper where l_name = 'Hogan')),
(15,(SELECT uid from Stomper where l_name = 'Bitetti')),
(16,(SELECT uid from Stomper where l_name = 'Menard')),
(17,(SELECT uid from Stomper where l_name = 'Sinha')),
(18,(SELECT uid from Stomper where l_name = 'Torres')),
(19,(SELECT uid from Stomper where l_name = 'Lok')),
(20,(SELECT uid from Stomper where l_name = 'Gurditta')),
(21,(SELECT uid from Stomper where l_name = 'Coughlin')),
(22,(SELECT uid from Stomper where l_name = 'Solorzano')),
(23,(SELECT uid from Stomper where l_name = 'Moon')),
(24,(SELECT uid from Stomper where l_name = 'Heilbron')),
(25,(SELECT uid from Stomper where l_name = 'Jorgensen')),
(26,(SELECT uid from Stomper where l_name = 'Bertini')),
(27,(SELECT uid from Stomper where l_name = 'Philips')),
(28,(SELECT uid from Stomper where l_name = 'Reilly')),
(29,(SELECT uid from Stomper where l_name = 'Kramer')),
(30,(SELECT uid from Stomper where l_name = 'Sneor')),
(31,(SELECT uid from Stomper where l_name = 'Nguyen')),
(32,(SELECT uid from Stomper where l_name = 'Krstev')),
(1,(SELECT uid from Stomper where l_name = 'Passaacque')),
(2,(SELECT uid from Stomper where l_name = 'Coltoff')),
(3,(SELECT uid from Stomper where l_name = 'Nassar')),
(4,(SELECT uid from Stomper where l_name = 'Gerke')),
(5,(SELECT uid from Stomper where l_name = 'Duffy')),
(6,(SELECT uid from Stomper where l_name = 'Fantini')),
(7,(SELECT uid from Stomper where l_name = 'Dossett')),
(8,(SELECT uid from Stomper where l_name = '*')),
(9,(SELECT uid from Stomper where l_name = 'Draper')),
(10,(SELECT uid from Stomper where l_name = 'Chew')),
(11,(SELECT uid from Stomper where l_name = 'Pradhan')),
(12,(SELECT uid from Stomper where l_name = 'Edegware')),
(13,(SELECT uid from Stomper where l_name = 'Pearce-Probst')),
(14,(SELECT uid from Stomper where l_name = 'Cus')),
(15,(SELECT uid from Stomper where l_name = 'Thomas')),
(16,(SELECT uid from Stomper where l_name = 'Hartmann')),
(17,(SELECT uid from Stomper where l_name = 'George')),
(18,(SELECT uid from Stomper where l_name = 'Lorey')),
(19,(SELECT uid from Stomper where l_name = 'Keyes')),
(20,(SELECT uid from Stomper where l_name = 'Richard')),
(21,(SELECT uid from Stomper where l_name = 'Moore')),
(22,(SELECT uid from Stomper where l_name = 'Gilligan')),
(23,(SELECT uid from Stomper where l_name = 'Karukappadath')),
(24,(SELECT uid from Stomper where l_name = 'Roh')),
(25,(SELECT uid from Stomper where l_name = 'Larson')),
(26,(SELECT uid from Stomper where l_name = 'Pinto')),
(27,(SELECT uid from Stomper where l_name = 'Mbayo')),
(28,(SELECT uid from Stomper where l_name = 'Futterman')),
(29,(SELECT uid from Stomper where l_name = 'Seleman')),
(30,(SELECT uid from Stomper where l_name = 'Srinivasan')),
(31,(SELECT uid from Stomper where l_name = 'Slate')),
(32,(SELECT uid from Stomper where l_name = 'Depalma'));



ALTER TABLE Team_Teacher AUTO_INCREMENT = 1;
/*INSERT INTO Team_Teacher (teid, tid) 
	VALUES 
*/

								


ALTER TABLE Material AUTO_INCREMENT = 1;
INSERT INTO Material (name, q_avail, q_reserved, q_removed, max_checkout_q, low_q_thresh) 
	VALUES 
	('Marbles', 100, 0, 0, 30, 10),
	('Paper Clips', 50, 0, 0, 10, 5),
	('NXT Robotics Kits', 25, 0, 0, 4, 0),
	('Laptops', 15, 0, 0, 4, 0),
	('Spaghetti Boxes', 25, 0, 0, 5, 5),
	('Snap Circuits', 8, 0, 0, 2, 0);	 



ALTER TABLE Transaction AUTO_INCREMENT = 1;




