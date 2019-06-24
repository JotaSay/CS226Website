<!-- Jeancarlo Bolanos jb1618-->
<% String user = request.getParameter("adminID");%>
<!DOCTYPE hmtl>
<html lang = "en-US">
<head>
<title>Sales Report</title>
</head>
    <body>
        Choose what report you would like to generate
        <form method ="GET" value = "total"action="query.jsp">
        <select name = "first"> 
            <option value ="1"> Total earnings</option>
            <option value = "2">Best selling</option>
            <Option value ="3">Biggest buys</option>
        </select>
        Enter what to sort your items by
        <select name = "second">
             <option value ="4">Item</option>
            <option value ="5">Item-Type</option>
            <option value ="6">Users</option>
        </select>
        <input type = "submit" value = "Create"/>       
</form>
</html>

