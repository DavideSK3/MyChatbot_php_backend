<?php 
require_once 'DbOperation.php';
$response = array(); 

$id = $_POST['id'];
$friendid = $_POST['friendid'];

$db = new DbOperation(); 

$messages = $db->openChat($id,$friendid);

$response = array(); 

$response['error'] = false; 
$response['chatid']=$messages['chatid'];
$response['chatname']=$messages['chatname'];

echo json_encode($response);