<% session.getAttribute("idRep");%>
<!DOCTYPE html> 
<html>
    <head>
        <title>Rep Page</title>
    </head>
<body> 
    Choose how you would like to handle the requests below
    <form value = "form" method = "Get" action = "change.jsp">
    <select value = "choice" name ='uord'>
    <option value="1"> Update</option>
    <option value="2"> Delete</option>
    </select>
    <select name ='uinfo'>
        <option value ="Auction"> Auction</option>
        <option value ="Item"> Item </option>
        <option value ="User"> User </option>
    </select>
    <input type = "submit" value = "Edit"/>
    </form>
<p> Need to Answer Questions? <a href ="repQ.jsp" class ="meep"> Here</a></p>
<p> Logout<a href="logout.jsp" class = "meep">Here</a></p>
</body>
</html>
