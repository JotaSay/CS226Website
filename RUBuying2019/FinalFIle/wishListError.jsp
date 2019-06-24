<!-- Suraj Kakkad spk101 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RU buying - Error</title>
</head>
<body>

    	<%@ include file="navbar.jsp" %>
    	<div class="content">
    		<h2>Please select an ITEM </h2>
    		<p><%=session.getAttribute("idUser")%>, <a href="wishList.jsp">click here to make a wish.</a></p>
    		<p> Otherwise, <a href="homepage.jsp">click here to return to the home page.</a></p>
    	</div>

</body>
</html>
