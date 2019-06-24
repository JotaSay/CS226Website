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
    String searchingBy = request.getParameter("searchBy");
    String searchingOrder = request.getParameter("searchOrder");
    %>
    <%
    //PreparedStatement mystmt = myconn.prepareStatement("select * from Item where " + searchingBy + " like ? order by " + searchingOrder + " asc");
    PreparedStatement mystmt = myconn.prepareStatement("select i.*, m.currentPrice from Item i LEFT OUTER JOIN (SELECT distinct idItem, max(bidAmt) as currentPrice from Bid b, Auction a WHERE b.idAuction = a.idAuction GROUP BY idItem) as m ON i.idItem = m.idItem WHERE " + searchingBy + " like ? order by " + searchingOrder + " asc");
    mystmt.setString(1, "%" + request.getParameter("searchFor") + "%");
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
    <td>Current bidding price</td>
    </tr>
    <%

    while(myRes.next())
    {

    %>
    <tr><td><%= myRes.getString("itemName") %></td>
    <td><%= myRes.getString("itemType") %></td>
    <td><%= myRes.getString("Brand") %></td>
    <td><%= myRes.getInt("idItem") %></td>
    <td><%= myRes.getString("itemCondition") %></td>
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
