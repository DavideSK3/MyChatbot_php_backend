<?php 
require_once 'DbOperation.php';
$response = array(); 

$sender = $_POST['sender'];
$content = $_POST['content'];
$chatid = $_POST['chatid'];
$intent = $_POST['intent'];
$restaurant = $_POST['restaurant'];
$cinema = $_POST['cinema'];
$image = $_POST['image'];

$db = new DbOperation(); 

$result = $db->sendMessage($chatid,$sender,$content,$intent,$restaurant,$cinema,$image);

$response = array(); 

if($result=1){
	$response['error'] = false; 
	$response['message'] = "Message Sent Succesfully!";
} else {
	$response['error'] = true; 
	$response['message'] = "Error sendind message";
}

echo json_encode($response);