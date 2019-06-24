<!-- Jeancarlo Bolanos JB1618-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title> Updating</title>
    <head>
    <form method = "POST" action = "editReq.jsp"> <label> Enter the ID </label>
    <input type = "number" name ="id">
<%
/*getting parameters*/
    String choice = request.getParameter("uord");
    System.out.println(choice);
    String uinfo = request.getParameter("uinfo");
    session.setAttribute("choice",choice);
    session.setAttribute("uinfo",uinfo);
    if(choice.equals("1")){
        if(uinfo.equals("Auction")){
            /*generate html based on what they chose*/
                %><p>Auction </p>
                <p> Please select the attribute you would like to edit</p>
                <select value = radio name = 'meep'>
                <option value ="reservePrice">Reserve price</option>
                <option value = "idSeller"> Seller ID</option>
                <option  value = "endsOn"> EndTime </option>
                </select>
                <label> Input, if endOn put it in yyyy-mm-dd , optional hh-mm-ss </label>
                <input type = "text" name = "first">
                <input type = "submit" value = "Edit"/>
                </form><%


        }
        else if (uinfo.equals("Item")){

                %><p> Item</p>
                <p> Please select the attribute you would like to edit</p>
                <select value = radio name = 'meep'>
                <option value = "itemName">Name</option>
                <option value = "Brand"> Brand</option>
                <option value ="itemCondition"> Condition </option>
                </select>
             <label> Input </label>
            <input type = "text" name ="second">
            <input type = "submit" value = "Edit"/>
            </form><%

        }
        else{
            %> <p> User</p>
                <p> Please select the attribute you would like to edit</p>
                <select value = radio name = 'meep'>
                <option value ="Email">Email</option>
                <option value ="First_Name"> First Name</option>
                <option value = "Last_Name"> Last Name </option>
                </select>
            <label>Input </label>
             <input type ='text' name ='thirdy'>
            <input type = "submit" value = "Edit"/>
            </form> <%


        }
    }
    else{
        if(uinfo.equals("User")){
            session.setAttribute("uinfo","Account");
        }
        %> <input type = "submit" value = "Delete">
        </form><%
    }

    /*find the driver*/

%>
<p> Logout<a href="logout.jsp" class = "meep">Here</a></p>
</html>
