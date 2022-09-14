<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	BoardDTO board = new BoardDTO();
	board.setNum(num);
	board.setPass(pass);
	board.setSubject(subject);
	board.setContent(content);
	
	BoardDAO dao = new BoardDAO();
	int updateCount = dao.updateBoard(board);
	
	
	if(updateCount > 0){
		response.sendRedirect("qnaBoard_content.jsp?num=" + num);
	} else {
		%>
		<script>
			alert("글 수정 실패!");
			history.back();
		</script>
		<%
	}
	
	
	
%>