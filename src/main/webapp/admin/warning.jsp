<%@page import="board.ReportDAO"%>
<%@page import="board.ReportDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("UTF-8");

//post 줄여서 p로 약칭
int refNum = Integer.parseInt(request.getParameter("postNum"));
String boardType = request.getParameter("boardType");
String postName = request.getParameter("postName");
String postSubject = request.getParameter("postsubject");
String reportReason = request.getParameter("reportReason");
String reporter = request.getParameter("reporter");

// out.println(refNum);
// out.println(boardType);
// out.println(postName);
// out.println(postSubject);
// out.println(reportReason);
// out.println(reporter);

ReportDTO report = new ReportDTO();
report.setBoardType(boardType);
report.setRefNum(refNum);
report.setPostName(postName);
report.setPostSubject(postSubject);
report.setReportReason(reportReason);
report.setReporter(reporter);

ReportDAO dao = new ReportDAO();
int insertReportResult = dao.reportPostInsert(report);

if(insertReportResult > 0){
	%>
	<script>
	alert("신고가 완료되었습니다!");
	window.close();
 	</script> 

<%} else { %>
	<script>
	alert("게시글 신고에 실패하였습니다.다시 시도해 주세요.");
 	</script> 
	
<%}%>    
    
    
