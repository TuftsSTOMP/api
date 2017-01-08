<?php

/*
 *  UserTypes.php
 *  Author: Sam Heilbron
 *  Last Updated: January 2017
 *
 *  Full list of User types
 *
 *	NOTE: When editing a user type, make sure to edit the 
 				/v1/db_scripts/user_permissions.sql file 
 		and run that new script. This will update the permissions in the
 		database so queries asking for the correct traits will match
 */	


	require_once 'User.php';
	
	require_once "Traits/Stomper_trait.php";
	require_once "Traits/Guest_trait.php";
	require_once "Traits/Admin_trait.php";
	require_once "Traits/Board_trait.php";
	require_once "Traits/GetMaterial_trait.php";
	
	class _Guest extends User {
		use Guest_trait;
		use GetMaterial_trait;
	} ## _Guest

	class Stomper extends User {
		use Stomper_trait;
		use GetMaterial_trait;
	} ## Stomper
	
	class SuperAdmin extends User {
		use Admin_trait;
		use GetMaterial_trait;
	} ## Admin
	
	class Board extends User {
		use Stomper_trait;
		use GetMaterial_trait;
		use Board_trait;
	} ## Board

?>