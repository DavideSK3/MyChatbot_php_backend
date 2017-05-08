<?php
 
class DbOperation
{
    //Database connection link
    private $con;
 
    //Class constructor
    function __construct()
    {
        //Getting the DbConnect.php file
        require_once dirname(__FILE__) . '/DbConnect.php';
 
        //Creating a DbConnect object to connect to the database
        $db = new DbConnect();
 
        //Initializing our connection link of this class
        //by calling the method connect of DbConnect class
        $this->con = $db->connect();
        $this->setTimezone();
    }

    public function setTimezone(){
        $stmt=$this->con->prepare("SET time_zone = 'Europe/Rome'");
        $stmt->execute();
    }
    
    public function getCurrentTime(){
        $stmt=$this->con->prepare("SELECT CURRENT_TIMESTAMP() as time");
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc()['time'];
    }

     public function getCurrentNow(){
        $stmt=$this->con->prepare("SELECT now() as time");
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc()['time'];
    }
 
    //storing token in database 
    public function registerDevice($fbid,$token,$name){
        if(!$this->isfbidExist($fbid)){
            $stmt = $this->con->prepare("INSERT INTO users (fbid, token, name) VALUES (?,?,?) ");
            $stmt->bind_param("sss",$fbid,$token,$name);
            if($stmt->execute())
                return 0; //return 0 means registering new device
            return 1; //return 1 means failure
        }else{
            $stmt = $this->con->prepare("UPDATE users SET token=?, name=? WHERE fbid=?");
            $stmt->bind_param("sss",$token,$name,$fbid);
            if($stmt->execute())
                return 2; //returning 2 means updating existing fb account
            return 1; //return 1 means failure
        }
    }

    //
    public function loginDevice($token){
        if($this->isTokenExist($token)){
            return 1; //return 1 means succesful login
        }else{
            return 0;
        }
    }

    public function removeDevice($fbid){
        $stmt = $this->con->prepare("UPDATE users SET token='null' WHERE fbid=?");
        $stmt->bind_param("s",$fbid);
        if($stmt->execute())
            return 1; //1 means successfully removed device token from existing fb id
        return 0;
    }
 
    //the method will check if fbid already exist 
    private function isfbidExist($fbid){
        $stmt = $this->con->prepare("SELECT fbid FROM users WHERE fbid = ?");
        $stmt->bind_param("s",$fbid);
        $stmt->execute();
        $stmt->store_result();
        $num_rows = $stmt->num_rows;
        $stmt->close();
        return $num_rows > 0;
    }

     private function isTokenExist($token){
        $stmt = $this->con->prepare("SELECT fbid FROM users WHERE token = ?");
        $stmt->bind_param("s",$token);
        $stmt->execute();
        $stmt->store_result();
        $num_rows = $stmt->num_rows;
        $stmt->close();
        return $num_rows > 0;
    }
 
    //getting all tokens to send push to all users
    public function getAllTokens(){
        $stmt = $this->con->prepare("SELECT token FROM users");
        $stmt->execute(); 
        $result = $stmt->get_result();
        $tokens = array(); 
        while($token = $result->fetch_assoc()){
            array_push($tokens, $token['token']);
        }
        return $tokens; 
    }

    //getting all tokens to send push from a chat except for the sender
    public function getAllTokensByChatidExceptFbid($chatid,$fbid){
        $stmt = $this->con->prepare("SELECT u.token FROM users u, chats c WHERE c.chatid=? AND c.participant!=? AND u.fbid=c.participant");
        $stmt->bind_param("ss",$chatid,$fbid);
        $stmt->execute(); 
        $result = $stmt->get_result();
        $tokens = array(); 
        while($token = $result->fetch_assoc()){
            array_push($tokens, $token['token']);
        }
        return $tokens; 
    }
 
    //getting a specified token to send push to selected device
    public function getTokenByfbid($fbid){
        $stmt = $this->con->prepare("SELECT token FROM users WHERE fbid = ?");
        $stmt->bind_param("s",$fbid);
        $stmt->execute(); 
        $result = $stmt->get_result()->fetch_assoc();
        return array($result['token']);        
    }
 
    //getting all the registered users from database 
    public function getAllusers(){
        $stmt = $this->con->prepare("SELECT * FROM users");
        $stmt->execute();
        $result = $stmt->get_result();
        return $result; 
    }

    //getting all the friend of an existing account
    public function getFriends($fbid){
        $stmt = $this->con->prepare("SELECT fbid, name FROM users, friends where friendid=fbid AND id=?");
        $stmt->bind_param("s",$fbid);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result; 
    }

    public function addFriend($fbid,$friendid){
        if(!$this->friendshipExists($fbid,$friendid)){
            $stmt = $this->con->prepare("INSERT INTO friends (id, friendid) VALUES (?,?) ");
            $stmt->bind_param("ss",$fbid,$friendid);
            if($stmt->execute())
                return 1; //return 0 means registering new friend
            return 0; //return 1 means failure
        }
        return 2; //friend already existing
    }

    private function friendshipExists($fbid,$friendid){
        $stmt = $this->con->prepare("SELECT id FROM friends WHERE id = ? AND friendid = ?");
        $stmt->bind_param("ss",$fbid, $friendid);
        $stmt->execute();
        $stmt->store_result();
        $num_rows = $stmt->num_rows;
        $stmt->close();
        return $num_rows > 0;
    }

    //get name from fbid
    public function getNameByFbid($fbid){
        $stmt = $this->con->prepare("SELECT name FROM users where fbid=?");
        $stmt->bind_param("s",$fbid);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result["name"]; 
    }

    //getting all the chats for an existing account
    public function getChats($fbid){
        $stmt = $this->con->prepare("SELECT chatid, chatname, time FROM chats where participant=? ORDER BY time DESC");
        $stmt->bind_param("s",$fbid);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result; 
    }

    public function getMessages($chatid){
        $stmt = $this->con->prepare("SELECT sender, content, time, intent, restaurant, cinema FROM messages where chatid=? ORDER BY time ASC");
        $stmt->bind_param("s",$chatid);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result; 
    }

    public function openChat($id,$friendid){
    	$name=$this->getNameByFbid($id);
    	$friendname=$this->getNameByFbid($friendid);
    	$chatid=$this->existsChat($id,$friendid);
    	$result = array();
    	if($chatid>0){
    		$result["chatid"]=$chatid;
        }else{
        	$chatid=$this->createChat($id,$friendid,$name,$friendname);
        	$result["chatid"]=$chatid;
        }
    	$result["chatname"]=$this->getChatNameById($chatid,$id);
        return $result;
    }

    private function existsChat($id,$friendid){
        $stmt = $this->con->prepare("SELECT c1.chatid FROM chats c1, chats c2 WHERE c1.chatid = c2.chatid AND c1.participant=? AND c2.participant=? AND c1.isgroup=FALSE LIMIT 1");
        $stmt->bind_param("ss",$id,$friendid);
        $stmt->execute();
        $result = $stmt->get_result();
        $chatid= 0;
        while($chat = $result->fetch_assoc()){
			$chatid=$chat['chatid'];
		}
        return $chatid;
    }

    public function createChat($id,$friendid,$name,$friendname){
    	$newchatid = $this->generateChatId();
    	$stmt = $this->con->prepare("INSERT INTO chats (chatid,chatname,participant) VALUES (?,?,?) ");
        $stmt->bind_param("sss",$newchatid,$friendname,$id);
        $stmt->execute();
        $stmt = $this->con->prepare("INSERT INTO chats (chatid,chatname,participant) VALUES (?,?,?) ");
        $stmt->bind_param("sss",$newchatid,$name,$friendid);
        $stmt->execute();
        return $newchatid;
    }

    public function generateChatId(){
    	$stmt = $this->con->prepare("SELECT MAX(chatid) AS max FROM chats ");
        $stmt->execute();
        $newchatid= $stmt->get_result()->fetch_assoc();
        return $newchatid["max"]+1;
    }

    public function getChatNameById($chatid,$id){
        $stmt = $this->con->prepare("SELECT chatname FROM chats where chatid=? AND participant=? LIMIT 1");
        $stmt->bind_param("ss",$chatid,$id);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result["chatname"]; 
    }

    public function sendMessage($chatid,$sender,$content,$intent,$restaurant,$cinema){
    	$stmt = $this->con->prepare("INSERT INTO messages (chatid,sender,content,intent,restaurant,cinema) VALUES (?,?,?,?,?,?) ");
    	$stmt->bind_param("ssssss",$chatid,$sender,$content,$intent,$restaurant,$cinema);
        if($stmt->execute()){
            $this->updateChatTime($chatid);
        	return 1;
        }
        return 0;
    }

    public function updateChatTime($chatid){
        $stmt = $this->con->prepare("UPDATE chats SET time = now() WHERE chatid=?");
        $stmt->bind_param("s",$chatid);
        $stmt->execute();
        return;
    }

    public function suggestRestaurant($lat,$lon){
        $stmt = $this->con->prepare("SELECT NOME as NOME, ENGLISH_DESCRIPTION, CATEGORIA, LATITUDINE, LONGITUDINE, VIA, NUMBER, CAP, CITTA, CONTATTO_TELEFONO, CONTATTO_EMAIL, CONTATTO_URL,(
                6371 * acos(
                    cos(radians(?)) * cos(radians(LATITUDINE)) * cos(radians(LONGITUDINE) - radians(?))
                    +
                    sin(radians(?)) * sin(radians(LATITUDINE))
                )
            ) AS distance
            FROM restaurants
            ORDER BY distance
            LIMIT 5;");
        $stmt->bind_param("sss",$lat,$lon,$lat);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result; 
    }
}