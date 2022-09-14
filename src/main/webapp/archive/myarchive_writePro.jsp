<%@page import="board.ArchiveDAO"%>
<%@page import="board.ArchiveDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
 	// ------------------- 파일업로드 관련 처리 --------------------
 	// 1. 업로드 할 파일이 저장될 프로젝트 상의 경로
    String uploadPath = "/film";
    
    
 	// 2. 업로드 할 파일 최대 크기를 정수형으로 지정
    int fileSize = 1024 * 1024 * 10;
 	
 	// 3.
    ServletContext context = request.getServletContext();
    
    
 	// 4.
 	String realPath = context.getRealPath(uploadPath);
    
//  	out.println(realPath);
 	
	 // 5. MultipartRequest객체 생성
	 MultipartRequest multi = new MultipartRequest(
 			request, 	// 1) 실제 요청 정보가 포함된 request 객체
			realPath, 	// 2) 실제 업로드 되는 폴더 경로
			fileSize,	// 3) 업로드 파일 최대 크기
			"UTF-8",	// 4) 한글 파일명을 처리하기 위한 인코딩 방식
			new DefaultFileRenamePolicy()	// 5) 중복 파일명에 대한 기본처리 담당 객체 생성(파일명 뒤에 숫자 붙임)
			);
	//=> MultipartRequest 객체 생성 시점에 파일 업로드가 수행됨
			
	// 6. ArchiveDTO 객체 생성하여 업로드 파라미터 데이터 저장
    ArchiveDTO archive = new ArchiveDTO();
	 // 주의! request.getParameter() 메서드가 아닌 multi.getParameter() 메서드 호출필수!
    archive.setName(multi.getParameter("name"));
	archive.setPass(multi.getParameter("pass")); 
	archive.setType(multi.getParameter("camera"));
    archive.setSubject(multi.getParameter("subject"));
    archive.setContent(multi.getParameter("content"));
    
 	// 단, 파일명을 가져올 때는 단순히 getParameter() 메서드로 처리 불가
 	// 1) 파일명을 관리하는 객체에 접근하여 파일 목록 중 해당하는 파일명 가져오기
 	String fileElement = multi.getFileNames().nextElement().toString();
 	
 	// 2) 1번 과정에서 가져온 이름을 활용하여 원본 파일명과 실제 업로드 된 파일명 가져오기
    archive.setOriginal_file(multi.getOriginalFileName(fileElement));
    archive.setReal_file(multi.getFilesystemName(fileElement));
    
    //ArchiveDAO 객체의 insertFilmBoard() 메소드를 호출하여 글쓰기 작업 수행
    ArchiveDAO dao = new ArchiveDAO();
    int insertCount = dao.insertArchive(archive);
    
  	//INSERT 작업 수행 결과 판별
  		if(insertCount > 0){ // 글쓰기 성공 시 
  			response.sendRedirect("community.jsp");
  		}else {
  			%>
  			<script>
  			alert("글쓰기 실패!");
  			history.back();	
  			</script>
  			
  			<%
  		}
    
    
    
    
    %>