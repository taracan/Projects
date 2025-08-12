<?php
$n=$_POST["uname"];
$p=$_POST["pwd"];
$conn = mysqli_connect('localhost','root','','infinity');


if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully";

$q="select * from login";
$r=mysql_query($q);
$f=0;
while($row=mysql_fetch_array($r))
{
	if($row["username"]==$n && $row["password"]==$p)
	{
		$f=1;
		break;
	}
	else
		$f=0;
}
if($f==1)
{
echo"The login credentials are valid";
echo "<a href='complaints.html'>Complaints </a>";
}
else
echo"The login credentials are invalid";
?>