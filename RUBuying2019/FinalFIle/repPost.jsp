<!-- Jeancarlo Bolanos JB1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
/*getting parameters*/
    String repid = (String)session.getAttribute("idRep");
    String id = request.getParameter("id");
    String rep = request.getParameter("response");
    System.out.println(id);
    System.out.println(rep);
    /*find the driver*/
    try {
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch(ClassNotFoundException ex) {
        System.out.println("Error: unable to load driver class!");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>
answering...
</title>
</head>

<%
    try{
        /* Based on what their selections were different results are yielded*/
         System.out.println("we are trying");
         Connection con = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
         System.out.println("connected");
         String sql= "Update Questions Set answerText = ?, repID = "+repid+" where idQuestion = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1,rep);
        ps.setString(2,id);
        ps.executeUpdate();
        con.close();
    %> <script>
    alert("Action completed");
    window.location.href="repPage.jsp";
    </script>
    <%

}catch(Exception ex){
    System.out.println("something went wrong");
    %> <script>
    alert("something went wrong, redirecting to login page");
    window.location.href="login.jsp";
    </script>
    <%

}   
%> 
</html>

