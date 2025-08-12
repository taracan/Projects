<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%


String s2=request.getParameter("pwd");
String s1=session.getAttribute("user").toString();
String s3=session.getAttribute("password").toString();
if(s2.equals(s3))
out.println("try a new passcode");
else
{
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","123456");
	Statement stmt=con.createStatement();
	ResultSet rs=stmt.executeQuery("select * from customer");
	//while(rs.next())
	//{
		
	stmt.executeUpdate("UPDATE customer SET password='"+s2+"' WHERE username='"+s2+"'and password='"+s3+"'");
	println("thanku");
	//		}

	}

catch(Exception e)
	{
		out.println(e);
	}

}
%>