<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%
	 request.setCharacterEncoding("UTF-8");
	 
	if( session.getAttribute("sId") == null ){
		%>
		<script>
			alert("로그인 후 사용가능합니다.");
			history.back();
		</script>
		
	<% }%>
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_delete.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		 <nav id="sub_menu">
	  		<ul>
				<li><a href="../member/myPage.jsp">My Page</a></li>
		  		<li><a href="../member/deleteMyAccount.jsp">Delete Account</a></li>
		  	</ul>
		 </nav>	
		<!-- 본문 내용 -->
		<article>
			<h1>My Page</h1>
			<form action="myPagepwCheck.jsp" method="post">
				<table id="notice">
					<tr>
						<th>Password</th>
						<td><input type="password" name="pass" ></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="submit" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>

