<?php

/*
 *  Admin_trait.php
 *  Author: Sam Heilbron
 *  Last Updated: January 2017
 *
 *  Basic User class.
 *		-Acts as middleware for User types: 1 function to handle call and 
 			1 for response to endpoint
		-Contains generic user endpoints
 */


	require_once dirname(__FILE__). "/../Controller/API_Controller.php";
	abstract class User extends API_Controller {
		protected $uid = null;
		protected $tid = null;
		protected $api_version_gen = null; //Which api version was used to generate the user

		public function __construct($request, $uid, $tid = null, $api_version) {
			$this->uid = $uid;
			$this->tid = $tid;
			$this->api_version_gen = $api_version;
		
			/* Construct API_Controller */
			parent::__construct($request);
		}

		/*********************************************************************/
		/************************  PUBLIC API CALLS  *************************/
		/*********************************************************************/
		/*
			/Stomp/user/permissions
			/Stomp/user/version
			/Stomp/user/details

			/Stomp/updateUser

		*/
		/*********************************************************************/
		/*********************************************************************/


		protected function user() {
			$sub_directory = (array_key_exists (0, $this->args)) ? $this->args[0] : null;
			switch($sub_directory) {
				case 'permissions': 
					$result = $this->_getPermissions(get_class($this));
					break;
				case 'version': 
					$result = $this->_getApiVersion();
					break;
				case 'details':
					$result = $this->_getDetails(get_class($this));
					break;
				default: 
					throw new Exception("Invalid User Request");
			}
			return $result;
		}



		protected function updateUser() {
			$params = $this->args;

			//update all fields. Update password only if passed.

			$queryArray[] =  "UPDATE Stomper
				SET 
				f_name='". $params['f_name']    ."', 
				l_name='". $params['l_name']    ."',
				email='".  $params['email']     ."',
				phone='".  $params['phone']     ."'". 
				(isset($params['pwd']) ? ", pwd = '".  SHA1($params['pwd']) ."'" : "")
				. "WHERE uid= '".$this->uid. "'";

			return $this->EndpointResponse($queryArray, false, "User Updated Successfully");
		}
		

		/* Apply function with arguments */
		protected function validateAndApplyFunction($fn, $args) {
			return $this->{$fn}($args);
		}
		
		/* Return endopint response with appropriate data */
		protected function EndpointResponse($queryStream, $show_result = false, $msg = "Successful Operation") {
			try {
				$response = $this->implementQueryStream($queryStream);
				return ($show_result) ? 
							$response : 
							array("status" => "Success", "message" => $msg);
			} catch (Exception $e) {
				throw $e;
			}
		}

		/*********************************************************************/
		/************************  PRIVATE  METHODS  *************************/
		/*********************************************************************/

		private function _getPermissions($user_role) {
			$queryArray[] = "SELECT p.permission_name FROM UserPermission AS p 
						LEFT JOIN Role_Permission AS r USING (permission_id) 
						INNER JOIN UserRole as u USING ( role_id ) 
						WHERE u.role_name = '" . $user_role . "'";
			
			$result = $this->EndpointResponse($queryArray, true);

			return 
				array_map(function($element) {
        			return $element['permission_name'];
    			}, $result);
		}

		// List the version of the api used to generate the token / user
		private function _getApiVersion() {
			return $this->api_version_gen;
		}

		private function _getDetails($user_role) {
			$queryArray[] = "SELECT username, f_name, l_name, phone, email 
							FROM Stomper 
							WHERE uid = '". $this->uid ."'";

			$result = $this->EndpointResponse($queryArray, true);
			$result[0]['userPermission'] = $this->_getPermissions($user_role);
			$result[0]['apiVersion'] = $this->_getApiVersion();

			return $result;
		}

	} ## User
?>