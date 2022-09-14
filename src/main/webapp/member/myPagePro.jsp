
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	 request.setCharacterEncoding("UTF-8");
 
 	String id = (String)session.getAttribute("sId");
 	
	if(id == null){
		%>
		<script>
			alert("잘못된 접근입니다!");
			history.back();
		</script>
		
	<% 
	}
 
	
	String pass = request.getParameter("pass");
	
	
	MemberDAO dao = new MemberDAO();
	MemberDTO member = dao.selectMember(id,pass);
	
	
%>       
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<script>

	var isOkayPassword = false;
	var isSamePassword = false;

	// radio버튼 불러오는 함수
	// window.onload 없으면 로딩이 다 되기도 전에 불러와져서 값이없는상태로 실행되버림.
	window.onload = function (){
		var camera = '<%=member.getCamera()%>';
		document.getElementById(camera).checked = true;
	};
	

	function keyCheck(pass){ // 비밀번호 사용확인
		
		var LengthChk = document.getElementById("checkPasswdResult");
		keyCheck2(document.fr.pass2.value);
	
		if(pass.length >= 8 && pass.length <= 16){
			LengthChk.innerHTML = "사용 가능한 패스워드";
			LengthChk.style.color = "BLUE";
			isOkayPassword = true;
		}else if(pass.length ==0 || pass == null) { //지워도 글자 계속떠있는거 거슬려서넣음..
				LengthChk.innerHTML = "";
		}else {
			LengthChk.innerHTML = "사용 불가능한 패스워드";
			LengthChk.style.color = "RED";
			isOkayPassword = false;
		}
	
	
	}
	
	function keyCheck2(pass2){ // 비밀번호 일치여부 확인
		
		
		var spanLeng = document.getElementById("checkPasswd2Result");
			
			if(pass2 == document.fr.pass.value && pass2.length != 0){
				spanLeng.innerHTML = "비밀번호 일치";
				spanLeng.style.color = "BLUE";
				isSamePassword = true;
			}else if(pass2.length ==0 || pass2 == null) { //지워도 글자 계속떠있는거 거슬려서넣음..
				spanLeng.innerHTML = "";
			
			}else {
				spanLeng.innerHTML = "비밀번호 불일치";
				spanLeng.style.color = "RED";
				isSamePassword = false;
			}
		
		
	}
	
	function mailSelect(select){ // 이메일뒷주소기능
		
		document.fr.email2.value = select;
		document.fr.email2.focus(); 
	
	}

	
	function check_Whole(fr){ // 마지막검사 
		
	
		if (!isOkayPassword){ //isSamePassword == false
			 alert("패스워드 4 ~ 8자리 필수!");
			 fr.pass.select();
			return false;
			
		}else if (!isSamePassword){ //isSamePassword == false
			 alert("패스워드가 일치하지 않습니다!");
			 fr.pass2.select();
			return false;
		// 나중에 이메일 분리해서 하면 이렇게쓰기. ~~~~~~~~~~~
		 }else if (fr.email1.value == ""){
			 alert("이메일이 제대로 입력되지 않았습니다!");
			 fr.email1.select();
			 return false;	 
			 
		 }else if (fr.email2.value == ""){
			 alert("이메일이 제대로 입력되지 않았습니다!");
			 fr.email2.select();
			 return false;	 
			 
		 }else {
			 return true;
		 }
	}
	

</script>
<!-- ======================================다음 주소 API를 위한 곳 ========================================= -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
               

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // => 간단하게 도로명 주소를 무조건 사용
                document.getElementById('post_code').value = data.zonecode;		// 우편번호
                document.getElementById("address1").value = data.roadAddress;	// 도로명주소
                
                document.getElementById("address2").focus();		
                
               
            }
        }).open();
    }
</script>
</head>
<body>
<!-- 	<div id="wrap"> -->
	<div>
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
	  		<ul>
				<li><a href="../member/myPage.jsp">My Page</a></li>
		  		<li><a href="../member/deleteMyAccount.jsp">Delete Account</a></li>
		  	</ul>
		 </nav>	
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>My Page</h1>
		  	<form action="myPageProFinal.jsp" method="post" id="join" name="fr" class="joinform" onsubmit="return check_Whole(this)">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label><span>Id</span></label>
		  			<input type="text" name="id" value="<%=id%>"class="id" id="id" readonly="readonly"><br>
		  			
		  			
		  			<label><span>Password</span></label>
		  			<input type="password" name="pass" id="pass" onchange="keyCheck(this.value)" placeholder="8 ~ 16글자 사이 입력" required="required">
		  			<span id="checkPasswdResult"></span>
		  			<br> 			
		  			
		  			<label><span>Retype Password</span></label>
		  			<input type="password" name="pass2" onchange="keyCheck2(this.value)" required="required">
		  			<span id="checkPasswd2Result"></span>
		  			<br>
		  			
		  			<label><span>Name</span></label>
		  			<input type="text" name="name" id="name" value="<%=member.getName()%>" required="required"><br>
		  			
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile"  value="<%=member.getMobile()%>" placeholder="'-'제외한 번호만 입력" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="text" name="email1" id="email" value="<%=member.getEmail1()%>" required="required"> @ 
		  			<input type="text" name="email2" value="<%=member.getEmail2()%>" required="required">
		  				<select name="emailselec" onchange="mailSelect(this.value)">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
					</select>
		  			<br>
					<br>
					
		  			<label>Used Camera</label>
					<label for="film"><input type="radio" name="camera" id="film" value="film" > Film Camera</label> 
					<label for="digital"><input type="radio" name="camera" id="digital" value="digital" > Digital Camera</label>
					<label for="both"><input type="radio" name="camera" id="both" value="both" > Both</label>
					<br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Post Code</label>
		  			<input type="text" name="post_code" id="post_code" placeholder="우편번호" readonly="readonly" value="<%=member.getPost_code()%>"> 
		  			<input type="button" value="주소검색" onclick="execDaumPostcode()"><br>
		  			<label>Address</label>
		  			<input type="text" name="address1" id="address1" value="<%=member.getAddress1()%>"> 
		  			<input type="text" name="address2" id="address2" value="<%=member.getAddress2()%>"><br>
		  			<label>Phone Number</label>
		  			<input type="text" name="phone"  value="<%=member.getPhone()%>"><br>
		  			
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Update" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  </div>
		  
		<div class="clear">
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>

