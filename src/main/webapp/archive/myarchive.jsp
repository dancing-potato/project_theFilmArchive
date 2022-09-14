<%@page import="board.ReplyDAO"%>
<%@page import="board.ArchiveDTO"%>
<%@page import="board.ArchiveDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%




//날짜 및 시각 정보 표시 형식을 변경하기 위해 SimpleDateFormat 클래스 활용
//=> 생성자 파라미터로 표시 형식 문자열을 사용한 패턴 지정
//=> ex) "yy-MM-dd HH:mm" 지정 시 "22-08-19 16:15" 형식으로 변환됨
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd ");
//=> 패턴이 지정된 SimpleDateFormat 객체의 format() 메서드를 호출하여 변환할 날짜 객체 전달

String sId = (String)session.getAttribute("sId");
if(sId == null){
	%>
	<script>
		alert("로그인 후 사용가능합니다.");
		history.back();
	</script>
	<%
}
%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Archive</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage4bd.css" rel="stylesheet" type="text/css">
<link href="../css/mine.css" rel="stylesheet" type="text/css">
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
		  		<li><a href="../archive/community.jsp">Community</a></li>
		  		<li><a href="../archive/myarchive.jsp">My Archive</a></li>
		  	</ul>
		 </nav>
		<!-- 본문 내용 -->
		<article>
			<div id="board_head"><h1>My Archive</h1></div>
				<div id="photolist">
				<% 
				
				// 페이징처리
				// 1. 한 페이지에서 표시할 게시물 목록 수와 페이지 목록 수 설정
				int listLimit = 9;
				
				// 2. 현재 페이지 번호 설정(pageNum 파라미터)
				// 현재 페이지 번호 기본값을 1로 설정
				int pageNum = 1;
				// 만약, pageNum 파라미터가 존재할 경우 가져와서 저장
				if(request.getParameter("pageNum") != null){
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}
				
				// 3. 현재 페이지에서 목록으로 표시할 첫 게시물의 행 번호 계산
				int startRow = (pageNum -1) * listLimit;
				
				
				ArchiveDAO dao = new ArchiveDAO();
				ReplyDAO replyDAO = new ReplyDAO();
				ArrayList<ArchiveDTO> myArchiveList = dao.selectMyArchiveList(sId,startRow, listLimit);
				
 				// ArrayList 객체의 제네릭타입이 ArchiveDTO 타입으로 지정되어 있으므로
				// ArrayList 객체로부터 꺼낸 데이터는 ArchiveDTO 타입이 확정된다.
				
				
				for(ArchiveDTO archive : myArchiveList){
					int refNum = archive.getNum();
					String boardType = "archive";
					int replyCount = replyDAO.replyCount(refNum,boardType);
				%>		
					<!-- 반복문 내에서 각 레코드를 각 행에 표시 -->	
					
					
					  <div class="container">
					    <div class="row">
					    <%-- 1개씩 반복되는 사진카드 출력  --%>	
					      <div class="card_container">
					        <div class="cd"><a href="community_content.jsp?num=<%=archive.getNum()%>">
					         <img src="../film/<%=archive.getOriginal_file()%>" class="img-thumnail">
					         	<p id="text_pt">
					         	<i></i>No.<%=archive.getNum() %><br> 
					         	<i></i><%=archive.getReadcount() %><br>
					         	<i></i><%=sdf.format(archive.getDate())%><br>
					         	<%if(replyCount > 0){%>
								<i></i>댓글(<%=replyCount %>)
								<%}%>
					     		</p>
					         </div>
					         		<div class="card_header">
					            		<h1><%=archive.getSubject() %></h1>
					            	</div>
						            <div class="card_body">
							            <i></i> <div id="name"><%=archive.getName() %></div>
						          </div>
					          </a>
					      </div>
					    </div>
					  </div>
					
				<% 
				}
				%>
				</div>	
				
			<%-- 검색 파트  --%>	
			</table>
			<div id="table_search">
				<form action="myarchive_search.jsp" method="get" class="search_fr">
					<input type="text" name="keyword" class="input_box" placeholder="찾으실 제목을 입력하세요">
					<input type="submit" value="Search" class="btn">
					<input type="button" value="글쓰기" class="btn2" onclick="location.href='myarchive_write.jsp'">
				</form>
			</div>

			<div class="clear"></div>
			<div id="page_control">
			<%
			
			
			// 내 목록 한 페이지에서 보여줄 페이지 갯수 계산
			// 1. ArchiveDAO 객체의 selectMyArchiveListCount() 메서드를 호출하여 전체 게시물 수 조회
			// => 파라미터 : 내아이디    리턴타입 : int(boardListCount)
			int myarchiveListCount = dao.selectMyArchiveListCount(sId);
			
			
			
			// 2. 한 페이지에서 표시할 페이지 목록 갯수 설정
			int pageListLimit = 9; 
			
			// 3. 전체 페이지 수 계산
			// => 전체 게시물 수를 페이지 당 목록 갯수로 나눈 나머지가 0이면 몫을 그대로 사용하고
			//    아니면 나눗셈 결과 + 1
			int maxPage = myarchiveListCount / pageListLimit + (myarchiveListCount % pageListLimit == 0 ? 0 : 1); 
	
			
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
				<a href="myarchive.jsp?pageNum=<%=pageNum - 1%>">Prev</a>
			<%} %>	
				<!--  for문을 사용하여 startPage ~ endPage 까지 목록 표시 -->
				<%for(int i = startPage; i <= endPage; i++){%>
					<!-- 현재 페이지 번호(pageNum) 가 i 값과 같을 경우 하이퍼링크 제거 -->
					<%if(pageNum == i) { %>
						<a href="javascript:void(0)"><%=i %></a>
					<%} else { %>
					<a href="myarchive.jsp?pageNum=<%=i%>"><%=i %></a>
					
					<%} %>
				<%} %>
			
				<!-- 다음 페이지버튼(Prev) 클릭 시 현재 페이지번호 +1 값 전달 -->
				<!-- 단, 현재 페이지번호가 최대 페이지 번호보다 작을 경우 하이퍼링크 표시(아니면 제거) -->
				<% if(pageNum == maxPage){%>
					<a href="javascript:void(0)">Next</a>
				<%} else { %>
					<a href="myarchive.jsp?pageNum=<%=pageNum + 1%>">Next</a>
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
