<!--Suraj Kakkad spk101 -- >
<%

int userid = (Integer) session.getAttribute("idUser");
ArrayList auction = new ArrayList();
//ArrayList dANDt = new ArrayList(); //date and time.
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

radset1.close();
%>
