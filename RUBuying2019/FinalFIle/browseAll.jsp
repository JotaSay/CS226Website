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
    PreparedStatement mystmt = myconn.prepareStatement("select i.idItem, i.Brand, i.itemCondition, i.itemType, i.itemName, m.currentPrice from Item i LEFT OUTER JOIN (SELECT distinct idItem, max(bidAmt) as currentPrice from Bid b, Auction a WHERE b.idAuction = a.idAuction GROUP BY idItem) as m ON i.idItem = m.idItem");
    ResultSet myRes = mystmt.executeQuery();
    %>


    <title>Search Bar</title>

    <body>
      <table border="2">
    <tr>
    <td>Name</td>
    <td>Type</td>
    <td>Brand</td>
    <td>Item ID</td>
    <td>Condition</td>
    <td>Current price</td>
    </tr>
    <%

    while(myRes.next())
    {

    %>
    <tr><td><%= myRes.getString("i.itemName") %></td>
    <td><%= myRes.getString("i.itemType") %></td>
    <td><%= myRes.getString("i.Brand") %></td>
    <td><%= myRes.getInt("i.idItem") %></td>
    <td><%= myRes.getString("i.itemCondition") %></td>
    <td><%= myRes.getFloat("currentPrice") %></td>


    </tr>

        <%

    }
    %>
    </table>
    </body>
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
