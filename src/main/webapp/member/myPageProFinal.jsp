<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("UTF-8");

// id받아야함
String id = (String)session.getAttribute("sId");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String mobile = request.getParameter("mobile");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String emailw = request.getParameter("email1") + "@" +request.getParameter("email2"); 
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

 int updateCount  = dao.updateMember(member);

if(updateCount > 0){
	%>
	<script>
		alert("성공적으로 수정되었습니다!");
		location.href="../main/main.jsp";
	</script>
	<%
} else {
	%>
	<script>
		alert("정보수정에 실패하였습니다!");
		history.back();
	</script>
	<%
}

%>