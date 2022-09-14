<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//join.jsp페이지로부터 전달받은 파라미터를 사용하여 funweb.member테이블에 추가
// =>추가 성공 시 main 으로 이동하고
// 	 실패 시 자바스크립트 사용하여 "회원가입 실패!" 출력 후 이전페이지로 돌아가기

	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String mobile = request.getParameter("mobile");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String emailw = request.getParameter("email1")+"@"+request.getParameter("email2");
	String camera = request.getParameter("camera");
	String post_code = request.getParameter("post_code");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String phone = request.getParameter("phone");
	
	
	MemberDTO member = new MemberDTO();
	member.setId(id);
	member.setPass(pass);
	member.setName(name);
	member.setMobile(mobile);
	member.setEmail1(email1);
	member.setEmail2(email2);
	member.setEmailw(emailw);
	member.setCamera(camera);
	member.setPost_code(post_code);
	member.setAddress1(address1);
	member.setAddress2(address2);
	member.setPhone(phone);

		
	
	MemberDAO dao = new MemberDAO();
	int insertCount = dao.insertMember(member);
	
	
	if(insertCount > 0){
		%>
		<script>
			alert("회원가입 성공");
			location.href="../main/main.jsp";
		</script>
		
		<%
	} else {
		%>
		<script>
			alert("회원가입 실패!");
			history.back();
		</script>
		
		<%
}
%>


