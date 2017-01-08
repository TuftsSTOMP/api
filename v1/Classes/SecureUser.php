<?php

/*
 *  SecureUser.php
 *  Author: Sam Heilbron
 *  Last Updated: January 2017
 *
 *  Creates the User type from a JWT
 */

 	require_once 'vendor/autoload.php';
	use Zend\Config\Factory;
	
	/* List All UserTypes */
	require_once 'UserTypes/UserTypes.php';
	
	class SecureUser {
		private static $uid = null;
    	private static $tid = null;
        private static $api_version = null;
    	
    	public static function generate($request, $origin) {
    		try {
				$userType = self::_getAuthorized();
				if(class_exists($userType)) {
					return new $userType($request, self::$uid, self::$tid, self::$api_version);
				}
				throw new Exception("Invalid Permissions");
			} catch  (Excpetion $e) {
				throw $e;
			}
    	}
    	
    	private static function _getAuthorized() {
    		$requestHeaders = apache_request_headers();
    		if (isset($requestHeaders['Authorization'])) {
    			$AUTH_HEADER = $requestHeaders['Authorization'];
				return self::_validateJWT($AUTH_HEADER);	
    		}
    		throw new Exception("Invalid Authorization");
    	}
    	
    	private static function _validateJWT($jwt) {
    		try {	
    			$config = Factory::fromFile('config/config.php', true);
    			$secretKey = base64_decode($config->get('JWT')->get('key'));
    			$signingAlgorithm = $config->get('JWT')->get('algorithm');
    		
    			$token = JWT::decode($jwt, $secretKey, array($signingAlgorithm));
    			
    			/* perhaps checks required to see if token->data even exists*/
    			self::$uid = $token->data->uid;
    			self::$tid = $token->data->tid;
                self::$api_version = $token->data->api_version;

    			return $token->data->scope;
    		} catch (Exception $e) {
    			throw $e;
    		}
    	}
    } ## SecureUser
?>