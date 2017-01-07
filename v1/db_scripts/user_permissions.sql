DELETE From Role_Permission;
DELETE FROM UserPermission;
DELETE FROM UserRole;


ALTER TABLE UserPermission AUTO_INCREMENT = 1;
INSERT INTO UserPermission (permission_name) 
	VALUES 
	("GetMaterial"),
	("Stomper"),
	("Guest"),
	("createAndEditUser");


ALTER TABLE UserRole AUTO_INCREMENT = 1;
INSERT INTO UserRole (role_name)
	VALUES
	("SuperAdmin"),
	("Stomper"),
	("_Guest");


ALTER TABLE Role_Permission AUTO_INCREMENT = 1;
INSERT INTO Role_Permission (role_id, permission_id)
	VALUES
	(1, 4),
	(2, 1),
	(2, 2),
	(3, 3);


ALTER TABLE Stomper AUTO_INCREMENT = 1;
CALL newStomper('Guest','Guest','Guest','guest', 'guest','_Guest');
CALL newStomper('Devyn','Curley','devyn.curley@tufts.edu','devyn01', 'stomp','SuperAdmin');