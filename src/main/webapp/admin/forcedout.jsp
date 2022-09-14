<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	String id = request.getParameter("id");
	
	MemberDAO dao = new MemberDAO();
	int result = dao.deleteMember(id);
	
	if(result > 0){
	%>
		<script>
			alert("선택한 회원이 탈퇴되었습니다!");
			history.back();
		</script>
	<%} else {%>
		<script>
			alert("회원 강제탈퇴에 실패하였습니다!");
			history.back();
		</script>
		
	<% 
	}	
	
	%>
