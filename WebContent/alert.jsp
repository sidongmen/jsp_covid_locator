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
      <div class="row">
        <div class="col-12">
          <div class="m-4">
          <h1> <%=value%>지역 알림 <i class="far fa-bell"></i></h1>
          </div>
          <ul class="list-group">
            <li class="list-group-item d-flex justify-content-between align-items-center">
            바깥 외출 자제, 불가피한 외출 시 마스크 반드시 착용
              <span class="badge badge-primary">New</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
              재난지원금 신청 6/3일까지 꼭 신청하세요!
              <span class="badge badge-danger">긴급</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
               이태원 사태 기간 동안 방문자 자진 신고
              <span class="badge badge-warning">20</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
</body>
</html>