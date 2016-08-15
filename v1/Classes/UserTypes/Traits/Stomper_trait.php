<?php
	
	trait Stomper_trait {
		
		/**************************************************************************************************************/
		/*******************************************  PUBLIC API CALLS  ***********************************************/
		/**************************************************************************************************************/
		
		/*
			Valid Enpoints:
		
			/Stomp/checkout/reserve
			/Stomp/checkout/remove
	
			/Stomp/checkIn
			
			/Stomp/team/reservationList
			/Stomp/team/checkedoutList
			/Stomp/team/reservationTotal
			/Stomp/team/checkedoutTotal

		*/
		protected function example() {
			echo $this->uid;
		}
		
		protected function checkout() {
			$d = (array_key_exists (0, $this->descriptor)) ? $this->descriptor[0] : null;
			switch($d) {
				case 'reserve': 
					$result = $this->_submitCheckOut("reserve", "q_reserved");
					break;
				case 'remove': 
					$result = $this->_submitCheckOut("remove", "q_removed");
					break;
				default: 
					throw new Exception("Invalid Checkout Type");
			}
			return $result;
		}
		
		protected function checkIn() {
			$queryArray = [];
			foreach ($this->args as $material => $quantity) {
				$queryArray[] = "CALL Stomper_CheckIn(".$this->tid.", '".$material."', ".$quantity.")";
			}
			return $this->EndpointResponse($queryArray, false);
		}
		
				
		protected function me() {
			$d = (array_key_exists (0, $this->args)) ? $this->args[0] : null;
			switch($d) {
				default: 
					throw new Exception("Invalid Personal Information Type");
			}
			return $result;
		}
		
		protected function team() {
			$d = (array_key_exists (0, $this->args)) ? $this->args[0] : null;
			$m = (array_key_exists (1, $this->args)) ? $this->args[1] : null;
			switch($d) {
				case 'reservationList': 
					$result = $this->_getTeamTransactionList("reserve");
					break;
				case 'checkedoutList': 
					$result = $this->_getTeamTransactionList("remove");
					break;
				case 'reservationTotal': 
					$result = $this->_getTeamTransactionTotal("reserve");
					break;
				case 'checkedoutTotal': 
					$result = $this->_getTeamTransactionTotal("remove");
					break;
				case 'material':
					$result = $this->_getMaterialTransactionsFilterByTeam($m);
					break;
				default: 
					throw new Exception("Invalid Team Request ");
			}
			return $result;
		}
		
		
		//v2
		//protected function getMySavedSearches() {}

		
		/**************************************************************************************************************/
		/******************************************  PRIVATE HELPER METHODS  ******************************************/
		/**************************************************************************************************************/
		
		//include in v2 --> private function saveCheckOut() {}
		
		//would like to turn all endpoint responses into a single query stream. not sure how to yet. perhaps v2
		private function _submitCheckOut($res_type, $q_type) {
			try {
				$trid = $this->_getNewTransactionID();
				$transaction = "INSERT INTO Transaction 
									(trid, tid, uid, mid, quantity, transaction_date, res_type, action_date) VALUES";
				foreach ($this->args as $material => $quantity) {
					$mid = $this->_validateMaterialCheckOut($material, $quantity);
					$transaction .= "(".$trid.", ".$this->tid.", ".$this->uid.", ".$mid.", ".$quantity.", NOW(), '".$res_type."', ADDTIME(NOW(), '14 0:00:00.00')),";
					$queryArray[] = "UPDATE Material SET 
										".$q_type." = ".$q_type." + ".$quantity.",
										q_avail = q_avail - ".$quantity."
									 WHERE mid = '".$mid."' ";
				}
				$queryArray[] = rtrim($transaction, ","); //remove last comma from transaction value list
				return $this->EndpointResponse($queryArray, false);
			} catch (Exception $e) {
				throw $e;
			}
		}
		
		
		private function _getTeamTransactionList($transaction_type) {
			$query = "CALL getTeamTransactionList(".$this->tid.", '".$transaction_type."')";
			return $this->EndpointResponse($query, true);
		}
		
		private function _getTeamTransactionTotal($transaction_type) {
			$query = "CALL getTeamTransactionTotal(".$this->tid.", '".$transaction_type."')";
			return $this->EndpointResponse($query, true);
		}
		
		private function _getMaterialTransactionsFilterByTeam($m) {
			$query = "
				SELECT m.name, tr.quantity, tr.transaction_date, tr.action_date, tr.res_type, s.f_name, s.l_name 
				FROM Transaction AS tr 
				INNER JOIN Material AS m 
				USING (mid)
				INNER JOIN Stomper AS s 
				USING (uid) 
				WHERE m.name = '".$m."'
				AND tr.tid = ".$this->tid."
				ORDER BY tr.res_type";
			
			return $this->EndpointResponse($query, true);
		}
		
		/* if valid return mid */
		private function _validateMaterialCheckOut($m, $q) {
			$queryArray[] = "CALL Validate_RemoveQfromMaterial ('".$m."', ".$q.")";
			$result = $this->EndpointResponse($queryArray, true)[0]['_mid'];
			if($result == null) throw new Exception("Invalid amount requested");
			return $result;
		}
		
		private function _getNewTransactionID() {
			$query = "SELECT MAX(trid) AS trid FROM Transaction";
			return $this->EndpointResponse($query, true)[0]['trid'] + 1;
		}
		

	} ## Stomper_trait
?>