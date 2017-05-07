<?php 
require_once 'DbOperation.php';
$response = array(); 

$fbid = $_POST['fbid'];

$db = new DbOperation(); 

$chats = $db->getChats($fbid);

$response = array(); 

$response['error'] = false; 
$response['chats'] = array(); 

while($chat = $chats->fetch_assoc()){
	$temp = array();
	$temp['chatid']=$chat['chatid'];
	$temp['chatname']=$chat['chatname'];
	$temp['time']=$chat['time'];
	array_push($response['chats'],$temp);
}

echo json_encode($response);