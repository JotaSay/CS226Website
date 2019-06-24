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
    String userid = request.getParameter("repUser");
    String pass = request.getParameter("repPass");
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
    <head> New rep being created...</head>
    <%
    /*establish the connection*/
    try{
         System.out.println("we are trying");
         Connection con = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
         System.out.println("connected");
         PreparedStatement stmt = con.prepareStatement("SELECT * FROM Rep WHERE username = ?");
         stmt.setString(1,userid);
         System.out.println(stmt);
         ResultSet checkUserResult = stmt.executeQuery();
         System.out.println("here at the bottom");
         /* here were seeing if the email is already in use*/

         if(checkUserResult.next()){
			System.out.println("email already in use!");
            checkUserResult.close();
            %>
             <script>
             alert("Username already in use");
             window.location.href="adminL.jsp"
             </script>
             <%
             return;

         }
         System.out.println("User is not in use");
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
        System.out.println("Working right now");
        String sql = "Insert into Account (Type) values (?)";
        PreparedStatement mainps = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
        mainps.setString(1,"Rep");
        mainps.executeUpdate();
        ResultSet yuh = mainps.getGeneratedKeys();

        if(!yuh.next()){
            System.out.println("failed to create user");
            con.close();
            return;
        }
        int pk = yuh.getInt(1);

        PreparedStatement ps = con.prepareStatement("INSERT INTO Rep (idRep,reputation,username,password)"
				+ " VALUES (?, ?, ?, ?)");
		ps.setInt(2, 0);
        ps.setInt(1,pk);
        ps.setString(4,pass);
        ps.setString(3,userid);
        System.out.println(ps);
        ps.executeUpdate();
        ps.close();
        System.out.println("Sent everything out");
        con.close();
        %>
        <script> 
		    alert("Account created");
	    	window.location.href = "adminPage.jsp";
		</script>
        <%
        return;
      


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