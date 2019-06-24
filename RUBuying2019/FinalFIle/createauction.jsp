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
int itemid = Integer.parseInt(request.getParameter("itemid"));
float initPrice = Float.parseFloat(request.getParameter("initPrice"));
float increment = Float.parseFloat(request.getParameter("increment"));
float minSalePrice = Float.parseFloat(request.getParameter("minSalePrice"));
String endsOn = request.getParameter("endsOn");

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
    <head>Creating your auction...</head>
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
		 getUserID.close();
		 user_rs.close();
	
         PreparedStatement stmt = con.prepareStatement("SELECT * FROM Item WHERE idItem = ? AND idUser = ?");
         stmt.setInt(1, itemid);
         stmt.setInt(2, userid);

         ResultSet checkItem = stmt.executeQuery();
		 
         /*verify item exists*/

         if(!checkItem.next())
		 {
			System.out.println("item not found!");
            checkItem.close();
            %>
             <script>
             alert("Item not found! (Or maybe you don't own it...)");
             window.location.href="auctionform.jsp"
             </script>
             <%
             return;
         }
         
		PreparedStatement ps = con.prepareStatement("INSERT INTO Auction (idItem, idSeller, reservePrice, incrementAmt, endsOn)"
							+ " VALUES (?, ?, ?, ?, ?)");
							
		ps.setInt(1, itemid);
		ps.setInt(2, userid);
		ps.setFloat(3, minSalePrice);
		ps.setFloat(4, increment);
		ps.setString(5, endsOn);
		
        System.out.println(ps);
		
		System.out.println("Inserting into auction table...");
		
		try
		{
        	ps.executeUpdate();
		}
		catch (SQLException e)
		{
			System.out.println(e);
            %>
            <script>
            alert("An auction already exists for this item or you provided a bad input!");
            window.location.href="auctionform.jsp"
            </script>
            <%
            return;
		}
		finally
		{
       		ps.close();
		}
		
        PreparedStatement checkAuction = con.prepareStatement("SELECT idAuction FROM Auction WHERE idItem = ? AND idSeller = ? AND reservePrice = ? AND incrementAmt = ?");
   		checkAuction.setInt(1, itemid);
   		checkAuction.setInt(2, userid);
   		checkAuction.setFloat(3, minSalePrice);
   		checkAuction.setFloat(4, increment);
       	
   		ResultSet auctionidRS = checkAuction.executeQuery();
   		auctionidRS.next();
   	
   		int auctionid = auctionidRS.getInt("idAuction");
   		ps.close();
   		auctionidRS.close();
   		
        ps = con.prepareStatement("INSERT INTO Bid (idAuction, idUser, bidAmt, autoBid, isInitialBid)"
				+ " VALUES (?, ?, ?, ?, ?)");
				
		ps.setInt(1, auctionid);
		ps.setInt(2, userid);
		ps.setFloat(3, initPrice); // bidAmt
		ps.setInt(4, 0); // autoBid
		ps.setInt(5, 1); // isInitialBid

		System.out.println(ps);
		
		System.out.println("Inserting into bid table...");
		
		ps.executeUpdate();
		ps.close();
		        
        System.out.println("Done.");
        con.close();

        %>
        <script> 
		    alert("Auction created!");
	    	window.location.href = "homepage.jsp";
		</script>
        <%
    }catch(Exception ex){
        System.out.println(ex);
        
        %>
        <script>
            window.location.href="auctionform.jsp";
        </script>
        <%
    }
     %>
</html>