<!-- Jeancarlo Bolanos jb1618-->
<%
session.setAttribute("username", "");
session.setAttribute("email", "");
%>
<!DOCTYPE html>
<html lang = "en-US">
    <title>Register Page</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <body>
        <header>Welcome to RUBuying</header>
        <h2>Register an account Below</h2>
        <div class = "sign_in">
        <form method ="POST" action="newuser.jsp">
                <label>Username</label>
                <input type ="text" name = "userid" required ="required">
                <label>Email</label>
                <input type="text" name = "email" required="required">
                <label>Password</label>
                <input type = "password" name = "password1" required="required">
                <label>Confirm Password</label>
                <input type = "password" name="password2" required="required">
                <input type = "submit" value = "Create"/>
        </form>
        </div>
        <p> Already a user? <a href="register.jsp" class = "meep">&nbsp;Sign in here</a></p>
        <p> Admin Login <a href="Admin.jsp" class = "meep">Here</a></p>
        <p> Customer Rep Lgin <a href ="Rep.jsp" class ="meep"> Here</a></p>
    </body>
</html>