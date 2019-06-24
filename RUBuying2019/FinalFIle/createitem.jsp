<!-- Jeancarlo Bolanos jb1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<title> RUBuying</title>
<%
/*Get params*/
String name = request.getParameter("name");
String brand = request.getParameter("brand");
String cond = request.getParameter("condition");
String type = request.getParameter("type");

String email = (String) session.getAttribute("email");

/*establish the connection*/
try {
        Class.forName("com.mysql.jdbc.Driver");
    }
catch(ClassNotFoundException ex) {
    System.out.println("Error: unable to load driver class!");
    return;
}
%>
<!DOCTYPE html>
<html lang="en-US">
    <head>Creating your item...</head>
    <%
    try{
         System.out.println("we are trying!");
         Connection con = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
         System.out.println("connected");
		 
		 PreparedStatement getUserID = con.prepareStatement("SELECT iduser FROM user WHERE Email = ?");
		 getUserID.setString(1, email);
		
		 ResultSet user_rs = getUserID.executeQuery();
		 user_rs.next();
		 
		 int userid = user_rs.getInt(1);
		 user_rs.close();
		 getUserID.close();
	
		PreparedStatement ps = con.prepareStatement("INSERT INTO Item (itemName, Brand, itemCondition, itemType, idUser)"
							+ " VALUES (?, ?, ?, ?, ?)");
							
		ps.setString(1, name);
		ps.setString(2, brand);
		ps.setString(3, cond);
		ps.setString(4, type);
		ps.setInt(5, userid);
		
        System.out.println(ps);
        ps.executeUpdate();

       	ps.close();
       	
       	ps = con.prepareStatement("SELECT LAST_INSERT_ID()");
       	ResultSet itemID_rs = ps.executeQuery();
       	itemID_rs.next();
       	
       	int itemid = itemID_rs.getInt(1);
       	itemID_rs.close();
       	ps.close();
       	
       	if (type.equals("Headphones"))
       	{
       		String hpColor = request.getParameter("hpColor");
       		String hpQuality = request.getParameter("hpQuality");
       		String hpFit = request.getParameter("hpFit");
       		
       		ps = con.prepareStatement("INSERT INTO Headphones(idHeadphones, Color, SoundQuality, Fit)"
       				+ " VALUES(?, ?, ?, ?)");
       		ps.setInt(1, itemid);
       		ps.setString(2, hpColor);
       		ps.setString(3, hpQuality);
       		ps.setString(4, hpFit);
       		
       		System.out.println(ps);
       		ps.executeUpdate();
       	} 
       	else if (type.equals("Monitor"))
       	{
       		String monSize = request.getParameter("monSize");
       		String monHz = request.getParameter("monHz");
       		String monType = request.getParameter("monType");
       		
       		ps = con.prepareStatement("INSERT INTO Monitors(idMonitors, Size, Hertz, ScreenType)"
       				+ " VALUES(?, ?, ?, ?)");
       		ps.setInt(1, itemid);
       		ps.setString(2, monSize);
       		ps.setString(3, monHz);
       		ps.setString(4, monType);
       		
       		System.out.println(ps);
       		ps.executeUpdate();
       	}
       	else
       	{
       		String gameTitle = request.getParameter("gameTitle");
       		String gameConsole = request.getParameter("gameConsole");
       		String gameRating = request.getParameter("gameRating");
       		
       		ps = con.prepareStatement("INSERT INTO VideoGames(idVideoGames, Title, Console, Rating)"
       				+ " VALUES(?, ?, ?, ?)");
       		ps.setInt(1, itemid);
       		ps.setString(2, gameTitle);
       		ps.setString(3, gameConsole);
       		ps.setString(4, gameRating);
       		
       		System.out.println(ps);
       		ps.executeUpdate();
       	}
       	
       	ps.close();
        con.close(); 
        %>
        <script> 
		    alert("Item created!");
	    	window.location.href = "homepage.jsp";
		</script>
        <%
    }catch(Exception ex){
        System.out.println(ex);
        
        %>
        <script>
            window.location.href="itemform.jsp";
        </script>
        <%
    }
     %>
</html>