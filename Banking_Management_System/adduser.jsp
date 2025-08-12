<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%
String un=request.getParameter("usname");
String pwd=request.getParameter("pwd");
String an=request.getParameter("an");
int acn=Integer.parseInt(an);
String mnb=request.getParameter("minb");
int minb=Integer.parseInt(mnb);
String gen=request.getParameter("g");
String email=request.getParameter("em");
String phn=request.getParameter("pn");
int pn=Integer.parseInt(phn);
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","123456");
	Statement stmt=con.createStatement();
	stmt.executeUpdate("insert into customer(username,password,account,balance, gender,mail,phno)values('"+un+"','"+pwd+"',"+acn+","+minb+",'"+gen+"','"+email+"',"+pn+")");
	out.println("thank you");
	
}
	catch(Exception e)
	{
		out.println(e);
	}


%>