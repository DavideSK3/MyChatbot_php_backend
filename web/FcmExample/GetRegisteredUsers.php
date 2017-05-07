<?php 
 
 require_once 'DbOperation.php';
 
 $db = new DbOperation(); 
 
 $users = $db->getAllusers();
 
 $response = array(); 
 
 $response['error'] = false; 
 $response['users'] = array(); 
 
 while($user = $users->fetch_assoc()){
 $temp = array();
 $temp['id']=$user['id'];
 $temp['fbid']=$user['fbid'];
 $temp['token']=$user['token'];
 array_push($response['users'],$temp);
 }
 
 echo json_encode($response);