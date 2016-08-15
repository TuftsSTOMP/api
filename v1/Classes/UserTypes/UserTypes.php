<?php
	
	require_once 'User.php';
	
	require_once "Traits/Stomper_trait.php";
	require_once "Traits/Admin_trait.php";
	require_once "Traits/Board_trait.php";
	require_once "Traits/GetMaterial_trait.php";
	
	class Stomper extends User {
		use Stomper_trait;
		use GetMaterial_trait;
	} ## Stomper
	
	class Admin extends User {
		use Admin_trait;
		use GetMaterial_trait;
	} ## Admin
	
	class Board extends User {
		use Stomper_trait;
		use GetMaterial_trait;
		use Board_trait;
	} ## Board
	
	
?>