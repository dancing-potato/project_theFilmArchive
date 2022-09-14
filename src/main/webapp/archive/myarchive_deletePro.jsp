<%@page import="java.io.File"%>
<%@page import="board.ArchiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        
<%

	int num = Integer.parseInt(request.getParameter("num"));
	String pass = request.getParameter("pass");
	
	
	ArchiveDAO dao = new ArchiveDAO();
	
	// 업로드 된 파일 삭제를 위해 selectRealFile() 메서드 호출하여 실제 업로드된 파일명 조회
	// => 주의! 레코드 삭제 전 미리 파일명 조회 필요!!!
	String realFile = dao.selectRealFilm(num);
// 	System.out.println(realFile);
	
	int deleteCount  = dao.deleteFilmArchive(num,pass);
	
	// 작업 결과 판별
	// => 성공시 해당실제파일을 삭제 후 글목록으로 이동하고,
	//	  실패시 글삭제실패 출력후 이전페이지로 돌아가기 
	
	
	
	if(deleteCount > 0){
		// ------------------------- 파일 삭제 해라 ---------------------------------
		
		//					윈도우,리눅스체제 맞춰서 알아서 넣어줌
		String uploadPath = File.separator + "film";	// 이클립스 상의 가상의 업로드경로. 
		
		// 	ServletContext context = request.getServletContext();
		// 	String realPath = context.getRealPath(uploadPath);
		//	위의 두문장을 합친게 하단에 한줄
			String realPath = request.getServletContext().getRealPath(uploadPath);
		// 	System.out.println(realPath); 경로 확인
		
		
		// java.io.File 클래스를 사용하여 파일이 존재할 경우 해당 파일 삭제
		// 1. File 객체 생성(생성자 파라미터로 파일 경로 및 파일명 전달)
		File f = new File(realPath, realFile);
		
		// 2. 지정된 경로의 파일이 존재하는지 여부 판별
		if(f.exists()){	// exists() 메서드 리턴값이 true이면 해당 파일이 존재한다는 의미
			// 3. 해당 파일 삭제 
			boolean isDeleteSuccess = f.delete();
			// 파일삭제확인해보려면
// 			System.out.println("파일 삭제 결과 : " + isDeleteSuccess);
			
			
		}		
		
		response.sendRedirect("myarchive.jsp");
	} else {
		%>
		<script>
			alert("글삭제 실패!");
			history.back();
		</script>
		<%
	}

%>