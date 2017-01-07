
		USE Stomp_test;



		DELETE FROM Transaction;
		DELETE FROM Material;
		DELETE FROM Stomper_Team;
		DELETE FROM Team;
		DELETE FROM Class;
		DELETE FROM Stomper WHERE uid > 2;
		DELETE FROM Teacher;
		DELETE FROM School;

ALTER TABLE School AUTO_INCREMENT = 1;
CALL newSchool('East Somerville','50 Cross St','Somerville',02145,6176295440);
CALL newSchool('Columbus','37 Hicks Ave','Medford',02155,7813932177);
CALL newSchool('Brooks','242 East Medford St.','Boston',03452,6178934545);


ALTER TABLE Teacher AUTO_INCREMENT = 1;
CALL newTeacher('Anna','McCormick','anna.mcCormick@brooks.edu','Brooks');
CALL newTeacher('George','Write','george.wright@columbus.edu','Columbus');
CALL newTeacher('Ella','Ball','ella.ball@tufts.edu','East Somerville');


ALTER TABLE Stomper AUTO_INCREMENT = 2;
CALL newStomper('Sam','Heilbron','samheilbron@gmail.com','sheilb01', 'stomp','Stomper');
CALL newStomper('Terrence','Roh','troh@gmail.com','troh01', 'stomp','Stomper');
CALL newStomper('John','Doe','jdoe@gmail.com','jdoh01', 'stomp','Stomper');
CALL newStomper('Eric','Bledsoe','ebledsoe@gmail.com','ebled01', 'stomp','Stomper');


ALTER TABLE Class AUTO_INCREMENT = 1;
ALTER TABLE Team AUTO_INCREMENT = 1;
ALTER TABLE Stomper_Team AUTO_INCREMENT = 2;
CALL newClass('anna.mcCormick@brooks.edu','10:15-11:40','Friday',4);
CALL newTeam('anna.mcCormick@brooks.edu','Friday');
CALL newStomperTeam('Sam', 'Heilbron', 'anna.mcCormick@brooks.edu','Friday');
CALL newStomperTeam('Terrence', 'Roh', 'anna.mcCormick@brooks.edu','Friday');
CALL newClass('george.wright@columbus.edu','10:20-11:45','Friday',4);
CALL newTeam('george.wright@columbus.edu','Friday');
CALL newStomperTeam('Sam', 'Heilbron', 'george.wright@columbus.edu','Friday');
CALL newStomperTeam('Terrence', 'Roh', 'george.wright@columbus.edu','Friday');
CALL newClass('ella.ball@tufts.edu','1:20-2:40','Wednesday',2);
CALL newTeam('ella.ball@tufts.edu','Wednesday');
CALL newStomperTeam('John', 'Doe', 'ella.ball@tufts.edu','Wednesday');
CALL newStomperTeam('Eric', 'Bledsoe', 'ella.ball@tufts.edu','Wednesday');


ALTER TABLE Material AUTO_INCREMENT = 1;
CALL newMaterial('Marbles',100,20,5,1);
CALL newMaterial('NXT Robotics Kit',20,5,0,1);
CALL newMaterial('Spaghetti Box',20,2,2,0);
CALL newMaterial('Laptops',15,4,0,1);
CALL newMaterial('Snap Circuits',10,10,1,1);
