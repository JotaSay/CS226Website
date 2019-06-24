<!-- Jeancarlo Bolanos JB1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
try {
        Class.forName("com.mysql.jdbc.Driver");
    }
catch(ClassNotFoundException ex) {
    System.out.println("Error: unable to load driver class!");
    return;
}
    System.out.println("starting");
    String id = request.getParameter("id");
    String choice = (String)session.getAttribute("choice");
    System.out.println("printing supposedly id");
    System.out.println(id);
    System.out.println("now apparently doing choice");
    System.out.println(choice);
    String uinfo = (String)session.getAttribute("uinfo");
    String meep = request.getParameter("meep");
    System.out.println(meep);
    String first = request.getParameter("first");
    String second = request.getParameter("second");
    String third = request.getParameter("thirdy");
    int yuh;


try{
        /* Based on what their selections were different results are yielded*/
         System.out.println("we are trying");
         Connection con = DriverManager.getConnection("jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb", "group20", "group20!");
         System.out.println("connected");
         if(choice.equals("1")){
             System.out.println("aqui");
             if(uinfo.equals("Auction")){
                 System.out.println("conejo");
                 String sql = "Update Auction Set "+meep+" = ? where idAuction = ?";
                /* create prepared statement then based off value of meep put it in there*/
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1,first);
                    ps.setString(2,id);
                    System.out.println(ps);
                    yuh = ps.executeUpdate();
                            if(yuh>0){
            System.out.println("yeeer");
            } else{
                System.out.println("stuck");
            }
                }
             else if(uinfo.equals("Item")){
                String sql = "Update Item Set "+meep+" = ? where idItem =?";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1,second);
                    ps.setString(2,id);
                    System.out.println(ps);
                    yuh =  ps.executeUpdate();
                            if(yuh>0){
            System.out.println("yeeer");
            } else{
                System.out.println("stuck");
            }

                }

             else{
                String sql = "Update User Set "+meep+" = ?  where idUser =?";

                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1,third);
                    ps.setString(2,id);
                    System.out.println(ps);
                    yuh = ps.executeUpdate();
                            if(yuh>0){
            System.out.println("yeeer");
            } else{
                System.out.println("stuck");
            }

             }
         }

         else if(choice.equals("2")){
             /*delete the instance pertaining to the id*/
            String sql = "Delete From "+uinfo+" where id"+uinfo+" = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1,id);
                System.out.println(ps);
                yuh = ps.executeUpdate();
                System.out.println(ps);
                        if(yuh>0){
            System.out.println("yeeer");
            } else{
                System.out.println("stuck");
            }

            }
    System.out.println("beef");
    %> <script>
    alert("Action completed");
    window.location.href="repPage.jsp";
    </script>
    <%
    System.out.println("wMe");
        
        con.close();
        return;
}
catch(Exception ex){
        System.out.println("Something went wrong, redirecting you to the rep page");
        %>
        <script>
            window.location.href="repPage.jsp";
        </script>
        <%
    }
     %>
</html>
