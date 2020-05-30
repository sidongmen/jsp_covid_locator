<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%
  request.setCharacterEncoding("UTF-8");
   String value = request.getParameter("location");
   %>
      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <jsp:include page="menubar.jsp">
          <jsp:param name="select" value="<%=value%>"/>
        </jsp:include>
     <div class="container">
      <h1  class="m-3"> 웹프로그래밍 및 응용 텀 프로젝트(Term Project) - 중간</h1>
       <p class="m-3" style="text-align:right;"> 개발자 : 홍성찬(192viva@gmail.com)</p>
       <hr>
       <h2 class="m-3">몇몇 기능은 관리자 권한이 있는 사용자만 가능합니다.</h2>
       <h3 class="m-3">관리자 아이디 :admin / 비밀번호 : admin</h3>
       <hr>
        <p>중간 텀 까지의 기능을 구현하였습니다.</p>
        <p>구현한 내용은 다음과 같습니다.</p>
        <li>지역 맵 보여주기</li>
         <ul>
            <li>다음 kakao 맵 API를 사용하였음</li>
         </ul>
        <li>커뮤니티 기능</li>
         <ul>
            <li>게시물 CRUD 구현</li>
            <li>페이징(Pagination) 기능 구현</li>
         </ul>
        <li>지역별 긴급 알림 확인</li>
            <ul>
            <li>긴급 알림 CRUD 구현</li>
            <li>관리자 권한의 사용자 식별 후 CRUD 권한</li>
         </ul>
        <li>지역별 확진자 상세보기</li>
                    <ul>
            <li>확진자 CRUD 구현</li>
            <li>관리자 권한의 사용자 식별 후 CRUD 권한</li>
         </ul>
         <hr>
     </div>
</body>
</html>