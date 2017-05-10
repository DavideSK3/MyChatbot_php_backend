<?php 
require_once 'DbOperation.php';
$response = array(); 

$db = new DbOperation(); 

$restaurants = $db->getMovies();

$response = array(); 

$response['error'] = false; 
$response['movies'] = array(); 

while($restaurant = $restaurants->fetch_assoc()){
	$temp = array();
	$temp['id']=$restaurant['id'];
	$temp['name']=$restaurant['name'];
	$temp['description']=$restaurant['description'];
	$temp['category']=$restaurant['category'];
	$temp['length']=$restaurant['length'];
	$temp['image']=$restaurant['image'];
	array_push($response['movies'],$temp);
}

echo json_encode($response);