<-- Suraj Kakkad spk101 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> Frequently Asked Questions </title>
<link rel="stylesheet" href="style.css?v=1.0" />
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="content">

	<%
	String url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "group20", "group20!");
			String username = (session.getAttribute("username")).toString();
			String questionsQuery = "SELECT questionText, answer FROM Questions WHERE user=?";

			ps = conn.prepareStatement(questionsQuery);
			ps.setString(1, username);
			rs = ps.executeQuery();

			if(rs.next()){ %>
				<h1> Question Results: </h1>
				<p style="font-size: 8pt;"> 	**Please note that all questions may not be answered until a customer representative
				gets a chance to answer them.** </p>
				<table>
					<tr>
						<th> Question </th>
						<th> Answer </th>
					</tr>
					<% do { %>
						<tr>
							<td><%= rs.getString("questionText") %> </td>
							<td><%= rs.getString("answerText") %> </td>
						</tr>
			<% 		} while(rs.next()); %>
				</table>
			<% 	} else { %>
					<br><h3> There are currently no answers. </h3>
			<%	}  %>

		<%

		} catch (SQLException e){
			out.print("<p>Error connecting to MYSQL server.</p>");
		    e.printStackTrace();
		} finally {
			try { rs.close(); } catch (Exception e) {}
			try { conn.close(); } catch (Exception e) {}
		}
	%>
	<p> <a href="questions.jsp">Click here to return to ask another questions</a> </p>
	</div>
</body>
</html>
