<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 신고글(게시판이름, 신고글번호,글작성자,글제목) 정보 받아오기
String boardType = request.getParameter("boardType");
int postNum = Integer.parseInt(request.getParameter("num"));
String pName = request.getParameter("pId");
String pSub = request.getParameter("pSub");

//신고자 아이디 받아서 넘기기
String reporter = request.getParameter("sId");



%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<link href="../css/button.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="warning.jsp" method="post" id="warn_report" name="fr">
		<input type="hidden" value="<%=postNum %>" name="postNum">
		<input type="hidden" value="<%=reporter %>" name="reporter">
		<input type="hidden" value="<%=boardType %>" name="boardType">
			<fieldset>
				<legend>신고하기</legend>
					<label>신고글 위치</label>
					<input type="text" value="Q&A게시판" readonly="readonly"><br>
					<label>글 작성자</label>
					<input type="text" name="postName" value="<%=pName %>" readonly="readonly"><br>
					<label>글 제목</label>
					<input type="text" name="postsubject" value="<%=pSub %>" readonly="readonly"><br>
					<br>
					<label>신고사유</label>
					<textarea rows="3" cols="25" name="reportReason" placeholder="신고사유를 작성해주세요." required="required"></textarea><br>
			</fieldset>		
			<br>
			<div class="warn_btn">
				<input type="submit" id="report_btn" value="신고하기">	
				<input type="button" id="close" value="닫기" onclick="window.close()">
			</div>
		</form>
</body>
</html>