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

    String auctionID = request.getParameter("auctionIDHist");
    int auctionIDInt = Integer.parseInt(auctionID);
    %>
    <%
    PreparedStatement mystmt = myconn.prepareStatement("select u.username, b.bidAmt from Bid as b, user as u where u.idUser = b.idUser AND b.idAuction = ? AND b.isInitialBid = 0 order by b.bidAmt asc");
    mystmt.setInt(1,auctionIDInt);
    ResultSet myRes = mystmt.executeQuery();
    %>


    <title>Search Bar</title>

    <body>
      <table border="2">
    <tr>
    <td>Username</td>
    <td>Bid Amount</td>

    </tr>
    <%

    while(myRes.next())
    {

    %>
    <tr><td><%= myRes.getString("u.username") %></td>
    <td><%= myRes.getString("b.bidAmt") %></td>



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
