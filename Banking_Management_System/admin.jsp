<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<% int f=0;

String s1=request.getParameter("usname");
String s2=request.getParameter("pwd");
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","123456");
	Statement stmt=con.createStatement();
	ResultSet rs=stmt.executeQuery("select * from admin");
	while(rs.next())
	{
		if((s1.equals(rs.getString(1))) && (s2.equals(rs.getString(2))))
		{
			response.sendRedirect("red.html");
			  f=0;
				break;
		}
		else 
			f=1;
			
			
		
	}
}
	catch(Exception e)
	{
		out.println(e);
	}
	if(f==1)
out.println("notvalid");

%>

