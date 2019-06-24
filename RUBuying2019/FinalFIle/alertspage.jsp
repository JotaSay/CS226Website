<!-- Suraj Kakkad spk101 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ include file="navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="style.css?v=1.0" />
<title>Alerts Page</title>
</head>
<body>
	<%
  /* set the attributes*/

      String Email = (String) session.getAttribute("email");
      int idu = (Integer) session.getAttribute("idUser");
    //	out.println(idu);
    //	out.println(Email);
  %>
	<div>
		<h2 align="center">Alerts Page</h2>
	</div>
	<%@ include file="alertspage1.jsp"%>
	<%
	int userid = (Integer) session.getAttribute("idUser");
	ArrayList auction = new ArrayList();
	ResultSet radset1 = null;
	ResultSet radset2 = null;

	String Query = "SELECT idAuction, idUser FROM Bid WHERE idUser="+userid;
	String check_two = "SELECT * FROM Alerts WHERE Auction = ? AND User="+userid;

	PreparedStatement checked = null;
	PreparedStatement pee = null;

	pee = conn.prepareStatement(Query);
	radset1 = pee.executeQuery();

	i=0;

	PreparedStatement alert = conn.prepareStatement("SELECT max(bidAmt), idUser, placedOn FROM Bid WHERE idAuction= ?");
	ResultSet alert_rs = null;

	if(radset1.next()){

	     do{
	       auction.add(radset1.getString("idAuction"));
	       //dANDt.add(radset1.getAttribute("dANDt"));
	       alert.setString(1,(String) auction.get(i));
	       //System.out.println(alert);
	       alert_rs = alert.executeQuery();
	       if(alert_rs.next()){
	       float max_bidAmt = alert_rs.getFloat(1);
	       String placedOn=alert_rs.getString(3);
	       int newUser = alert_rs.getInt(2);
	       checked = conn.prepareStatement(check_two);
	       checked.setString(1,(String) auction.get(i));
	       radset2 = checked.executeQuery();
	       if(userid != newUser){
	          PreparedStatement alert_insert = conn.prepareStatement("INSERT INTO Alerts (message, Auction, User)" + "VALUES (?, ?, ?)");
	          alert_insert.setString(1,"AT: "+placedOn+" You have been outbid by USER#"+newUser+"  on Auction #");
	          alert_insert.setString(2,(String) auction.get(i));
	          alert_insert.setInt(3,userid);
	          if(!radset2.next()){
	          alert_insert.executeUpdate();
	          }
	        }
	       }
	      // out.println(auction.get(i)); //display result from the array list.
	       i++;
	     }while(radset1.next());
	}
	%>

		 <div align="left">
				<h1>Your alerts</h1>
        <%
				try{
				String alertsQuery = "SELECT * FROM Alerts WHERE User="+idu;
				p = conn.prepareStatement(alertsQuery);
				r = p.executeQuery();
				%>
				<%
				if(r.next()){ %>
					<table align="center">
						<tr>
							<td><h3>AlertID</h3></td>
							<td><h3 align="center">MESSAGE</h3></td>
							<td><h3>AUCTION ID</h3></td>
						</tr>
						<% do { %>
							<tr>
								<td> <%= r.getString("idAlerts") %> </td>
								<td> <%= r.getString("message") %> </td>
								<td align="center"> <%= r.getString("Auction") %> </td>

							</tr>
				<% 		} while(r.next()); %>
					</table>
				<% 	} else { %>
						<br><h4>No Alerts set</h4>
				<%	}  %>
			<%
			} catch (SQLException e){
				out.print("Error connecting to MYSQL server.");
			  e.printStackTrace();
			} finally {
				try { r.close(); } catch (Exception e) {}
				try { conn.close(); } catch (Exception e) {}
			}
		%>
		</div>
</body>
</html>
