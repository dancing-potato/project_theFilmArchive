<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

String pass = request.getParameter("pass");
String sId = (String)session.getAttribute("sId");


MemberDAO dao = new MemberDAO();
int result = dao.deleteMember(sId,pass);

	if(result > 0){
		session.invalidate();
		response.sendRedirect("../main/main.jsp");
	} else {
	%>
	<script>
		alert("탈퇴에 실패하였습니다!");
		history.back();
	</script>
	
<% 
}	

%>