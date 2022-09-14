<%@page import="board.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.ArchiveDTO"%>
<%@page import="board.ArchiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
	if(request.getParameter("num")==null){
		%>
		<script>
			alert("잘못된 접근입니다!");
			history.back();
		</script>
		
	<% 
	}
		
		
	int num = Integer.parseInt(request.getParameter("num"));
	String sId = (String)session.getAttribute("sId");
	
	ArchiveDAO dao = new ArchiveDAO();
	
	
	// FileBoardDAO 객체의 updateReadcount() 메서드를 호출하여 게시물 조회수 증가 작업 수행
	// => 파라미터 : 글번호(num)  리턴타입 : void
	//dao.updateReadcount(num);
	
	// FileBoardDAO 객체의 selectBoard() 메서드를 호출하여 게시물 1개 조회 작업 수행
	// => 파라미터 : 아이디,글번호(num)  리턴타입 : BoardDTO(board)
	
	ArchiveDTO archive = dao.selectMyArchiveBoard(sId,num);
	
	if(sId == null || !sId.equals(archive.getName())){			
		dao.updateReadcount(num);		
	}		
			
		
	// 날짜 표시 형식 변경을 위한 SimpleDateFormat 객체 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	
	
	
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">


	function forwardReply(){
		
		// 세션 아이디가 있을 경우에만 쓰기 동작 수행 -> 세션 아이디 없으면 경고 출력 후 중단
		<%if(sId != null){%>
		
		var content = document.getElementById("reply_content").value;
		
		
		// notice_content_reply_writePro.jsp 페이지로 포워딩
		// => 파라미터 : 글번호,작성자(세션아이디), 댓글내용, 댓글게시판 타입(driver)
		location.href = "community_content_reply_writePro.jsp?boardType=commu&num=<%=archive.getNum()%>&name=<%=sId%>&content=" + content;
		
		<%} else {%>
			alert("댓글은 로그인 후 사용가능합니다!");
		<%}%>
		
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
		  		<li><a href="../archive/community.jsp">Community</a></li>
		  		<li>
		  		<%
		  		if(sId!=null){%>
		  		<a href="../archive/myarchive.jsp">My Archive</a></li>
		  		<%}%>
		  	</ul>
		 </nav>
		<!-- 본문 내용 -->

		<article>
			<h1>My Archive</h1>
			<table id="notice">
				<tr>
					<th>글번호</th>
					<td><%=archive.getNum() %></td>
					<th>타입</th>
					<td><%=archive.getType() %></td>
					<th>조회수</th>
					<td><%=archive.getReadcount() %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td colspan="3"><%=archive.getName() %></td>
					<th>작성일</th>
					<td><%=sdf.format(archive.getDate()) %></td>
				</tr>
				
				
				<tr>
					<th>제목</th>
					<td colspan="5"><%=archive.getSubject() %></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5"><img src="../film/<%=archive.getOriginal_file()%>" width="800px" ><br><br>
					<%=archive.getContent() %><br><br>
					</td>
				</tr>
				<tr>
					<th>파일</th>
					<td colspan="5">
					<!-- 실제 파일과 연결하여 파일 다운로드 하이퍼링크 생성 -->
					<a href="../film/<%=archive.getReal_file()%>" download="<%=archive.getOriginal_file() %>"><%=archive.getOriginal_file() %></a>
					</td>
				</tr>
				<tr>
					<tr>
					<th>댓글</th>
					<td colspan="4" class="content_reply">
						<textarea rows="2" cols="72" id="reply_content"></textarea>
					</td>
					<td>
						<input type="button" class="reply_btn" value="write" 
						onclick="forwardReply()">
					</td>
				</tr>
				<!-- 댓글 목록 가져와서 출력하기 -->
				<%
				// ReplyDAO 객체 생성 후 selectReplyList() 메서드를 호출하여 댓글 목록 가져오기
				// => 파라미터 : 글번호(num)   리턴타입 : List<ReplyDTO>(replyList)
				ReplyDAO replyDAO = new ReplyDAO();
				String boardType = "commu";
				List<ReplyDTO> replyList = replyDAO.selectReplyList(num,boardType);
				
				// 날짜 및 시각 형식을 "월월-일일 시시:분분" 형식으로 설정
				SimpleDateFormat sdf2 = new SimpleDateFormat("MM-dd HH:mm");
				
				// List 객체 크기만큼 반복하면서 ReplyDTO 객체(reply) 꺼내기 => 향상된 for문 사용
				for(ReplyDTO reply : replyList) {
					%>
					<tr>
						<td>
							<!-- 댓글 작성자와 세션 아이디가 같으면 삭제 버튼 표시 -->
							<%if(sId != null && sId.equals(reply.getName())) { %>
								<a href="community_content_reply_deletePro.jsp?num=<%=reply.getNum()%>&refNum=<%=num%>"><img src="../images/delete_icon.png"></a>
<%-- 							<input type="button" value="삭제" onclick="location.href='community_content_reply_deletePro.jsp?num=<%=reply.getNum()%>&refNum=<%=num%>'"> --%>
							<%} %>
						</td>
						<td class="left"><%=reply.getContent() %></td>
						<td><%=reply.getName() %></td>
						<td><%=sdf2.format(reply.getDate()) %></td>
					</tr>
					<%
				}
				%>
			</table>

			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='myarchive_update.jsp?num=<%=num%>'"> 
				<input type="button" value="글삭제" class="btn" onclick="location.href='myarchive_delete.jsp?num=<%=num%>'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href='myarchive.jsp'">
			</div>

			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>

    