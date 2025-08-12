<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%
String an=request.getParameter("an");
int acn=Integer.parseInt(an);
String am=request.getParameter("amt");
int amt=Integer.parseInt(am);
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","123456");
	Statement stmt=con.createStatement();
	ResultSet rs=stmt.executeQuery("select balance from customer where account="+acn);
	while(rs.next())
	{
		
		 amt=amt+Integer.parseInt(rs.getString(1)); }
	stmt.executeUpdate("UPDATE customer SET balance="+amt+" WHERE account="+acn);
	out.println("thank you");
	
	
}
	catch(Exception e)
	{
		out.println(e);
	}


%>