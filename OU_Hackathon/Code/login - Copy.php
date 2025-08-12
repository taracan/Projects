<?php
$n=$_POST["uname"];
$p=$_POST["pwd"];
$c=mysqli_connect('localhost','root','','infinity');
$q="select * from login";
$r=mysqli_query($c,$q);
$f=0;
while($row=mysqli_fetch_array($r))
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
echo"The login credentials are valid";
else
echo"The login credentials are invalid";
?>