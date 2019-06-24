<!-- Jeancarlo Bolanos JB1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<title>
logging out
</title>
</head>
<%
session.invalidate();
%> <script> 
    alert("Logout Successful");
    window.location.href="register.jsp";
  </script>
</html>
