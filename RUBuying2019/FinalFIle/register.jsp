<!-- Jeancarlo Bolanos jb1618-->
<% session.setAttribute("username", "");
    session.setAttribute("email", "");
    %>
<!DOCTYPE html>
<html lang = "en-US">
    <head>
    <title>Login Page</title>
    <link href="home.css" rel ="stylesheet" type="text/css"/>
    </head>
    <body>
        <header>Login here</header>
        <form method ="POST" action="verification.jsp">
            <div class = "input-group">
                <label>Email</label>
                <input type ="text" name = "email">
                <label>Password</label>
                <input type = "password" name = "password1">
                <input type = "submit" value = "Login"/>
            </div>
            <p> Not a user yet? <a href="login.jsp" class = "meep">Register Here</a></p>
        </form>
    </body>
</html>