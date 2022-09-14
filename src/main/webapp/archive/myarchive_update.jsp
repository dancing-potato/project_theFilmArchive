<%@page import="board.ArchiveDTO"%>
<%@page import="board.ArchiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	String id = (String)session.getAttribute("sId");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");
	
	ArchiveDAO dao = new ArchiveDAO();
	ArchiveDTO archive = dao.selectMyArchiveBoard(id,num);
	
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPost Update</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script>
window.onload = function (){
		var camera = '<%=archive.getType()%>';
		document.getElementById(camera).checked = true;
	};
</script>
</head>
<body>
	<%
	// 세션에 저장된 아이디가 null 이거나 게시물의 아이디와 일치하지 않으면 
	// 자바스크립트를 통해 "회원만 접근 가능합니다" 출력 후 돌아가기
	// 단, 관리자아이디("admin")는 접근 권한 허용
	
	
	if(id == null || !id.equals("admin") && !id.equals(archive.getName())){
		// 관리자 아이디가 아니고 세션 아이디가 일치하지 않으면 권한 없음
		// (관리자 아이디이거나 세션 아이디가 일치하면 권한 있음)
		%>
		<script>
			alert("접근권한이 없습니다!");
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
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<!-- 본문 내용 -->
		<article>
			<h1>MyPost Update</h1>
			<form action="myarchive_updatePro.jsp" method="post" enctype="multipart/form-data">
			<!-- 입력받지 않은 글번호도 함께 전달 -->
			<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
			<!-- 기존 파일 삭제를 위해 실제 업로드 파일명도 함께 전달  -->
			<input type="hidden" name="real_file" value="<%=archive.getReal_file()%>">
				<table id="notice">
					<tr>
						<th colspan="2">글쓴이</th>
						<td><input type="text" name="name" value="<%=archive.getName()%>" required="required" readonly="readonly"></td>
					</tr>
					<tr>
						<th colspan="2">패스워드</th>
						<td><input type="password" name="pass" required="required"></td>
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
						<td><input type="text" name="subject" value="<%=archive.getSubject()%>" required="required" width="100px"></td>
					</tr>
					<tr>
						<th colspan="2">사진</th>
						<td>
							<%=archive.getOriginal_file() %><br>
							<input type="file" name="original_file" required="required">
						</td>
					</tr>
					<tr>
						<th colspan="2">내용</th>
						<td><textarea rows="5" cols="70" name="content" required="required"> <%=archive.getContent()%></textarea></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="button" value="글목록" class="btn" onclick="location.href='myarchive.jsp'">
					<input type="submit" value="수정하기" class="btn">
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
