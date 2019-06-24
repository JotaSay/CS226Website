<!-- Suraj Kakkad spk101 -->
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
  <%
  /* set the attributes*/
      String Email = (String) session.getAttribute("email");
      int idu = (Integer) session.getAttribute("idUser");
    //	out.println(idu);
    //	out.println(Email);
  String url=null;
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	conn= DriverManager.getConnection(url, "group20", "group20!");
  try {

    String questionsQuery = "SELECT * FROM Questions";
    String check = "Awaiting an answer from a customer representative...";

    ps = conn.prepareStatement(questionsQuery);
    rs = ps.executeQuery();
    if(rs.next()){ %>

      <h2 align="center"> **  Frequently Asked Questions ** </h2>
      <br><br><br><br>
      <table align="center">
      <tr>
        <td align="center"><h3>#</h3></td>
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
</body>
</html>
