<%@page import="java.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>User Authentication Page</title>
</head>

<body>
	<%
	 	InitialContext ic = new InitialContext();
	 	DataSource ds = (DataSource) ic.lookup("java:/DefaultDS");
	 	Connection con = ds.getConnection();

	 	// select statement used to find record of the user that typed name and password
	 	PreparedStatement searchUser = con
	 			.prepareStatement("select * from cssrt.users where userName = ? and password = ? and isActive = 'true' ");

	 	// get parameters from request, from previos page
	 	searchUser.setString(1, request.getParameter("userName"));
			searchUser.setString(2, request.getParameter("pwd").toLowerCase());

	 	// run the searchUser statement
	 	ResultSet rs = searchUser.executeQuery();

	 	// if the record was found  (user found in the db) show the menu options
	 	if (rs.next()) {
	 		out.println(
	 				"<html>"+
	 				"<body>"+
	 						"<center>"+
	 				"<br>"+"<br>"+"<br>"+"<br>"+
	 					"<table>"+
	 						"<tr>"+
	 							"<td>"+ "<form action=removeOrder.jsp>"
	 			 				+ "<input type =submit value = 'נהל הזמנות'>" + "</form>"+"</td>"+

	 						"</tr>"+
	 						"<tr>"+
	 							"<td>"+ "<form action=manageShows.jsp>"
	 			 				+ "<input type =submit value =' נהל הופעות'>" + "</form>"+"</td>"+
	 						"</tr>"+
	 						"<tr>"+
	 							"<td>"+ "<form action=showUsers.jsp>"
	 			 				+ "<input type =submit value =' צפה במשתמשים'>" + "</form>"+"</td>"+
	 						"</tr>"+
	 					"</table>"+
	 				"</body>"+
	 					"</center>"+
	 						"</html>"
	 		);
		// if the user not found show error
	 	} else {
	 		out.println("<html>" + "<body>" + "Wrong user name or password"
	 				+ "<form action=AdminLogin.jsp>"
	 				+ "<input type =submit value = back>" + "</form>"
	 				+ "</body>" + "</html>");
	 	}
	 	// close the connection to the db
	 	con.close();
	 %>

</body>
</html>
