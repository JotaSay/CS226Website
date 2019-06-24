<!-- Jeancarlo Bolanos jb1618-->

<%String user = request.getParameter("adminID");%>
session.setAttribute("username",adminID)
<!DOCTYPE html>
<html lang = "en-US">
<head> Welcome Admin
<title>Admin Page </title>
</head>
<body> 
Create Customer Rep accounts here
<form method = "POST" action="createRep.jsp">
    <label> RepUser</label>
    <input type = "text" name ="repUser">
    <label> RepPass</label>
    <input type ="text" name ="repPass">
    <input type = "submit" value = "Create"/>
</form>
<p> Need to find sales reports?<a href="salesR.jsp" class="pretty">Get sales here</a></p>
<p> Logout<a href="logout.jsp" class = "meep">Here</a></p>
</html>
