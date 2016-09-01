<?php

/*  
Basic User class.
Middleware for User types. 1 function handles call to endpoint and otherhandles response
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

		/*
			VALID ENDPOINTS:

			/Stomp/user/permissions
			/Stomp/user/version

		*/

		protected function user() {
			$sub_directory = (array_key_exists (0, $this->args)) ? $this->args[0] : null;
			switch($sub_directory) {
				case 'permissions': 
					$result = $this->_getPermissions(get_class($this));
					break;
				case 'version': 
					$result = $this->_getApiVersion();
					break;
				default: 
					throw new Exception("Invalid User Request");
			}
			return $result;
		}

		private function _getPermissions($user_role) {
			$queryArray[] = "SELECT p.permission_name FROM UserPermission AS p LEFT JOIN Role_Permission AS r
			USING (permission_id) INNER JOIN UserRole as u USING ( role_id ) 
			WHERE u.role_name = '" . $user_role . "'";
			
			$result = $this->implementQueryStream($queryArray);

			return 
				array_map(function($element) {
        			return $element['permission_name'];
    			}, $result);
		}

		// List the version of the api used to generate the token / user
		private function _getApiVersion() {
			return $this->api_version_gen;
		}
		
		protected function validateAndApplyFunction($fn, $args) {
			return $this->{$fn}($args);
		}
		
		protected function EndpointResponse($queryStream, $show_result = false) {
			try {
				$response = $this->implementQueryStream($queryStream);
				return ($show_result) ? $response : $this->genericSuccess();
			} catch (Exception $e) {
				throw $e;
			}
		}

	} ## User
?>