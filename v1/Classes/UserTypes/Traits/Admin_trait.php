<?php
	
	trait Admin_trait {



		
		/**************************************************************************************************************/
		/*******************************************  PUBLIC API CALLS  ***********************************************/
		/**************************************************************************************************************/
		
		/*
			Valid Enpoints:
			
			/Stomp/getAllUsers
			
		*/
		
		protected function getAllUsers() {
			$query = "SELECT username, f_name, l_name, phone, email FROM Stomper";
			return $this->EndpointResponse($query, true);
		}
		
		protected function createUser() {
			
		}

		protected function newClassroom() {
			$arr = array('Emma','Mrozicki','emrozicki@k12.somerville.ma.us','East Somerville','Alexandria','Trombley','Caroline','Passaacque',4);


			foreach ($arr as $t) {
				var_dump($t);
				echo "...";
				//$query = "CALL SetupDB_Classroom (".$this->tid.", '".$transaction_type."')";
				//return $this->EndpointResponse($query, true);
				//var_dump($t);
			}

		}
		
		

	} ## Admin_trait
?>