<?php
$return["data"] = array();


define('HOST', 'localhost');
define('USER', '');
define('PASS', '');
define('DB', '');
$connect = mysqli_connect(HOST, USER, PASS, DB) or die('Not Connect');


  if(isset($_REQUEST["auth"]))
  {
    $authkey = $_REQUEST["auth"];
    if($authkey == "kjgdkhdfldfguttedfgr")
    {
        $json["data"] = array();
        $sql = "
			SELECT major, COUNT(major) AS jumlah
			FROM t_students
			GROUP BY major
        ";
        $res = mysqli_query($connect, $sql);
        $numrows = mysqli_num_rows($res);
        while($array = mysqli_fetch_assoc($res))
        {
          array_push($return["data"], $array);
        }
        mysqli_close($connect);
        header('Content-Type: application/json');
    }
        else
        {
        $return["error"] = true;
        $return["msg"] = "Authentication error.";
        }
    }
    else{
        $return["error"]  = true;
        $return["msg"] = "Send auth key.";
        }
    header('Content-Type: application/json');
    echo json_encode($return);
    ?>
    
