
		USE Stomp_test;



		DELETE FROM Transaction;
		DELETE FROM Material;
		DELETE FROM Stomper_Team;
		DELETE FROM Team;
		DELETE FROM Class;
		DELETE FROM Stomper;
		DELETE FROM Teacher;
		DELETE FROM School;

ALTER TABLE School AUTO_INCREMENT = 1;
CALL newSchool('East Somerville','50 Cross St','Somerville',02145,6176295440);
CALL newSchool('Columbus','37 Hicks Ave','Medford',02155,7813932177);
CALL newSchool('Brooks','242 East Medford St.','Boston',03452,6178934545);


ALTER TABLE Teacher AUTO_INCREMENT = 1;
CALL newTeacher('Anna','McCormick','anna.mcCormick@brooks.edu','Brooks');
CALL newTeacher('George','Write','george.wright@columbus.edu','Columbus');


ALTER TABLE Stomper AUTO_INCREMENT = 1;
CALL newStomper('Sam','Heilbron','samheilbron@gmail.com','sheilb01');
CALL newStomper('Terrence','Roh','troh@gmail.com','troh01');


ALTER TABLE Class AUTO_INCREMENT = 1;
ALTER TABLE Team AUTO_INCREMENT = 1;
ALTER TABLE Stomper_Team AUTO_INCREMENT = 1;
CALL newClass('anna.mcCormick@brooks.edu','10:15-11:40','Friday',4);
CALL newTeam('anna.mcCormick@brooks.edu','Friday');
CALL newStomperTeam('Sam', 'Heilbron', 'anna.mcCormick@brooks.edu','Friday');
CALL newStomperTeam('Terrence', 'Roh', 'anna.mcCormick@brooks.edu','Friday');
CALL newClass('george.wright@columbus.edu','10:20-11:45','Friday',4);
CALL newTeam('george.wright@columbus.edu','Friday');
CALL newStomperTeam('Sam', 'Heilbron', 'george.wright@columbus.edu','Friday');
CALL newStomperTeam('Terrence', 'Roh', 'george.wright@columbus.edu','Friday');
