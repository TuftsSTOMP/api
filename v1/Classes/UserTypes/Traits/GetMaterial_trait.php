<?php
	
	trait GetMaterial_trait {
		
		/**************************************************************************************************************/
		/*******************************************  PUBLIC API CALLS  ***********************************************/
		/**************************************************************************************************************/

		/*
			Valid Enpoints:
			
			/Stomp/material/%material%/info
			/Stomp/material/%material%/transactionTotal
			
			/Stomp/getFullMaterialList

		*/
		
		protected function material() {
			$m = (array_key_exists (0, $this->args)) ? $this->args[0] : null;
			$d = (array_key_exists (1, $this->args)) ? $this->args[1] : null;
			switch($d) {
				case 'info': 
					$result = $this->_getMaterialInfo($m);
					break;
				case 'transactionTotal': 
					$result = $this->_getMaterialTransactions($m);
					break;
				default: 
					throw new Exception("Invalid Material Request");
			}
			return $result;
		}
		
		//include selected=false to help with visualization in app, though it isn't necessary from data management
		//would like to remove eventually
		protected function getFullMaterialList() {
			$query = "SELECT name, LEAST(q_avail, max_checkout_q) AS max_quantity, false AS selected FROM Material";
			return $this->EndpointResponse($query, true);
		}
		
		
		/**************************************************************************************************************/
		/******************************************  PRIVATE HELPER METHODS  ******************************************/
		/**************************************************************************************************************/
		
		
		private function _getMaterialInfo($m) {
			$query = "SELECT name, q_avail, q_reserved, q_removed, max_checkout_q, low_q_thresh FROM Material where name = '".$m."'";
			return $this->EndpointResponse($query, true);
		}
		
		private function _getMaterialTransactions($m) {
			$query = "
				SELECT m.name, tr.quantity, tr.transaction_date, tr.action_date, tr.res_type, s.f_name, s.l_name 
				FROM Transaction AS tr 
				INNER JOIN Material AS m 
				USING (mid)
				INNER JOIN Stomper AS s 
				USING (uid) 
				WHERE m.name = '".$m."'
				ORDER BY tr.res_type";
			return $this->EndpointResponse($query, true);
		}
		

	} ## GetMaterial_trait
?>