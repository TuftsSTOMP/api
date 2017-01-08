<?php

/*
 *  Admin_trait.php
 *  Author: Sam Heilbron
 *  Last Updated: January 2017
 *
 *  Endpoints for Admin 
 */
	
	trait Admin_trait {
		/*********************************************************************/
		/************************  PUBLIC API CALLS  *************************/
		/*********************************************************************/
		/*
			/Stomp/getAllUsers

		tbd:
			/Stomp/new/stomper
			/Stomp/new/teacher
			/Stomp/new/school
			/Stomp/new/class
			/Stomp/new/material

			/Stomp/edit/stomper
			/Stomp/edit/teacher
			/Stomp/edit/school
			/Stomp/edit/class
			/Stomp/edit/material

		*/
		/*********************************************************************/
		/*********************************************************************/
		
		protected function getAllUsers() {
			$query = "SELECT username, f_name, l_name, phone, email FROM Stomper";
			return $this->EndpointResponse($query, true);
		}

		protected function new() {
			$type = (array_key_exists (0, $this->args)) ? $this->args[0] : null;
			switch($type) {
				case 'stomper': 
					$result = $this->_createStomper();
					break;
				case 'teacher': 
					$result = $this->_createTeacher();
					break;
				case 'school': 
					$result = $this->_createSchool();
					break;
				case 'class': 
					$result = $this->_createClass();
					break;
				case 'material':
					$result = $this->_createMaterial();
					break;
				default: 
					throw new Exception("Invalid New Request ");
			}
			return $result;
		}

		protected function edit() {
			$type = (array_key_exists (0, $this->args)) ? $this->args[0] : null;
			switch($type) {
				case 'stomper': 
					$result = $this->_editStomper();
					break;
				case 'teacher': 
					$result = $this->_editTeacher();
					break;
				case 'school': 
					$result = $this->_editSchool();
					break;
				case 'class': 
					$result = $this->_editClass();
					break;
				case 'material':
					$result = $this->_editMaterial();
					break;
				default: 
					throw new Exception("Invalid Edit Request ");
			}
			return $result;
		}

		/*********************************************************************/
		/************************  PRIVATE  METHODS  *************************/
		/*********************************************************************/
		
		

	} ## Admin_trait
?>