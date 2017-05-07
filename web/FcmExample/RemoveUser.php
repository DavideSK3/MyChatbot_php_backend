<?php 
 require_once 'DbOperation.php';
 $response = array(); 
 
 if($_SERVER['REQUEST_METHOD']=='POST'){
 
 $fbid = $_POST['fbid'];
 
 $db = new DbOperation(); 
 
 $result = $db->removeDevice($fbid);
 
 if($result == 1){
 $response['error'] = false; 
 $response['message'] = 'Logout Succesful';
 }elseif($result == 0){
 $response['error'] = true; 
 $response['message'] = 'Logout error';
 }

 }else{
 $response['error']=true;
 $response['message']='Invalid Request...';
 }
 
 echo json_encode($response);