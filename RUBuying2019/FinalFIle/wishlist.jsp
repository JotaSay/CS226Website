<!-- Suraj Kakkad spk101 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="style.css?v=1.0" />
<title> WishList </title>
</head>
<body>
  <%
  /* set the attributes*/
      String Email = (String) session.getAttribute("email");
      int idu = (Integer) session.getAttribute("idUser");
    //	out.println(idu);
    //	out.println(Email);
  %>
  <%	if (request.getParameter("submit") != null && (request.getParameter("submit")).toString().equals("success")) { %>
      <h1>Your wish item has been accepted!!</h1>
  <%	} %>
  <h2 align="center">Wish List</h2>
  <%
	String url = null;
	Connection conn = null;
	PreparedStatement p = null;
	ResultSet r = null;
	url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	conn= DriverManager.getConnection(url, "group20", "group20!");
	%>
<h3 align="center">Add Items to your Wish list to get Alerts</h3>
<h3 align="center">Make a wish</h3>
    <%
    String ItemsQuery = "SELECT * FROM Item WHERE idUser <>"+idu;
    p = conn.prepareStatement(ItemsQuery);
    r = p.executeQuery();
    if(r.next()){ %>
      <h1 align="center"> SELECT AN ITEM TO BE ADDED TO YOUR WISH LIST: </h1>
      <table align="center">
      <form action="wishlistHandler.jsp">
        <tr>
          	<input type="hidden" name="idUser" value="<%= idu %>" />
        </tr>
        <tr>
          <td></td>
          <td><h3>Item Id</h3></td>
          <td><h3>Name</h3></td>
          <td><h3>Brand</h3></td>
          <td><h3>Condition</h3></td>
          <td><h3>Category</h3></td>

        </tr>

        <% do { %>
          <tr>
            <td><input type="radio" name="idItem" value="<%= r.getString("idItem")%>" /></td>
            <td><%= r.getString("idItem")%></td>
            <td><%= r.getString("itemName") %> </td>
            <td><%= r.getString("Brand") %> </td>
            <td><%= r.getString("itemCondition") %> </td>
            <td><%= r.getString("itemType") %> </td>

          </tr>
       <% } while(r.next()); %>

       <tr>
       </tr>
       <tr>
       </tr>
          <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><input type="submit" value="Submit"/></td>
          </tr>
      </table>
    </form>
    <% } else { %>
        <br><h2>No items avaliable.</h2>
    <%}%>
<%
r.close();
conn.close();
%>
</body>
</html>
