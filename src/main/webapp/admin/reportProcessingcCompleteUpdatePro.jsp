<%@page import="board.ReportDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
 <%
 
 
int num = Integer.parseInt(request.getParameter("num"));
String processing = request.getParameter("processing");
 
 
// out.println(num);
// out.println(processing);
 
ReportDAO dao = new ReportDAO();
int updateProcessingCount = dao.updateProcessing(num,processing);

if(updateProcessingCount>0){
	%>
	<script>
	alert("해당글의 처리상태가 변경되었습니다.");
	location.href="reportProcessingCompleteUpdate.jsp";
	</script>
	
<% }else {%>
	<script>
	alert("해당글의 처리상태 변경에 실패했습니다.");
	history.back();
	</script>
<%} %> 