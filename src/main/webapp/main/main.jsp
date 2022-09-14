<%@page import="board.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.ArchiveDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.ArchiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>the Film Archive</title>
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/reset.css" rel="stylesheet">
<link href="../css/mineHomeClick.css" rel="stylesheet" type="text/css">
<link href="../css/default4home.css" rel="stylesheet" type="text/css">
<script>
var a;
function show_hide(){
	
	if(a==1){
		document.getElementById("photolist").style.display="none";
		return a=0;
	} else {
		document.getElementById("photolist").style.display="flex";
		return a=1;
	}
	
}
var b;
function show_hide2(){
	
	if(b==1){
		document.getElementById("photolist2").style.display="flex";
		return b=0;
	} else {
		document.getElementById("photolist2").style.display="none";
		return b=1;
	}
	
}



</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<!-- inc/top.jsp 페이지 포함시키기-->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
<!-- 		<div id=mid_hr><hr></div> -->
  		<div class="clear"></div>   
  
    	<!-- 본문 -->
    
    		<section class="scene one">
				<header>
					<h1>Make the film-Archive on your own.</h1>
					With Film cameras, or digital cameras, or even cell phones.<br>
					Anything could be uploaded if you want, whenever you want!
				</header>    		
    		</section>
    		
    		
    		<section class="scene two">
				<header>
					<h1>The Highest Hits</h1>
					 The highest hits of photos ,top-3 at this moment.<br><br>
				<button class="btn btn-4 btn-4c icon-arrow-right" onclick="show_hide()">
				Check!</button>
				</header>
				<%--사진카드 넣어볼부분 --%>
				
				<div id="photolist">
					
					      
		      	<% 
		      	
		      	ArchiveDAO dao = new ArchiveDAO();
		      	ReplyDAO replyDAO = new ReplyDAO();
		      	
		      	ArrayList<ArchiveDTO> archiveTopList = dao.selectTopHitsList();
		      	
		      	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		      	
		      	for(ArchiveDTO archive : archiveTopList ){
		      		int refNum = archive.getNum();
					String boardType = "archive";
					int replyCount = replyDAO.replyCount(refNum,boardType);
		      	%>
						<div class="container">
					    <div class="row">
					    <%-- 1개씩 반복되는 사진카드 출력  --%>	
					      <div class="card_container">
					        <div class="cd"><a href="../archive/community_content.jsp?num=<%=archive.getNum()%>">
					         <img src="../film/<%=archive.getOriginal_file()%>" class="img-thumnail">
					         	<p id="text_pt">
					         	<i></i>No.<%=archive.getNum() %><br> 
					         	<i></i>조회수 <%=archive.getReadcount() %><br>
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
				<%} %>
					<div class="close"><img src="../images/undo_icon.png" width="40px" onclick="show_hide()"></div> 	
					</div>		
						
    		</section>
    		<%--사진카드 넣어볼부분 --%>
    		
    		
    		<section class="scene three">
				<header>
					<h1>Recent Upload Film</h1>
					This space is filled with hot-debut films that have just been uploaded.<br>
					You sholud try start uploading right now :) <br><br>
				<button class="btn btn-4 btn-4c icon-arrow-right" onclick="show_hide2()">
				Check!</button>    		
				</header>
    		
    		
    		
    		<div id="photolist2">
			
					      
		      	<% 
		      	
		      	ArchiveDAO dao2 = new ArchiveDAO();
		      	ReplyDAO replyDAO2 = new ReplyDAO();
		      	ArrayList<ArchiveDTO> archiveRecentList = dao2.selectRecentList();
		      	for(ArchiveDTO archive2 : archiveRecentList ){
			      	
		      		int refNum = archive2.getNum();
					String boardType = "archive";
					int replyCount = replyDAO2.replyCount(refNum,boardType);
		      	
		      	%>
						<div class="container">
					    <div class="row">
					    <%-- 1개씩 반복되는 사진카드 출력  --%>	
					      <div class="card_container">
					        <div class="cd"><a href="../archive/community_content.jsp?num=<%=archive2.getNum()%>">
					         <img src="../film/<%=archive2.getOriginal_file()%>" class="img-thumnail">
					         	<p id="text_pt">
					         	<i></i>No.<%=archive2.getNum() %><br> 
					         	<i></i>조회수 <%=archive2.getReadcount() %><br>
					         	<i></i><%=sdf.format(archive2.getDate())%><br>
					         	<%if(replyCount > 0){%>
								<i></i>댓글(<%=replyCount %>)
								<%}%>
					     		</p>
					         </div>
					         		<div class="card_header">
					            		<h1><%=archive2.getSubject() %></h1>
					            	</div>
						            <div class="card_body">
							            <i></i> <div id="name"><%=archive2.getName() %></div>
						          </div>
					          </a>
					          
					      </div>
					    </div>
					  </div>
				<%} %>
				<div class="close"><img src="../images/undo_icon.png" width="40px" onclick="show_hide2()"></div> 
					</div>		
         
		</section>


		<div class="clear"></div>
	 	<!-- 푸터 들어가는곳 -->
	  	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	  	<!-- 푸터 들어가는곳 -->
		
	</div>
</body>
</html>
