<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/funweb";
	String user = "root";
	String password = "1234";
	
	Class.forName(driver);
	
	Connection con = DriverManager.getConnection(url, user, password);
	
	String sql = "SELECT * FROM member WHERE id=? AND pass=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, pass);
	
	ResultSet rs = pstmt.executeQuery();

	if(rs.next()){
		session.setAttribute("sId", id);
		response.sendRedirect("../main/main.jsp");
	}else {
		%>
		<script>
			alert("로그인 실패!");
			history.back();
		</script>
<% 
}

%>    
    
