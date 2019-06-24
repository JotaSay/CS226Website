<!-- Jeancarlo Bolanos jb1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
/* In this page im going to attempt to cycle through the answers and create a table of questions
then under neath the could be code to reply to the question (all of them are unanswered currently)*/
/* can also pull up the answered question for shits and giggles */
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
questions page
</title>
<head>
<h1>
Here are all the unanswered questions, reply below to any of them. </h1>
<body>
  <table border="2">
    <tr>
    <td>IdUser</td>
    <td>Question</td>
    <td>idQuestion</td>
    </tr>
<%
   try{
        /* Based on what their selections were different results are yielded*/
         System.out.println("we are trying");
         Connection con = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
         System.out.println("connected");
         Statement mystmt = con.createStatement();
         String sql = "Select idUser,questionText,idQuestion From Questions where repID IS NULL";
         ResultSet myres = mystmt.executeQuery(sql);
                while(myres.next()){
                %>
                <tr bgcolor="#DEB887">
                <td><%=myres.getInt("idUser") %></td>
                <td><%=myres.getString("questionText") %></td>
                <td><%=myres.getInt("idQuestion") %></td>
                </tr>
                <% 
                }
        
        %>
        </table>
        </body>
        <form method = "POST" action = repPost.jsp>
         <label> enter the id of the question you want to answer </label>
         <input type = "text" name = "id" required="required">
         <label> post your answer</label>
         <input type="text" name = "response" required="required">
         <input type = "submit" value = "insert">
         <%
   }
catch(Exception ex){
        System.out.println("Something went wrong, redirecting you to the admin page");
        %>
        <script>
            window.location.href="adminPage.jsp";
        </script>
        <%
    }
     %>
<p> Logout<a href="logout.jsp" class = "meep">Here</a></p>
</html>