<?php 
require_once 'DbOperation.php';
$response = array(); 

$lon = $_POST['lon'];
$lat = $_POST['lat'];

$db = new DbOperation(); 

$restaurants = $db->suggestRestaurant($lat,$lon);

$response = array(); 

$response['error'] = false; 
$response['restaurants'] = array(); 

while($restaurant = $restaurants->fetch_assoc()){
	$temp = array();
	$temp['name']=$restaurant['NOME'];
	$temp['desc']=$restaurant['ENGLISH_DESCRIPTION'];
	$temp['lat']=$restaurant['LATITUDINE'];
	$temp['lon']=$restaurant['LONGITUDINE'];
	$temp['street']=$restaurant['VIA'];
	$temp['number']=$restaurant['NUMBER'];
	$temp['city']=$restaurant['CITTA'];
	$temp['phone']=$restaurant['CONTATTO_TELEFONO'];
	$temp['email']=$restaurant['CONTATTO_EMAIL'];
	$temp['url']=$restaurant['CONTATTO_URL'];
	$temp['distance']=$restaurant['distance'];
	array_push($response['restaurants'],$temp);
}

echo json_encode($response);