<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.JdbcUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <h1>아이디 중복체크</h1>
   
   <% 
   
   String id = request.getParameter("id");
   
   MemberDAO dao = new MemberDAO();
   boolean checkResult = dao.checkId(id);
  
   
		   
  	if(checkResult){
  		out.print("사용중인 아이디입니다.<br>다시 입력해주세요.<br>");
  		%>
  		<script>
  		window.opener.document.getElementById("id").value = "";
  		window.opener.document.getElementById("checkId").innerHTML = "아이디를 다시확인하세요";
  		
  		</script>
  		<% 
  	} else {
  		out.print("사용가능한 아이디입니다.<br><br>");
  		%>
  		<script>
  		window.opener.document.getElementById("checkId").innerHTML = "중복확인완료";
  		
  		</script>
  		<% 
  	}
  		%>
  		<input type="button" value="확인" onclick="window.close()">
  		
  	
  	
  	
  	
   