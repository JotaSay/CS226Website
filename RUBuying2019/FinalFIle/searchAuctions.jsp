<!-- Alexander Rozenblit amr468 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html lang = "en-US">
<head> Search </head>
<title> RUBuying</title>
<%
/*Get the parameter*/
String email = request.getParameter("email");
String password = request.getParameter("password1");
/*establish the connection*/
  try {
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch(ClassNotFoundException ex) {
        System.out.println("Error: unable to load driver class!");
        return;
    }
  try{
    System.out.println("Establishing connection");
    Connection myconn = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
    System.out.println("established");

    %>
    <%
    PreparedStatement mystmt = myconn.prepareStatement("select a.idAuction, i.itemName, u.username from Auction as a, Item as i, user as u where a.idItem = i.idItem AND a.idSeller = u.iduser");
    ResultSet myRes = mystmt.executeQuery();
    %>


    <title>Search Bar</title>

    <body>
      <table border="2">
    <tr>
    <td>Auction ID</td>
    <td>Item</td>
    <td>Seller</td>
    </tr>
    <%

    while(myRes.next())
    {

    %>
    <tr><td><%= myRes.getString("a.idAuction") %></td>
    <td><%= myRes.getString("i.itemName") %></td>
    <td><%= myRes.getString("u.username") %></td>
    </tr>

        <%

    }
    %>
    </table>
    </body>

    <br> </br>
    <form method ="POST" action="showBiddingHistory.jsp">
            <label>Type in ID of Auction to see Bidding History:</label>
            <br> </br>
            <input type="text" name = "auctionIDHist" required="required">
            <input type = "submit" value = "Search"/>
    </form>
    <%
  }

  catch(Exception ex){
      System.out.println("Something went wrong, redirecting you to the login page");
      %>
      <script>
          window.location.href="login.jsp";
      </script>
      <%
  }
   %>
