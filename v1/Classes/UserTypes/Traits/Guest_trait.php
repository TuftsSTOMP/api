<?php	

/*
 *  Guest_trait.php
 *  Author: Sam Heilbron
 *  Last Updated: January 2017
 *
 *  Endpoints for Guest
 */


	trait Guest_trait {
		/*********************************************************************/
		/************************  PUBLIC API CALLS  *************************/
		/*********************************************************************/
		/*
			/Stomp/guest/remove
			/Stomp/guest/return

		*/
		/*********************************************************************/
		/*********************************************************************/	


		protected function guest() {
			$d = (array_key_exists (0, $this->descriptor)) ? $this->descriptor[0] : null;
			switch($d) {
				case 'remove': 
					$result = $this->_submitRemove();
					break;
				case 'return': 
					$result = $this->_submitReturn();
					break;
				default: 
					throw new Exception("Invalid Guest Action");
			}
			return $result;
		}
		
		

		/*********************************************************************/
		/************************  PRIVATE  METHODS  *************************/
		/*********************************************************************/

		private function _submitRemove() {			
			try {
				foreach ($this->args as $material => $quantity) {
					//replace _ with ' ' to account for materials with multiple words
					$mid = $this->_validateMaterialRemove(str_replace('_', ' ', $material), $quantity);
					$queryArray[] = "UPDATE Material SET 
										q_avail = q_avail - ".$quantity."
									 WHERE mid = '".$mid."'";
				}
				return $this->EndpointResponse($queryArray, false);
			} catch (Exception $e) {
				throw $e;
			}
		}

		private function _submitReturn() {			
			try {
				foreach ($this->args as $material => $quantity) {
					$queryArray[] = "CALL Guest_ReturnMaterial('".str_replace('_', ' ', $material)."', ".$quantity.")";
				}
				return $this->EndpointResponse($queryArray, false);
			} catch (Exception $e) {
				throw $e;
			}
		}
		
		/* if valid return mid */
		private function _validateMaterialRemove($m, $q) {
			$queryArray[] = "CALL Validate_RemoveQfromMaterial ('".$m."', ".$q.")";
			$result = $this->EndpointResponse($queryArray, true)[0]['_mid'];
			if($result == null) throw new Exception("Invalid amount requested");
			return $result;
		}
		

	} ## Guest_trait
?>