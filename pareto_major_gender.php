
<?php
  
include "connection.php";

$major=$_POST['search2'];


if(isset($_REQUEST["auth"]))
  {

    $authkey = $_REQUEST["auth"];
    if($authkey == "kjgdkhdfldfguttedfgr")
    {

  if($connect) {
	  $sql="
	SELECT gender, COUNT(gender) AS count
	FROM t_students
	WHERE major='$major'
	GROUP BY gender
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
