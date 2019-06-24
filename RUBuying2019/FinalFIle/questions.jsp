<!-- Suraj Kakkad spk101 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> Ask a Question </title>
<link rel="stylesheet" href="style.css?v=1.0" />
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div>
		<%
		/* set the attributes*/
		    String Email = (String) session.getAttribute("email");
		    int idu = (Integer) session.getAttribute("idUser");
			//	out.println(idu);
			//	out.println(Email);
		%>
	<%	if (request.getParameter("submit") != null && (request.getParameter("submit")).toString().equals("success")) { %>
			<h1>Your question has been submitted successfully.</h1>
	<%	} %>
	<%
	String url = null;
	Connection conn = null;
	PreparedStatement p = null;
	ResultSet r = null;
	url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	conn= DriverManager.getConnection(url, "group20", "group20!");
	%>

<table align="center">
		<tr>
			<h1 align="center">Submit a new question:</h1>
		</tr>
		<tr>
			<form align="center" action="questionsHandler.jsp" method="POST">
				<input type="hidden" name="idUser" value="<%= idu %>" />
				<td>
					<select name="idItem">
						<option selected="selected" disabled="disabled">Item Id</option>
							<%
								String itemsQuery = "SELECT idItem FROM Item";
								p = conn.prepareStatement(itemsQuery);
								r = p.executeQuery();
							while(r.next()){
							%>
							<option value="<%= r.getString("idItem") %>" name=" <%= r.getString("idItem") %> "> <%= r.getString("idItem") %>
							</option>
							<% } %>
					</select>
				</td>
				<td>
        <textarea style="font-size: 18pt" rows="1" cols="80" maxlength="250" id="msg" name="questionText"></textarea>
				</td>
				<td>
				<input type="submit" value="Submit"/>
				</td>
			</form>
		</tr>
</table>

	<%
		r.close();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			//Class.forName("com.mysql.jdbc.Driver").newInstance();
		 //conn= DriverManager.getConnection(url, "group20", "group20!");
			//String username = (session.getAttribute("idUser")).toString();
			String questionsQuery = "SELECT * FROM Questions WHERE idUser ="+idu;
			String check = "Awaiting an answer from a customer representative...";

			ps = conn.prepareStatement(questionsQuery);
			rs = ps.executeQuery();
			if(rs.next()){ %>
				<h1 align="center"> Question Results: </h1>
				<p style="font-size: 8pt;">
				<h5 align="center"> **  Note that all questions may not be answered until a customer representative gets a chance to answer them** </h5>
				</p>
				<table align="center">
				<tr>
	        <td align="center"><h3>Q#</h3></td>
					<td align="center"><h3>Item#</h3></td>
					<td align="center"><h3>Question</h3></td>
	        <td align="center"><h3>Answer</h3></td>
	      </tr>
					<% do { %>
						<tr>
						<td align="center"><%= rs.getString("idQuestion") %></td>
						<td align="center"><%= rs.getString("idItem")%></td>
						<td align="center"><%= rs.getString("questionText") %> </td>
						<td align="center"><%= rs.getString("answerText") %> </td>

						</tr>
			<% 		} while(rs.next()); %>
				</table>
			<% 	} else { %>
					<br><h2>No questions have been asked.</h2>
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


</div>
</body>
</html>
