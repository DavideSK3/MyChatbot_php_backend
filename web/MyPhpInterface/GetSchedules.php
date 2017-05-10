<?php 
require_once 'DbOperation.php';
$response = array(); 


$id = $_POST['id'];
$day = $_POST['day'];

$db = new DbOperation(); 

$schedules = $db->getSchedules($id,$day);

$response = array(); 

$response['error'] = false; 
$response['schedules'] = array(); 

while($schedule = $schedules->fetch_assoc()){
	$temp = array();
	$temp['id']=$schedule['id'];
	$temp['cinema']=$schedule['cinema'];
	$temp['day']=$schedule['day'];
	$temp['hour']=$schedule['hour'];
	array_push($response['schedules'],$temp);
}

echo json_encode($response);