<?php 
 require_once 'DbOperation.php';
 $response = array(); 
 
 if($_SERVER['REQUEST_METHOD']=='POST'){
 
 $fbid = $_POST['fbid'];
 $friendid = $_POST['friendid'];
 
 $db = new DbOperation(); 
 
 $result = $db->addFriend($fbid,$friendid);
 
 if($result == 1){
 $response['error'] = false; 
 $response['message'] = 'New Friend Added';
 }elseif($result == 2){
 $response['error'] = false; 
 $response['message'] = 'Friend already imported';
 }else{
 $response['error'] = true;
 $response['message']='Error adding Friend';
 }
 }else{
 $response['error']=true;
 $response['message']='Invalid Request...';
 }
 
 echo json_encode($response);