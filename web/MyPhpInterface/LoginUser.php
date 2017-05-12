<?php 
 require_once 'DbOperation.php';
 $response = array(); 
 
 if($_SERVER['REQUEST_METHOD']=='POST'){
 
	 $token = $_POST['token'];
	 $version = $_POST['version'];
	 
	 $db = new DbOperation(); 

	 if($db->checkVersion($version)){
	 
		 $result = $db->loginDevice($token);
		 
		 if($result == 0){
			 $response['error'] = true; 
			 $response['message'] = 'Device not registered';
		 }else{
			 $response['error'] = false;
			 $response['message']='Succesfully Logged in';
		 }
	} else {
		$response['error'] = true; 
		$response['message'] = 'Outdated Client Version!';
	}

 }else{
 $response['error']=true;
 $response['message']='Invalid Request...';
 }
 
 echo json_encode($response);