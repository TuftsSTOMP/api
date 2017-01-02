/*
 *	Script to initialize MySql Database with specific data
 */
 
 
USE Stomp_test;


DELETE FROM Transaction;
DELETE FROM Stomper_Team;
DELETE FROM Material;
DELETE FROM Teacher;
DELETE FROM School;
DELETE FROM Team;
DELETE FROM Stomper;
DELETE FROM Class;
DELETE FROM UserPermission;
DELETE FROM UserRole;
DELETE FROM Role_Permission;


ALTER TABLE UserPermission AUTO_INCREMENT = 1;
INSERT INTO UserPermission (permission_name) 
	VALUES 
("stomper"),
("getMaterial"),
("createAndEditUser");

ALTER TABLE UserRole AUTO_INCREMENT = 1;
INSERT INTO UserRole (role_name)
	VALUES
	("SuperAdmin"),
	("Stomper");

ALTER TABLE Role_Permission AUTO_INCREMENT = 1;
INSERT INTO Role_Permission (role_id, permission_id)
	VALUES
	(2, 1),
	(2, 2),
	(1, 3);


ALTER TABLE School AUTO_INCREMENT = 1;
CALL newSchool("Brooks","388 High St","Medford",02155,7813932166);
CALL newSchool("East Somerville","50 Cross Street","Somerville",02145,6176295400);


ALTER TABLE Teacher AUTO_INCREMENT = 1;
CALL newTeacher("Anna","McCormick","annaMcCormick@brooks.edu","Brooks");
CALL newTeacher("Emma","Mrozicki","emrozicki@k12.somerville.ma.us","East Somerville");


ALTER TABLE Class AUTO_INCREMENT = 1;
CALL newClass("emrozicki@k12.somerville.ma.us", "4:30-5:30", "Monday", 4);



ALTER TABLE Stomper AUTO_INCREMENT = 1;
CALL newStomper('Sam','Heilbron','samheilbron@gmail.com','sheilb01');
CALL newStomper('Terrence','Roh','troh01@tufts.edu','troh01');
/*
	VALUES 
('Devyn', 'Curley', 'InvalidEmail', 'devyn01', 'stomp',(SELECT role_id from UserRole where role_name = "SuperAdmin")),
('Alexandria','Trombley','InvalidEmail@tufts.edu','atromb01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Ross','Kamen','Ross.Kamen@tufts.edu','rkamen01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Marc','Bucchieri','marc.bucchieri@tufts.edu','mbucch01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Laura','Fradin','laura.coughlin@tufts.edu','lfradi01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Suneeth','Keerthy','suneeth.keerthy@tufts.edu','skeert01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Akari','Miki','Akari.miki@tufts.edu','amiki01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Jen','Scinto','jennifer.scinto@tufts.edu','jscint01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Emily','Lai','emily.lai@tufts.edu','elai01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Erica','Albert','Erica.albert@tufts.edu','ealber01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Shelley','Kwok','shelley.kwok@tufts.edu','skwok01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Rohan','Joshi','Rohan.Joshi@tufts.edu','rjoshi01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Alex','Klein','Alexander.klein@tufts.edu','aklein01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Katherine','McMurray','katherine.mcmurray@tufts.edu','kmcmur01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Sara','Hogan','sara.hogan@tufts.edu','shogan01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Susan','Bitetti','smbitetti@gmail.com','sbitet01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Camila','Menard','camila.menard@tufts.edu','cmenar01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Tanya','Sinha','tanyasinha23@gmail.com','tsinha01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Daniela','Torres','daniela.torres@tufts.edu','dtorre01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Rohini','Lok','Rohini.Loke@tufts.edu','rlok01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Yash','Gurditta','yash.gurditta@tufts.edu','ygurdi01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Laura','Coughlin','laura.coughlin@tufts.edu','lcough01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Camila','Solorzano','camila.solorzano@tufts.edu','csolor01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Lois','Moon','lois.moon@tufts.edu','lmoon01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Sam','Heilbron','samheilbron@gmail.com','sheilb01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Kirsten','Jorgensen','kirsten.jorgensen@tufts.edu','kjorge01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Brian','Bertini','InvalidEmail@tufts.edu','bberti01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Eva','Philips','eva.philips@tufts.edu','ephili01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Grace','Reilly','grace.reilly@tufts.edu','greill01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Rachel','Kramer','rachelerinkramer@gmail.com','rkrame01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Orian','Sneor','alexandria.trombley@tufts.edu','osneor01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Ty','Nguyen','Nhu_Q.Nguyen@tufts.edu','tnguye01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Mile','Krstev','mile.krstev@tufts.edu','mkrste01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Caroline','Passaacque','caroline.passalacqua@tufts.edu','cpassa01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Emma','Coltoff','emma.coltoff@tufts.edu','ecolto01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Zack','Nassar','zack.nassar@tufts.edu','znassa01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Jillian','Gerke','jillian.gerke@tufts.edu','jgerke01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Caitlin','Duffy','caitlin.duffy@tufts.edu','cduffy01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Lisa','Fantini','lisa.fantini@tufts.edu','lfanti01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Elizabeth','Dossett','Elizabeth.dossett@tufts.edu','edosse01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Jerry','*','brian.bertini@tufts.edu','j*01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Simone(Daisy)','Draper','simone.draper@tufts.edu','sdrape01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Jhanel','Chew','jhanel.chew@gmail.com','jchew01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Sanya','Pradhan','sanyapradhan28@gmail.com','spradh01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Michael','Edegware','Michael.Edegware@tufts.edu','medegw01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Sara','Pearce-Probst','Sara.Pearce_Probst@tufts.edu','spearc01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Emma','Cus','emma.cusack@tufts.edu','ecus01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Jordan-Tate','Thomas','jordan-tate.thomas@tufts.edu','jthoma01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Sonja','Hartmann','InvalidEmail@tufts.edu','shartm01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Tommy','George','Thomas.George@tufts.edu','tgeorg01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Evan','Lorey','Evan.Lorey@tufts.edu','elorey01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Chris','Keyes','christopher.keyes@tufts.edu','ckeyes01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Eleanor','Richard','eleanor.richard@gmail.com','ericha01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Melissa','Moore','melissa.moore@tufts.edu','mmoore01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Lexi','Gilligan','alexandra.gilligan@tufts.edu','lgilli01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Azmina','Karukappadath','azmina.karukappadath@tufts.edu','akaruk01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Terrence','Roh','troh01@tufts.edu','troh01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Becca','Larson','rebecca.larson@tufts.edu','blarso01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Vanessa','Pinto','vanessa.pinto@tufts.edu','vpinto01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Camille-Louise','Mbayo','camille-louise.mbayo@tufts.edu','cmbayo01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Edward','Futterman','Edward.Futterman@tufts.edu','efutte01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Michael','Seleman','Michael.Seleman@tufts.edu','mselem01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Rati','Srinivasan','Rati.Srinivasan7@gmail.com','rsrini01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Sam','Slate','Samuel.Slate@tufts.edu','sslate01','stomp',(SELECT role_id from UserRole where role_name = "Stomper")),
('Tom','Depalma','thomas.depalms@tufts.edu','tdepal01','stomp',(SELECT role_id from UserRole where role_name = "Stomper"));
UPDATE Stomper SET pwd = SHA1(pwd);
*/

ALTER TABLE Team AUTO_INCREMENT = 1;
CALL newTeam("emrozicki@k12.somerville.ma.us", "Monday");


ALTER TABLE Stomper_Team AUTO_INCREMENT = 1;
CALL newStomperTeam("Sam", "Heilbron", "emrozicki@k12.somerville.ma.us", "Monday");
CALL newStomperTeam("Terrence", "Roh", "emrozicki@k12.somerville.ma.us", "Monday");

								


ALTER TABLE Material AUTO_INCREMENT = 1;
CALL newMaterial("Marbles", 100, 30, 10, 1);
CALL newMaterial('Paper Clips', 50, 10, 5, 0);
CALL newMaterial('NXT Robotics Kits', 25, 4, 0, 1);
CALL newMaterial('Laptops', 15, 4, 0, 1);
CALL newMaterial('Spaghetti Boxes', 25, 5, 5, 0);
CALL newMaterial('Snap Circuits', 8, 2, 0, 1);



ALTER TABLE Transaction AUTO_INCREMENT = 1;