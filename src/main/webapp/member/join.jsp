<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Us</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

	var isCheckId = true;	
	var isOkayPassword = false;	// 패스워드 사용여부(true:사용가능/false:사용불가능)
	var isSamePassword = false; // 패스워드 일치여부(true:일치/false:불일치)
	
	function checkId() {
		
		isCheckId = false;
		// check_id.jsp 페이지를 새 창으로 열기(가로 : 400, 세로 : 200)
		window.open("check_id.jsp", "ID중복확인", "width=400,height=200");
		
		
	}
	
		

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
	
	// 번호입력시 -입력하면 alert띄우는 기능
	function numberCheck(num){
		
		if(num.includes('-')){
			alert("'-' 제외한 숫자만 입력해주세요");
			document.fr.mobile.focus();
		}
		
	}
	
	
	
	
	function mailSelect(select){ // 이메일뒷주소기능
		
		document.fr.email2.value = select;
		document.fr.email2.focus(); 
	
}
	
	
	function check_Whole(fr){ // 마지막검사 
		
		 
		if(isCheckId) {
			 alert("아이디 확인 필수!");
			 fr.id.select();
			 return false;
	
		}else if (!isOkayPassword){ //isSamePassword == false
			 alert("패스워드 4 ~ 8자리 필수!")
			 fr.pass.select();
			return false;
			
		}else if (!isSamePassword){ //isSamePassword == false
			 alert("패스워드가 일치하지 않습니다!")
			 fr.pass2.select();
			return false;
		// 나중에 이메일 분리해서 하면 이렇게쓰기. ~~~~~~~~~~~
		 }else if (fr.email1.value == ""){
			 alert("이메일이 제대로 입력되지 않았습니다!")
			 fr.email1.select();
			 return false;	 
			 
		 }else if (fr.email2.value == ""){
			 alert("이메일이 제대로 입력되지 않았습니다!")
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
		  <jsp:include page="../inc/left.jsp"></jsp:include>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" class="joinform" onsubmit="return checkForm()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>Id</label>
		  			<input type="text" name="id" class="id" id="id" placeholder="중복확인 클릭" readonly="readonly" required="required">
		  			<input type="button" value="dup. check" class="dup" id="btn" onclick="checkId()" >
		  			<span id="checkId"></span>
		  			<br>
		  			
		  			
		  			<label><span>Password</span></label>
		  			<input type="password" name="pass" id="pass" onchange="keyCheck(this.value)" placeholder="8 ~ 16글자 사이 입력" required="required">
		  			<span id="checkPasswdResult"></span>
		  			<br> 			
		  			
		  			<label><span>Retype Password</span></label>
		  			<input type="password" name="pass2" onchange="keyCheck2(this.value)" placeholder="비밀번호 확인" required="required">
		  			<span id="checkPasswd2Result"></span>
		  			<br>
		  			
		  			<label><span>Name</span></label>
		  			<input type="text" name="name" id="name"><br>
		  			
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" id="mobile" placeholder="'-'제외한 번호만 입력" required="required" onkeyup="numberCheck(this.value)"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="text" name="email1" id="email"> @ 
		  			<input type="text" name="email2">
		  				<select name="emailselec" onchange="mailSelect(this.value)">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
					</select>
					<br>
					
		  			
		  			<label>Used Camera</label>
		  			<label for="f"><input type="radio" name="camera" value="film" id="f"> Film </label>
					<label for="d"><input type="radio" name="camera" value="digital" id="d"> Digital </label>
					<label for="b"><input type="radio" name="camera" value="both" id="b"> Both </label><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Post Code</label>
		  			<input type="text" name="post_code" id="post_code" placeholder="우편번호" readonly="readonly">  
		  			<input type="button" value="주소검색" onclick="execDaumPostcode()"><br>
		  			<label>Address</label>
		  			<input type="text" name="address1"  id="address1" placeholder="기본주소"> 
		  			<input type="text" name="address2"  id="address2" placeholder="상세주소"><br>
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" ><br>
		  			
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
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


