<?php
$n=$_POST["rname"];
$p=$_POST["pwd"];0.

$c=mysqli_connect('localhost','root','','infinity');
$q="select * from login";
$res=mysqli_query($c,$q);
$d="INSERT INTO login(username,password) values($n,$p)";
$i=mysqli_query($c,$d);
if(!$i)
{
echo "not inserted";
}
$q="select * from login";
$res=mysqli_query($c,$q);
$f=0;
while($row=mysqli_fetch_array($res))
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
echo"The registration is valid";
else
echo"The  registration is invalid";
?>