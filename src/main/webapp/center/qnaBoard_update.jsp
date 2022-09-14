
<%@page import="board.BoardDTO"%>
<%@page import="java.sql.Connection"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	int num = Integer.parseInt(request.getParameter("num"));
%>
	
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA</title>
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
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<!-- 본문 내용 -->
		<article>
			<h1>Q & A Board</h1>
			<form action="qnaBoard_updatePro.jsp" method="post">
			<input type="hidden" name="num" value="<%=num %>">	
				<table id="notice">
					<% 
					BoardDAO dao = new BoardDAO();
					BoardDTO board = dao.selectBoard(num);
					if(board != null){
						%>
					
					<tr>
						<th>글쓴이</th>
						<td><input type="text" name="name" value="<%=board.getName() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="subject" value="<%=board.getSubject() %>"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="10" cols="70" name="content"><%=board.getContent() %></textarea></td>
					</tr>
					<% 
					}
					%>
				</table>

				<div id="table_search">
					<input type="submit" value="글수정" class="btn">
					<input type="button" value="글목록" class="btn" onclick="location.href='qnaBoard.jsp'">
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


