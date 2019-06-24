<!-- Jeancarlo Bolanos JB1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
/*further things that could be added
    checking to see if the email is a valid email
    im not sure what else lol
*/
/*getting parameters*/
    String userid = request.getParameter("userid");
    String pass = request.getParameter("password1");
    String pass2 = request.getParameter("password2");
    String email = request.getParameter("email");
    /*find the driver*/
    try {
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch(ClassNotFoundException ex) {
        System.out.println("Error: unable to load driver class!");
        return;
    }
    String url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
%>
<!DOCTYPE html>
<html lang="en-US">
    <head> New user being created...</head>
    <%
    /*establish the connection*/
    try{
         System.out.println("we are trying");
         Connection con = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
         System.out.println("connected");
         PreparedStatement stmt = con.prepareStatement("SELECT * FROM user WHERE Email= ?");
         stmt.setString(1,email);
         System.out.println(stmt);
         ResultSet checkEmailResult = stmt.executeQuery();
         System.out.println("here at the bottom");
         /* here were seeing if the email is already in use*/

         if(checkEmailResult.next()){
			System.out.println("email already in use!");
            checkEmailResult.close();
            %>
             <script>
             alert("Email already in use");
             window.location.href="login.jsp"
             </script>
             <%
             return;

         }
         System.out.println("email is not in use");
         /*here we are going to check the password constraints since i think i set them to like 20 characters max, im not sure if i should put a lower limit since the passwords on this website
         dont really matter. */
         if(pass.length()>20){
             System.out.println("Sorry your password is too long, keep it below 20 characters");
             %>
            <script>
            window.location.href="login.jsp";
            </script>
            <%
            return;

         }
         /*making sure that the passowrds match*/ 
         if(!(pass2.equals(pass))){
             System.out.println("Passwords dont match");
             con.close();
             %>
             <script>
             alert("passwords do not match");
             window.location.href="login.jsp";
             </script>
            <%
             return;

         }
        System.out.println("Working right now");
        String sql = "Insert into Account (Type) values (?)";
        PreparedStatement mainps = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
        mainps.setString(1,"User");
        mainps.executeUpdate();
        ResultSet yuh = mainps.getGeneratedKeys();

        if(!yuh.next()){
            System.out.println("failed to create user");
            con.close();
            return;
        }
        int pk = yuh.getInt(1);

        PreparedStatement ps = con.prepareStatement("INSERT INTO user (idUser,Email, First_name,Last_name,Password,username)"
				+ " VALUES (?, ?, ?, ?, ?, ?)");
		ps.setString(2, email);
        ps.setString(5,pass);
		ps.setString(6, userid);
        ps.setInt(1,pk);
        ps.setString(3,"N/A");
        ps.setString(4,"N/A");
        System.out.println(ps);
        ps.executeUpdate();
        ps.close();
        System.out.println("Sent everything out");
        con.close();
        session.setAttribute("email",email);
        session.setAttribute("idUser",pk);
        %>
        <script> 
		    alert("Account created");
	    	window.location.href = "homepage.jsp";
		</script>
        <%
      


    }catch(Exception ex){
        System.out.println("Something went wrong, redirecting you to the login page");
        %>
        <script>
            window.location.href="login.jsp";
        </script>
        <%
    }
     %>
</html>