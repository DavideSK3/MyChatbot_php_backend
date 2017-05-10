<?php 
require_once 'DbOperation.php';
$response = array(); 

$id = $_POST['id'];

$db = new DbOperation(); 

$movies = $db->getSingleMovie($id);

$response = array(); 

$response['error'] = false; 
$response['movies'] = array(); 

while($movie = $movies->fetch_assoc()){
	$temp = array();
	$temp['id']=$movie['id'];
	$temp['name']=$movie['name'];
	$temp['description']=$movie['description'];
	$temp['category']=$movie['category'];
	$temp['length']=$movie['length'];
	$temp['image']=$movie['image'];
	array_push($response['movies'],$temp);
}

echo json_encode($response);