<?php 

$url = getenv('JAWSDB_MARIA_URL');
$dbparts = parse_url($url);

 define('DB_USERNAME',$dbparts['user']);
 define('DB_PASSWORD',$dbparts['pass']);
 define('DB_NAME',ltrim($dbparts['path'],'/'));
 define('DB_HOST',$dbparts['host']);
 define('FIREBASE_API_KEY', 'AAAAraLTzow:APA91bEc4lJiRY_4PuGovJSTX7HxcvYe68YqOygWodabvvezfQnJuFMHgZPun2N5kqWGQV6eMfZWAnVQ3CAVDnng895DWJK1fUJcJg9vFnr0OKJKQYuSJuc1QILI8CfV_owIMERWQWJJ');