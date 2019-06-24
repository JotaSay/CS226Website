<!-- Jeancarlo Bolanos JB1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
/*getting parameters*/
    String first = request.getParameter("first");
    String second = request.getParameter("second");
    System.out.println(first);
    System.out.println(second);
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
<html>
<head> Here are your values </head>

<%
    try{
        /* Based on what their selections were different results are yielded*/
         System.out.println("we are trying");
         Connection con = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
         System.out.println("connected");
         /*For each of these I have to loop through the entire result set and produce the results in a table*/
         System.out.println(first.equals("1"));
         System.out.println(first.equals("2"));
         System.out.println(first.equals("3"));
        System.out.println(second.equals("6"));
         /*if it equals total earnings for */
         if(first.equals("1")){
             /*Item*/
             if(second.equals("4")){
                 Statement mystmt = con.createStatement();
                 String sql = "Select sum(SoldFor) s,count(*) totalItems from Item";
                 ResultSet myres =  mystmt.executeQuery(sql);
                 System.out.println("bunny");
                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>Sumofsold</td>
                <td>totalitems</td>
                </tr> <%
                 while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">
                <td><%=myres.getInt("s") %></td>
                <td><%=myres.getInt("totalItems") %></td>
                </tr>
                <% 
                }
                %> </table>
                </body><%

             }
             /*Item Type*/
             else if(second.equals("5")){
                 Statement mystmt = con.createStatement();
                 String sql = "Select sum(SoldFor) s,idItem, itemType from Item group by itemType order by SoldFor";
                 ResultSet myres =  mystmt.executeQuery(sql);
                 System.out.println("bunny");
                                  %> 
                 <body>
                <table border="2">
                <tr>
                <td>Sumofsold</td>
                <td>itemid</td>
                <td>Type</td>
                </tr> <%
                 while(myres.next()){
                %>
                <tr bgcolor="#DEB887">
                <td><%=myres.getInt("s") %></td>
                <td><%=myres.getInt("idItem") %></td>
                <td><%=myres.getString("itemType") %></td>
                </tr>
                <% 
                }
                %> </table>
                </body><%

             }
             /*Users*/
             else if(second.equals("6")){
                Statement mystmt = con.createStatement();
                String sql = "select s.idSeller a,sum(t2.bidAmt) s,count(s.idAuction) x from("
                                +" select * " 
                                +" from (select * from Bid order by idAuction, bidAmt desc,idUser) x"
                                +" group by idAuction)t2, Auction s"
                                +" where s.idAuction = t2.idAuction group by idSeller";
                ResultSet myres =  mystmt.executeQuery(sql);
                System.out.println("bunny");
                                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>Sellerid</td>
                <td>sumofBids</td>
                <td>countofSalesmade</td>
                </tr> <%
                 while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">
                <td><%=myres.getInt("a") %></td>
                <td><%=myres.getInt("s") %></td>
                <td><%=myres.getInt("x") %></td>
                </tr>
                <% 
                }
                                %> </table>
                </body><%

             }
         }
         /*best selling*/
         if(first.equals("2")){
             /*Item*/
             if(second.equals("4")){
                Statement mystmt = con.createStatement();
                String sql = "select count(*) c,itemName,itemType,Brand from Item group by itemType, itemName,Brand limit 10";
                ResultSet myres =  mystmt.executeQuery(sql);
                System.out.println("bunny");
                                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>count</td>
                <td>Name</td>
                <td>Type</td>
                <td>Brand</td>
                </tr> <%
                 while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">
                <td><%=myres.getInt("c") %></td>
                <td><%=myres.getString("itemName") %></td>
                <td><%=myres.getString("itemType") %></td>
                <td><%=myres.getString("Brand") %></td>
                </tr>
                <%System.out.println("conejo");
                }
                                %> </table>
                </body><%

             }
             /*Item-type*/
             if(second.equals("5")){
                Statement mystmt = con.createStatement();
                String sql = "select count(*) s, itemType, Brand from Item group by itemType, Brand limit 10";
                ResultSet myres =  mystmt.executeQuery(sql);
                System.out.println("bunny");
                                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>Count</td>
                <td>Type</td>
                <td>Brand</td>
                </tr> <%
                 while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">

                <td><%=myres.getInt("s") %></td>
                <td><%=myres.getString("itemType") %></td>
                <td><%=myres.getString("Brand") %></td>
                </tr>
                <% 
                }
                                %> </table>
                </body><%
             }
                 /*Users*/
             if(second.equals("6")){
                Statement mystmt = con.createStatement();
                String sql = "select count(*) s ,idSeller from Auction  where now()> endsOn group by idSeller limit 10";
                ResultSet myres =  mystmt.executeQuery(sql);
                System.out.println("last query");
                                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>Count</td>
                <td>idSeller</td>
                </tr> <%
                 while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">

                <td><%=myres.getInt("s") %></td>
                <td><%=myres.getInt("idSeller") %></td>
                </tr>
                <% 
                }
                                %> </table>
                </body><%

             }

         }
         /*Biggest buys*/
         System.out.println("gonna try 3");
         if(first.equals("3")){
             /*item*/
             if(second.equals("4")){
                Statement mystmt = con.createStatement();
                String sql = "select itemName, itemType, Brand,y.b s from ("
                               + " select t2.bidAmt b,s.idAuction,s.idItem from("
                                +"select *"
                                +" from (select * from Bid order by idAuction, bidAmt desc,idUser) x "
                                +" group by idAuction)t2, Auction s"
                                +" where s.idAuction = t2.idAuction and now()>s.endsOn group by idSeller) y, Item I where I.idItem = y.idItem";
                ResultSet myres =  mystmt.executeQuery(sql);
                System.out.println("bunny");
                                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>Name</td>
                <td>Type</td>
                <td>Brand</td>
                <td>bidamt</td>
                </tr> <%
                 while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">
                <td><%=myres.getString("itemName") %></td>
                <td><%=myres.getString("itemType") %></td>
                <td><%=myres.getString("Brand") %></td>
                <td><%=myres.getInt("s") %></td>
                </tr>
                <% 
                }
                                %> </table>
                </body><%
             }
             /*Item-type*/
             if(second.equals("5")){
                Statement mystmt = con.createStatement();
                String sql = "select itemName, itemType, Brand, y.b z from (select t2.bidAmt b,s.idAuction,s.idItem from(select * from (select * from Bid order by idAuction, bidAmt desc, idUser) x group by idAuction) t2, Auction s where s.idAuction = t2.idAuction and now()> s.endsOn group by idSeller) y, Item I where I.idItem = y.idItem group by I.itemType";
                ResultSet myres =  mystmt.executeQuery(sql);
                System.out.println("bunny");
                                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>Name</td>
                <td>Type</td>
                <td>Brand</td>
                <td>bidamt</td>
                </tr> <%
                 while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">
                <td><%=myres.getString("itemName") %></td>
                <td><%=myres.getString("itemType") %></td>
                <td><%=myres.getString("Brand") %></td>
                <td><%=myres.getInt("z") %></td>
                </tr>

                <% 
                }
                                %> </table>
                </body><%
             }
             System.out.println("right before it");
             /*users*/
             if(second.equals("6")){
                Statement mystmt = con.createStatement();
                String sql = "Select sum(bidAmt) s,idUser from (select * from (select * from Bid order by idAuction, bidAmt desc,idUser) x group by idAuction) s group by idUser order by s desc limit 10";
                System.out.println("bad");
                ResultSet myres =  mystmt.executeQuery(sql);
                System.out.println("bunny");
                                 %> 
                 <body>
                <table border="2">
                <tr>
                <td>sumofmadewinningbids</td>
                <td>iduser</td>
                </tr> <%
                  while(myres.next()){
                    %>
                <tr bgcolor="#DEB887">

                <td><%=myres.getInt("s") %></td>
                <td><%=myres.getInt("idUser") %></td>
                </tr>
                <% 
                }
                                %> </table>
                </body><%            
             }
         }
            con.close();
    }catch(Exception ex){
        System.out.println("Something went wrong, redirecting you to the admin page");
        %>
        <script>
            window.location.href="adminPage.jsp";
        </script>
        <%
    }
     %>
<p> Want to go back? <a href="salesR.jsp" class ="meep"> Go back here</a></p>
</html>