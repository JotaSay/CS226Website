<!--Jeancarlo Bolanos JB1618 -->
<%session.setAttribute("username","");
/* create a login page that is similar to the other login pages*/
%>
<!DOCTYPE html>
<html lang = "en-US">
    <title> Admin Login in</Title>
    <link href="style.css" rel ="stylesheet" type="text/css"/>
    <body>
    <form method = "POST" action="adminL.jsp" >
        <Label> Username</label>
        <input type ="text" name = "adminID" required="required"> 
        <label> Password </label>
        <input type ="text" name ="adminPass" required = "required">
        <input type = "submit" value = "Login"/>
    </form>
    

<%
/*take to another page that generates sales reports for the user*/
%>