<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%
String an=request.getParameter("an");
int acn=Integer.parseInt(an);
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","123456");
	Statement stmt=con.createStatement();
	stmt.executeUpdate("DELETE FROM customer WHERE account="+acn);
	out.println("thank you");
	
}
	catch(Exception e)
	{
		out.println(e);
	}


%>