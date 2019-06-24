<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<title> RUBuying</title>
<%
/*Get params*/
int auctionid = Integer.parseInt(request.getParameter("auctionid"));
float bidAmt = Float.parseFloat(request.getParameter("bidAmt"));

// need to do some checks here in order to set autobid/maxprice correctly
String tmp = request.getParameter("maxBid");
float maxBid;
int autobid;

if (tmp.isEmpty())
{
	maxBid = -1;
	autobid = 0;
}
else
{
	maxBid = Float.parseFloat(request.getParameter("maxBid"));
	autobid = 1;
}

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
    <head>Placing your bid...</head>
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
	
         PreparedStatement stmt = con.prepareStatement("SELECT * FROM Auction WHERE idAuction = ? AND endsOn > now()");
         stmt.setInt(1, auctionid);
         System.out.println(stmt);
		 
         ResultSet checkAuction = stmt.executeQuery();
         
         /*verify auction exists*/

         if(!checkAuction.isBeforeFirst())
		 {
			System.out.println("Auction not found or has closed!");
			stmt.close();
            checkAuction.close();
            
            %>
             <script>
             alert("Auction not found!");
             window.location.href="bidform.jsp"
             </script>
             <%
             
             return;
         }
             
        checkAuction.next();
        
		float incr = checkAuction.getFloat("incrementAmt");
		stmt.close();
		checkAuction.close();
        
        stmt = con.prepareStatement("SELECT MAX(bidAmt) FROM Bid where idAuction = ?");
        stmt.setInt(1, auctionid);
        ResultSet checkBid = stmt.executeQuery();
       	
        checkBid.next();
        
		float currentPrice = checkBid.getFloat(1);
		
		stmt.close();
		checkBid.close();
		
		if (bidAmt < currentPrice + incr)
		{
			String msg = "Bid ($" + bidAmt + ") not high enough! Need $" + (currentPrice + incr);
			System.out.println(msg);

			%>
			<script src="JavaScript/jquery-1.6.1.min.js" type="text/javascript">
			alert(msg);
			window.location.href="bidform.jsp";
			</script>
			<%
			
			return;
		}
         
		PreparedStatement ps = con.prepareStatement("INSERT INTO Bid (idAuction, idUser, bidAmt, autoBid, maxBid)"
							+ " VALUES (?, ?, ?, ?, ?)");
							
		ps.setInt(1, auctionid);
		ps.setInt(2, userid);
		ps.setFloat(3, bidAmt);
		ps.setInt(4, autobid);
		ps.setFloat(5, maxBid);
		
        System.out.println(ps);
		
		System.out.println("Inserting into bid table...");
		
        ps.executeUpdate();
        ps.close();
		
        System.out.println("Done.");
       
		// need to update autobids now
		// logically there can only be an 'autobid battle' b/w a max of 2 bidders, so we need to put in a new bid for the lower amount each round
		// a 3rd autobidder can't actually get in because the 2 man battle will have to finish first, eliminating the one with the lower max bid 
		
		// the new current price of the auction is just whatever the last bidAmt was...
		currentPrice = bidAmt;

		// this will retrieve the row of the (lesser) autobidder that needs to be updated
		while (true)
		{
			ps = con.prepareStatement("SELECT a.* FROM Bid a INNER JOIN (SELECT idUser, MAX(bidAmt) as poop FROM Bid GROUP BY idUser) b ON a.idUser = b.idUser AND a.bidAmt = b.poop "
										+ " WHERE a.idAuction = ? AND a.autoBid = 1 AND a.maxBid >= ? AND b.poop < ?");
			ps.setInt(1, auctionid);
			ps.setFloat(2, currentPrice);
			ps.setFloat(3, currentPrice);
		
			ResultSet rs = ps.executeQuery();
					
			if (!rs.next()) // empty
			{
				ps.close();
				rs.close();
				break;
			}
		
			int insUserid = rs.getInt("idUser"); // userid of the dude that needs to be updated
			float insMaxBid = rs.getFloat("maxBid"); 
			
			ps.close();
			rs.close();
			
			float newBid = currentPrice + incr;
			if (insMaxBid < newBid) // cannot place this bid 
				break;
			
	    	PreparedStatement ins = con.prepareStatement("INSERT INTO Bid (idAuction, idUser, bidAmt, autoBid, maxBid)"
        						+ " VALUES (? , ?, ?, ?, ?)");
	    	ins.setInt(1, auctionid);
	    	ins.setInt(2, insUserid);
	    	ins.setFloat(3, newBid);
	    	ins.setInt(4, 1);
	    	ins.setFloat(5, insMaxBid);
	    	
	    	System.out.println(ins + "\t(AUTO-BID)");
	    	
	    	ins.executeUpdate();
	    	ins.close();
	    	
	    	currentPrice = newBid;
		}

        con.close();
		
        %>
        <script> 
		    alert("Bid placed!");
	    	window.location.href = "homepage.jsp";
		</script>
        <%
    }catch(Exception ex){
        System.out.println(ex);
        %>
        <script>
            window.location.href="bidform.jsp";
        </script>
        <%
    }
     %>
</html>