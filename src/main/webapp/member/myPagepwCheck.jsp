
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if( session.getAttribute("sId") == null ){
		%>
		<script>
			alert("잘못된 접근입니다!");
			history.back();
		</script>
		
	<% }%>	
	<%
	
	String id = (String)session.getAttribute("sId");
	String pass = request.getParameter("pass");
		
	
	MemberDAO dao = new MemberDAO();
	int result = dao.myPagePassCheck(id,pass);
	
	if(result > 0){
		session.setAttribute("sId", id);
		%>
		<script>
		location.href="myPagePro.jsp?pass=<%=pass %>";
		</script>
		<% 
	} else {
		%>
		<script>
			alert("패스워드가 올바르지 않습니다!");
			history.back();
		</script>
		<%
	}

%>