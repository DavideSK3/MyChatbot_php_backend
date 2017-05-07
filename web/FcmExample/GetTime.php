<?php 
 
require_once 'DbOperation.php';

$db = new DbOperation(); 

$before = $db->getCurrentTime();
$beforenow = $db->getCurrentNow();
$db->setTimezone();
$after = $db->getCurrentTime();
$afternow = $db->getCurrentNow();

$response = array(); 

$response['before'] = $before; 
$response['after'] = $after; 

$response['beforenow'] = $beforenow; 
$response['afternow'] = $afternow; 

echo json_encode($response);