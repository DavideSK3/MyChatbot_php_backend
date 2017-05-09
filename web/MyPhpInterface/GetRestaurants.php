<?php 
require_once 'DbOperation.php';
$response = array(); 

$lon = $_POST['lon'];
$lat = $_POST['lat'];

$db = new DbOperation(); 

$restaurants = $db->getRestaurants($lat,$lon);

$response = array(); 

$response['error'] = false; 
$response['restaurants'] = array(); 

while($restaurant = $restaurants->fetch_assoc()){
	$temp = array();
	$temp['id']=$restaurant['ID'];
	$temp['name']=$restaurant['NOME'];
	$temp['street']=$restaurant['VIA'];
	$temp['number']=$restaurant['NUMBER'];
	$temp['city']=$restaurant['CITTA'];
	$temp['distance']=$restaurant['distance'];
	array_push($response['restaurants'],$temp);
}

echo json_encode($response);