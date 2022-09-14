<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("UTF-8");
String aId = (String)session.getAttribute("sId");
String id = request.getParameter("id");

System.out.println(aId);
System.out.println(id);


// if(aId == null || !aId.equals("admin") || id == null){
// 
// 	<script>
// 		alert("잘못된 접근입니다!");
// 		location.href="../main/main.jsp";
// 	</script>



MemberDAO dao = new MemberDAO();
MemberDTO member = dao.selectMember(id);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%> 
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세정보</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div>
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
			<nav id="sub_menu">
		  	<ul>
		  		<li><a href="../admin/adminMain.jsp">Member List</a></li>
		  	</ul>
		 	</nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Member Information</h1>
		  	<table id="notice">
		  		<tr>
					<th>아이디</th>
					<td colspan="2"><%=member.getId()%></td>
					<th>이름</th>
					<td colspan="2"><%=member.getName() %></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td colspan="2"><%=member.getMobile() %></td>
					<th>E-mail</th>
					<td colspan="2"><%=member.getEmailw() %></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td><%=member.getPost_code() %></td>
					<th>기본주소</th>
					<td><%=member.getAddress1() %></td>
					<th>상세주소</th>
					<td><%=member.getAddress2() %></td>
				</tr>
				<tr>
					<th>카메라 타입</th>
					<td colspan="2"><%=member.getCamera() %></td>
					<th>가입일자</th>
					<td colspan="2"><%=sdf.format(member.getDate()) %></td>
				</tr>
				</table>
				<div id="table_search">
				<input type="button" value="회원목록" class="btn2" onclick="location.href='adminMain.jsp'">
				</div>
		  </article>
		  </div>
		  
		<div class="clear">
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>