<?php 
require_once 'DbOperation.php';
$response = array(); 

$chatid = $_POST['chatid'];

$db = new DbOperation(); 

$messages = $db->getMessages($chatid);

$response = array(); 

$response['error'] = false; 
$response['messages'] = array(); 

while($message = $messages->fetch_assoc()){
	$temp = array();
	$temp['sender']=$message['sender'];
	$temp['content']=$message['content'];
	$temp['time']=$message['time'];
	$temp['intent']=$message['intent'];
	$temp['restaurant']=$message['restaurant'];
	$temp['cinema']=$message['cinema'];
	$temp['image']=$message['image'];	
	array_push($response['messages'],$temp);
}

echo json_encode($response);