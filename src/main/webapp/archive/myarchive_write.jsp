<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Board write</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	// 세션에 저장된 아이디가 null 이면 자바스크립트를 통해 "회원만 접근 가능합니다"
	String id = (String)session.getAttribute("sId");
	
	if(id == null){
		%>
		<script>
			alert("회원만 접근 가능합니다!");
			history.back();
		</script>
	<%
	}
	
	%>
	
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
		  		<li><a href="../archive/community.jsp">Community</a></li>
		  		<li><a href="../archive/myarchive.jsp">My Archive</a></li>
		  	</ul>
		 </nav>
		<!-- 본문 내용 -->
		<article>
			<h1>My Archive</h1>
			<!-- 주의! 속성 지정 시 파라미터 가져오는 request.getParameter() 사용불가! -->
			<form action="myarchive_writePro.jsp" method="post" enctype="multipart/form-data">
				<table id="notice">

					<tr>
						<th colspan="2">글쓴이</th>
						<!--  작성자 이름은 세션 아이디로 고정하기 -->
						<td colspan="2"><input type="text" name="name" value="<%=id%>" readonly="readonly"></td>
					</tr>
					<tr>
						<th colspan="2">패스워드</th>
						<td colspan="2"><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<th colspan="2">타입</th>
						<td>
						<label for="film"><input type="radio" name="camera" id="film" value="film" > Film Camera</label> 
						<label for="digital"><input type="radio" name="camera" id="digital" value="digital" > Digital Camera</label>
						</td>
					</tr>
					<tr>
						<th colspan="2">제목</th>
						<td colspan="2"><input type="text" name="subject" required="required"></td>
					</tr>
					<tr>
						<th colspan="2">사진</th>
						<!-- 파일 업로드를 위해 "file"타입 지정 -->
						<td colspan="2"><input type="file" name="original_file" required="required"></td>
					</tr>
					<tr>
						<th colspan="2">내용</th>
						<td colspan="2"><textarea rows="10" cols="30" name="content" required="required"></textarea></td>
					</tr>
					
				</table>

				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
					<input type="button" value="글목록" class="btn" onclick="location.href='myarchive.jsp'">
					<input type="button" value="메인으로" class="btn" onclick="location.href='../main/main.jsp'">
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