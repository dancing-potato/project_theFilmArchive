<%@page import="board.ReportDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.ReportDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
String sId = (String)session.getAttribute("sId");

if(sId == null || !sId.equals("admin")){
		%>
		<script>
			alert("잘못된 접근입니다!");
			location.href="../main/main.jsp";
		</script>

<%} %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/button.css" rel="stylesheet" type="text/css">
<script>

	
	function checkUpdateProcessing(num,processing){
		location.href='reportProcessingUpdatePro.jsp?num='+num+'&processing='+processing;
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
	  		<li><a href="../admin/reportList.jsp">신고글 처리대기</a></li>
	  		<li><a href="../admin/reportCompleteList.jsp">신고글 처리완료</a></li>
	  		<li><a href="../admin/adminMain.jsp">회원 목록</a></li>
	  	</ul>
	 	</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Report List</h1>
			<div class="admin_btn">
			<input type="button" value="수정완료" id="processing_update" onclick="location.href='reportList.jsp'">
			</div>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="twrite">게시판</th>
					<th class="twrite">작성자</th>
					<th class="ttitle">글제목</th>
					<th class="ttitle">신고사유</th>
					<th class="twrite">신고자</th>
					<th class="tdate">신고일</th>
					<th class="twrite">처리상태</th>
					<th class="twrite">상태수정</th>
					
					
				</tr>
				<% 

				ReportDAO dao = new ReportDAO();
				ArrayList<ReportDTO> reportList = dao.selectReportList();
				for(ReportDTO report : reportList ){
				
				%>    
				<tr>
						<td><%=report.getNum() %></td>
						<td><%=report.getBoardType() %></td>
						<td><%=report.getPostName() %></td>
						<td><%=report.getPostSubject() %></td>
						<td><%=report.getReportReason() %></td>
						<td><%=report.getReporter() %></td>
						<td><%=sdf.format(report.getReportDate()) %></td>
						<td><%=report.getProcessing() %></td>
						<td>
						<select id="selectbox" onchange="checkUpdateProcessing(<%=report.getNum()%>,this.value)">
							<option id="상태수정" value="상태선택">상태선택</option>
							<option id="처리중" value="처리중">처리중</option>
							<option id="처리완료" value="처리완료">처리완료</option>
							<option id="처리불가" value="처리불가">처리불가</option>
						</select>
						
						</td>
				</tr>
					
			
			<%}%>
			</table>
			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
		</div>
</body>
</html>