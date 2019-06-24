<!-- Jeancarlo Bolanos jb1618-->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="navbar.jsp"%>
<%
/* set the attributes*/
    String Email = request.getParameter("email");
    session.getAttribute("idUser");
    session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title> RUBuying</title>
    <link href="home.css" rel="stylesheet" type="text/css"/>
</head>
<p> Want to logout? <a href="login.jsp" class ="meep"> Logout here</a></p>
</html>
