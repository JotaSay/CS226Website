<!-- Suraj Kakkad spk101 -->

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

	<% String url = "jdbc:mysql://cs336g20.coakf4pqnamg.us-east-2.rds.amazonaws.com:3306/innodb";
	Connection conn = null;
	PreparedStatement ps = null;
	try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "group20", "group20!");
			String username = request.getParameter("idUser").toString();
			//out.println(username);
			String questionText = request.getParameter("questionText");
			String id = request.getParameter("idItem");
			//out.println(id);
			//out.println(questionText);
	%>

			<%
			  if(questionText != null && !questionText.isEmpty()){
				String insert = "INSERT INTO Questions (idItem, questionText, answerText,idUser)" + "VALUES (?, ?, ?, ?)";
				ps = conn.prepareStatement(insert);
				ps.setString(1,id);
				ps.setString(2,questionText);
				ps.setString(3,"Wait for a customer representative to answer your question.");
				ps.setString(4,username);
				System.out.println(ps);
				out.println("Inserting into questions table...");
				int result = 0;
		    result = ps.executeUpdate();
		        if (result < 1) {
		        	out.println("Error: Question failed.");
		        } else {
		        	response.sendRedirect("questions.jsp?submit=success");
		        	return;
		        }
			} else {
				response.sendRedirect("questionError.jsp");
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
