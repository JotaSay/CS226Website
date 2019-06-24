<!-- Alexander Rozenblit amr468 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html lang = "en-US">
<head> List of All Auctions User has been a part of: </head>
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
    String searchUserName = request.getParameter("searchUserName");
        %>
    <%
    PreparedStatement mystmt = myconn.prepareStatement("select distinct b.idAuction, i.itemName from Auction as a, user as u, Item as i, Bid as b where u.username =  ? AND b.idUser = u.idUser AND a.idItem = i.idItem AND b.idAuction = a.idAuction");
    mystmt.setString(1,searchUserName);
    ResultSet myRes = mystmt.executeQuery();



    %>


    <title>All Auctions This User has Been a Part of</title>

    <body>
      <table border="2">
    <tr>
    <td>Auction ID</td>
    <td>Item Name</td>

    </tr>
    <%

    while(myRes.next())
    {

    %>
    <tr><td><%= myRes.getInt("b.idAuction") %></td>
    <td><%= myRes.getString("i.itemName") %></td>

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
