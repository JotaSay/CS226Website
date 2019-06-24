<!-- Suraj Kakkad spk101 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> wishlistHandler </title>
</head>
<body>
  <%
  String url = null;
	Connection conn = null;
	PreparedStatement ps = null;
  PreparedStatement ps2 = null;
	ResultSet rs = null;
  try {
	url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	conn= DriverManager.getConnection(url, "group20", "group20!");
  String username = request.getParameter("idUser").toString();
  out.println(username);
  String id = request.getParameter("idItem");
  out.println(id);
  //int idd =  Integer.parseInt(request.getParameter("itemid"));
  			  if(id!= null && !id.isEmpty()){
          //String select = "SELECT idAuction " + "FROM Auction" + "WHERE idItem like %" + idd +"%";
  				String insert = "INSERT INTO wishList (UserID, itemID)" + "VALUES (?, ?)";
          //ps2 = conn.prepareStatement(select);
          //ps2.executeQuery();
          //System.out.println(ps2);
  				ps = conn.prepareStatement(insert);
          ps.setString(1,username);
          ps.setString(2,id);
  				//System.out.println(ps);
  			  //out.println("Inserting into questions table...");

           int result = 0;
  		     result= ps.executeUpdate();
  		       if (result < 1) {
  		        	out.println("Error: wish failed.");
  		        } else {
  		        	response.sendRedirect("wishlist.jsp?submit=success");
  		        	return;
  		        }
  			}else {
  				response.sendRedirect("wishlistError.jsp");
  				return;
  			}
      } catch(Exception e) {
            out.print("Error connecting to MYSQL server." + e);
            e.printStackTrace();
      } finally {
            try { ps.close(); } catch (Exception e) {}
            try { conn.close(); } catch (Exception e) {}
      }
%>

</body>
</html>
