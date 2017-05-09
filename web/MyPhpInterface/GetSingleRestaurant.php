<?php 
require_once 'DbOperation.php';
$response = array(); 

$id = $_POST['id'];

$db = new DbOperation(); 

$restaurants = $db->getSingleRestaurant($id);

$response = array(); 

$response['error'] = false; 
$response['restaurants'] = array(); 

while($restaurant = $restaurants->fetch_assoc()){
	$temp = array();
	$temp['id']=$restaurant['ID'];
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
	array_push($response['restaurants'],$temp);
}

echo json_encode($response);