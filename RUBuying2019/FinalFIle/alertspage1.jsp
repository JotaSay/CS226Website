<!-- Suraj Kakkad spk101 -->
<%
/* set the attributes*/
    String mail = (String) session.getAttribute("mail");
    int uid = (Integer) session.getAttribute("idUser");
  //	out.println(uid);
  //	out.println(mail);

        String url = null;
        Connection conn = null;
        PreparedStatement p = null;
        PreparedStatement ps_two = null;
        ResultSet r = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        conn= DriverManager.getConnection(url, "group20", "group20!");

        ArrayList al = new ArrayList();
        String auctionQuery = "SELECT a.idAuction, a.idItem, w.itemID, w.UserID From Auction as a, wishList as w WHERE a.idItem=w.itemID AND a.endsOn > now() AND w.UserID="+uid;
        ps = conn.prepareStatement(auctionQuery);
        rs = ps.executeQuery();
        int i=0;
        if(rs.next()){
             do{
               al.add(rs.getString("a.idAuction"));
               //out.println(al.get(i));
               i++;
             }while(rs.next());
        }
        rs.close();
        PreparedStatement sel=null;
          try {
                if(!al.isEmpty()){
                String in = "INSERT INTO Alerts (message, Auction, User)" + "VALUES (?, ?,"+ uid+ ")";
                ps_two = conn.prepareStatement(in);
                String idAuction = "";
                int j=0;
                String check = "SELECT * FROM Alerts WHERE Auction= ? and User="+uid;
                sel = conn.prepareStatement(check);
                //out.println(uid);

                do{
                idAuction= (String) al.get(j);
                //out.println(idAuction);
                ps_two.setString(1,"An item from your wishlist is currently being auctioned, head over to AUCTION #");
                ps_two.setString(2,idAuction);
                sel.setString(1,idAuction);
                //sel.setString(2,"An item from your wishlist is currently being auctioned, head over to AUCTION #");
                rs = sel.executeQuery();
                //out.println("Inserting into questions table...");
                      if(!rs.next()){
                      ps_two.executeUpdate();
                      }
                j++;
                }while(j<=al.size()-1);

              }
            }catch(Exception e) {
                  out.print("THERE SEEMS TO BE AN ERROR...");
                  e.printStackTrace();
            }finally {
                  try { ps_two.close(); } catch (Exception e) {}
            }
%>
