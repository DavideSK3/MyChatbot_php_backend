<?php 
require_once 'DbOperation.php';
$response = array(); 

$fbid = $_POST['fbid'];

$db = new DbOperation(); 

$friends = $db->getFriends($fbid);

$response = array(); 

$response['error'] = false; 
$response['friends'] = array(); 

while($friend = $friends->fetch_assoc()){
	$temp = array();
	$temp['fbid']=$friend['fbid'];
	$temp['name']=$friend['name'];
	array_push($response['friends'],$temp);
}

echo json_encode($response);