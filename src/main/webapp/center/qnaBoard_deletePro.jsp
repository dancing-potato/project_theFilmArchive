<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");


	//가져온 폼 파라미터 데이터를 BoardDTO 객체를 생성하여 저장하기
	BoardDTO board = new BoardDTO();
	
	//데이터베이스 작업 수행을 위한 BoardDAO 클래스 객체(dao)를 생성하기
	BoardDAO dao = new BoardDAO();
	
	//BoardDAO 객체의 deleteBoard()메서드를 호출해 글삭제 작업 수행
	//=>파라미터: 삭제할 게시물 정보(BoardDTO 객체 - board) 리턴타입 : int(deleteCount)
	int deleteCount = dao.deleteBoard(num, pass);
	
	if(deleteCount > 0){
		%>
		<script>
			alert("게시물 삭제 성공!");
			location.href = "qnaBoard.jsp";
		</script>
		<%
	}else {
		%>
		<script>
			alert("게시물 삭제 실패!");
			history.back();
		</script>
		<%
	}
	%>



