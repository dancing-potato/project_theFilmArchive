<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%
	 request.setCharacterEncoding("UTF-8");
	 String sId = (String)session.getAttribute("sId");
	if( sId == null ){
		%>
		<script>
			alert("잘못된 접근입니다!");
			history.back();
		</script>
		
	<% }%>
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Account</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<style type="text/css">

fieldset{

	color: red;
	font-size: 20px;
	font-weight: bold;
	text-align: center;
	line-height: 1.5em;
}

</style>
<script>

	function doubleCheck(){
		
		if(confirm("정말로 탈퇴하시겠습니까?")){
			location.href="deleteMyAccountPro.jsp";
		}
	}

</script>
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
			<h1>Delete MyAccount</h1><br>
			<fieldset><legend>* 주의사항 *</legend>
			계정 탈퇴 시 철회 혹은 복구할 수 없습니다.<br> 
			또한 탈퇴 시 본인이 작성한 게시글과 댓글은 자동으로 삭제되지 않습니다.<br>
			탈퇴 후 게시글 미삭제여부는 본인에게 책임이 있습니다.<br>
			동의하시는 경우에만 탈퇴를 진행해주세요.<br></fieldset>
			<form action="deleteMyAccountPro.jsp" method="post">
				<table id="notice">
					<tr>
						<th>Password</th>
						<td><input type="password" name="pass" ></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="submit" class="btn" onclick="doubleCheck()">
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

