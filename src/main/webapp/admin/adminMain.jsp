<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//날짜 및 시각 정보 표시 형식을 변경하기 위해 SimpleDateFormat 클래스 활용
//=> 생성자 파라미터로 표시 형식 문자열을 사용한 패턴 지정
//=> ex) "yy-MM-dd HH:mm" 지정 시 "22-08-19 16:15" 형식으로 변환됨
SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
//=> 패턴이 지정된 SimpleDateFormat 객체의 format() 메서드를 호출하여 변환할 날짜 객체 전달
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
<script>

function outOfCheck(id){

	if(confirm("이 회원을 강제탈퇴 시키시겠습니까?")){
		location.href="forcedout.jsp?id="+id;
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
	  		<li><a href="../admin/reportList.jsp">신고글 처리대기</a></li>
	  		<li><a href="../admin/reportCompleteList.jsp">신고글 처리완료</a></li>
	  		<li><a href="../admin/adminMain.jsp">회원 목록</a></li>
	  	</ul>
	 	</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Member List</h1>
			<table id="notice">
				<tr>
					<th class="ttitle">ID</th>
					<th class="ttitle">Name</th>
					<th class="ttitle">Mobile</th>
					<th class="twrite">Email</th>
					<th class="tdate">JoinDate</th>
					<th class="tread"></th>
				</tr>
				
				<% 
				
				// 페이징처리
				// 1. 한 페이지에서 표시할 게시물 목록 수와 페이지 목록 수 설정
				int listLimit = 10;
				
				// 2. 현재 페이지 번호 설정(pageNum 파라미터)
				// 현재 페이지 번호 기본값을 1로 설정
				int pageNum = 1;
				// 만약, pageNum 파라미터가 존재할 경우 가져와서 저장
				if(request.getParameter("pageNum") != null){
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}
				
				// 3. 현재 페이지에서 목록으로 표시할 첫 게시물의 행 번호 계산
				int startRow = (pageNum -1) * listLimit;
				
				MemberDAO dao = new MemberDAO();
				ArrayList<MemberDTO> memberList = dao.selectMemberList(startRow, listLimit);
				
				for( MemberDTO member : memberList ){
				
					%>
					<tr>
						<td onclick="location.href='member_detail.jsp?id=<%=member.getId() %>'"><%=member.getId() %></td>
						<td><%=member.getName() %></td>
						<td><%=member.getMobile() %></td>
						<td><%=member.getEmailw() %></td>
						<td><%=sdf.format(member.getDate()) %></td>
						<td>
						<div id="fout">
						<input type="button" name="out" id="out" value="강퇴" onclick="outOfCheck('<%=member.getId() %>')">
						</div>
						</td>
					</tr>
					
					
				<%}%>
			</table>
			

			<div class="clear"></div>
			<div id="page_control">
			<%
			// 한 페이지에서 보여줄 페이지 갯수 계산
			// 1. BoardDAO 객체의 selectBoardListCount() 메서드를 호출하여 전체 게시물 수 조회
			// => 파라미터 : 없음    리턴타입 : int(boardListCount)
			int memberListCount = dao.selectMemberListCount();
			
			
			// 2. 한 페이지에서 표시할 페이지 목록 갯수 설정
			int pageListLimit = 10; 
			
			// 3. 전체 페이지 수 계산
			// => 전체 게시물 수를 페이지 당 목록 갯수로 나눈 나머지가 0이면 몫을 그대로 사용하고
			//    아니면 나눗셈 결과 + 1
			int maxPage = memberListCount / pageListLimit + (memberListCount % pageListLimit == 0 ? 0 : 1); 
	
			
			// 4. 시작 페이지 번호 계산
			// => (현재 페이지 - 1) / 페이지목록갯수 * 페이지목록갯수 + 1
			int startPage = (pageNum -1) / pageListLimit * pageListLimit + 1;
			
			// 5. 끝 페이지 번호 계산
			// => 시작페이지 + 페이지 목록 갯수 -1
			int endPage = startPage + pageListLimit - 1;
			
			// 6. 만약, 끝 페이지 번호(endPage)가 최대 페이지 번호보다 클 경우 
			//   끝페이지 번호를 최대 페이지 번호로 교체
			if(endPage > maxPage){
				endPage = maxPage;
			}
			
			%>
			<!-- 이전 페이지버튼(Prev) 클릭 시 현재 페이지번호 -1 값 전달 -->
			<!-- 단, 현재 페이지번호가 1 페이지보다 클 경우 하이퍼링크 표시(아니면 제거) -->
			<% if(pageNum == 1) {%>
				<a href="javascript:void(0)">Prev</a>
			<%} else  {%>
				<a href="adminMain.jsp?pageNum=<%=pageNum - 1%>">Prev</a>
			<%} %>	
				<!--  for문을 사용하여 startPage ~ endPage 까지 목록 표시 -->
				<%for(int i = startPage; i <= endPage; i++){%>
					<!-- 현재 페이지 번호(pageNum) 가 i 값과 같을 경우 하이퍼링크 제거 -->
					<%if(pageNum == i) { %>
						<a href="javascript:void(0)"><%=i %></a>
					<%} else { %>
					<a href="adminMain.jsp?pageNum=<%=i%>"><%=i %></a>
					
					<%} %>
				<%} %>
			
				<!-- 다음 페이지버튼(Prev) 클릭 시 현재 페이지번호 +1 값 전달 -->
				<!-- 단, 현재 페이지번호가 최대 페이지 번호보다 작을 경우 하이퍼링크 표시(아니면 제거) -->
				<% if(pageNum == maxPage){%>
					<a href="javascript:void(0)">Next</a>
				<%} else { %>
					<a href="adminMain.jsp?pageNum=<%=pageNum + 1%>">Next</a>
				<%} %>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
		</div>
</body>
</html>
