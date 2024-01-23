

<?php

  define("DB_HOST", "localhost");
  define("DB_USER", "");
  define("DB_PASSWORD", "");
  define("DB_NAME", "");

  $connect=mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
  
  $major = $_POST["search2a"];

if(isset($_REQUEST["auth"]))
  {

    $authkey = $_REQUEST["auth"];
    if($authkey == "kjgdkhdfldfguttedfgr")
    {

  if($connect) {
	  $sql="
          SELECT COUNT(student_id) AS jumlah FROM t_students
          WHERE major='$major'
	";

$query=mysqli_query($connect, $sql);
$results=array();


while($row=mysqli_fetch_assoc($query)) {
		$results[]=$row;
}

echo json_encode($results);
}
  }
}

?>
