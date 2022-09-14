<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ContactUs</title>
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<style>
	
	.map{
		margin-right: 0px;	
	}
	
	#contactus{
		column-count: 2;
	}	
</style>
<body>

		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
	 
		  <!-- 왼쪽 메뉴 -->
		  <jsp:include page="../inc/left.jsp"></jsp:include>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Office Location</h1>
		  <div id="contactus">
			<!-- 지도첨부자리 -->
		 	 <div id="map" style="width:400px;height:350px;"></div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=850308fe2ddf7fe2474f5a34100db1e6&libraries=services"></script>
				<script>
					var container = document.getElementById('map');
					var options = {
						center: new kakao.maps.LatLng(35.1584043, 129.0620349),
						level: 4
						};
					// 지도 생성
					var map = new kakao.maps.Map(container, options);
					
					// 주소-좌표 변환 객체 생성
					var geocoder = new kakao.maps.services.Geocoder();
					// 주소로 원하는 지정 좌표검색
					geocoder.addressSearch('부산 부산진구 동천로 109', function(result, status) {
					
						// 정상적으로 검색이 완료시 
					     if (status === kakao.maps.services.Status.OK) {
		
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
					        // 결과값으로 받은 위치를 마커로 표시
					        var marker = new kakao.maps.Marker({
					            map: map,
					            position: coords
					        });
		
					        // 인포윈도우로 장소에 대한 설명을 표시
					        var infowindow = new kakao.maps.InfoWindow({
					            content: '<div style="width:150px;text-align:center;padding:6px 0;">필름아카이브</div>'
					        });
					        infowindow.open(map, marker);
							
					        // 지도의 중심을 결과값으로 받은 위치로 이동
					        map.setCenter(coords);
					    } 
					});    
			</script>
			
			
				<div>
				<h2>[ 필름아카이브 ]</h2><br>
				<p>
				* 오프라인 팝업매장 영업 안내 *
				</p>
				<p>
				- 컬러 / 흑백 필름사진 인화<br>
				- 컬러 / 흑백 필름 판매<br>
				- 엽서 / 포토북 제작<br>
				- 중고 필름카메라 판매 , 수리 <br>
				</p>
				<p>
				<br>
				* 영업시간 *<br>
				<br>
				</p>
				<p>
				연중무휴<br>
				오전 10:00 - 오후 08:00<br>
				<br>
				부산광역시 부산진구 부전동 동천로 109 ,삼한골든게이트 1층<br> 
				051-123-5959
				</p>
				 </div>
			</div>
			</article>
			
		
		  <%-- 이메일api 나중에 더배워서 넣어보기 --%>
<!-- 		  	<h1>Contact Us</h1> -->
<!-- 		  	<div class="mailingbox"> -->
<!-- 		  	<form action="contactPro.jsp" method="post" id="mypage" name="fr" class="mailform"> -->
<!-- 		  			<table> -->
<!-- 		  			<tr> -->
<!-- 		  				<th>To</th> -->
<!-- 		  				<td><input type="text" name="name" id="name" value="ziroground@naver.com" readonly="readonly"></td><br> -->
<!-- 		  			</tr> -->
<!-- 		  			<tr> -->
<!-- 		  				<th>From</th> -->
<!-- 		  				<td><input type="email" name="email" id="email" placeholder="이메일을 입력하세요." required="required"></td><br> -->
<!-- 		  			</tr> -->
<!-- 		  			<tr> -->
<!-- 		  				<th>Your Name</th> -->
<!-- 		  				<td><input type="text" name="name" id="name" required="required"></td><br> -->
<!-- 		  			</tr> -->
<!-- 		  			<tr> -->
<!-- 		  				<th>Subject</th> -->
<!-- 		  				<td><input type="text" name="name" id="name" required="required"></td><br> -->
<!-- 		  			</tr> -->
<!-- 		  			<tr> -->
<!-- 		  				<th>Content</th> -->
<!-- 		  				<td><textarea rows="10" cols="22" name="content" required="required"></textarea></td><br> -->
<!-- 		  			<tr> -->
<!-- 		  				<td></td> -->
<!-- 			  			<td colspan="2"> -->
<!-- 			  			<input type="submit" value="Send" class="submit" > -->
<!-- 			  			<input type="reset" value="Cancel" class="cancel"> -->
<!-- 			  			</td> -->
<!-- 			  		</tr>	 -->
<!-- 			  		</table> -->
<!-- 			  	</form> -->
<!-- 			  		</div> -->
<!-- 			  </div>	 -->
<!-- 		  </article> -->
	
		  
		<div class="clear">
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
		</div>
</body>
</html>

</body>
</html>