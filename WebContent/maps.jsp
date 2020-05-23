<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="covidLocator.model.*, java.util.*" pageEncoding="UTF-8"%>
    
<%
  request.setCharacterEncoding("UTF-8");
   String location = request.getParameter("location");
   double x = Double.parseDouble(request.getParameter("x"));
   double y = Double.parseDouble(request.getParameter("y"));
   CovidUser coviduser = (CovidUser)request.getAttribute("users");
%>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	
	<link rel="stylesheet" href="CSS/main_styles.css">
	<title>코로나 지도 마커</title>
</head>
<jsp:useBean id="areas" scope="request" class="java.util.ArrayList" />
<body>
        <jsp:include page="menubar.jsp">
          <jsp:param name="select" value="<%=location%>"/>
        </jsp:include>
      <div id="map" style="width:100%;height:90%;"></div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3fce8ace6218ee69cddd86a694b8dc75"></script>
	<script>
	    var x = <%=x%>;
	    var y = <%=y%>;
		var container = document.getElementById('map');
		var options = {
				center: new kakao.maps.LatLng(parseFloat(x), parseFloat(y)),
				level: 8
			};
		var map = new kakao.maps.Map(container, options);

		
	    var markerPostion = new kakao.maps.LatLng(33.450701, 126.570667);
	    
	    var marker = new kakao.maps.Marker({
	    	position: markerPostion
	    });
        
	    var linePath = [
	        new kakao.maps.LatLng(33.452344169439975, 126.56878163224233),
	        new kakao.maps.LatLng(33.45178067090639, 126.5726886938753),
	        new kakao.maps.LatLng(33.452739313807456, 126.5709308145358)
	    ];

	 // 지도에 표시할 선을 생성합니다
	    var polyline = new kakao.maps.Polyline({
	        path: linePath, // 선을 구성하는 좌표배열 입니다
	        strokeWeight: 10, // 선의 두께 입니다
	        strokeColor: '#FF8AEF', // 선의 색깔입니다
	        strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	        strokeStyle: 'solid' // 선의 스타일입니다
	    });

	    // 지도에 선을 표시합니다 
	    polyline.setMap(map); 
	    
		
		 marker.setMap(map);
		 
		 var mapTypeControl = new kakao.maps.MapTypeControl();

		 map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		 var zoomControl = new kakao.maps.ZoomControl();
		 map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		 
		function relayout(){
			map.relayout();
		}
	</script>
</body>
</html>
