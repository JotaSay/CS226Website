<!-- Jeancarlo Bolanos jb1618 -->
<%session.setAttribute("username","");
/* create a login page that is similar to the other login pages*/
%>
<!DOCTYPE html>
<html lang = "en-US">
    <title> Rep Login in</Title>
    <link href="style.css" rel ="stylesheet" type="text/css"/>
    <body>
    <form method ="POST" action =repL.jsp>
        <Label> Username</label>
        <input type ="text" name = "repID" required="required"> 
        <label> Password </label>
        <input type ="text" name ="repPass" required = "required">
        <input type = "submit" value = "Create"/>
    </form>
    

<%
/*take to another page that generates sales reports for the user*/
%>