<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*" 
    pageEncoding="UTF-8"%>
    
  <%
  request.setCharacterEncoding("UTF-8");
   String value = request.getParameter("location");
   %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>커뮤니티</title>
</head>
<body>
        <jsp:include page="menubar.jsp">
          <jsp:param name="select" value="<%=value%>"/>
        </jsp:include>
    <div class="container">
     <div class="m-4">
          <h1>커뮤니티 in <%=value%></h1>
          </div>
     <table class="table table-striped">
      <thead>
       <tr>
          <th>번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>날짜</th>
          <th>조회수</th>
       </tr>
      </thead>
      <tbody>
        <tr>
           <td>2</td>
           <td><a href="postview_page.jsp?location=<%=value%>">가나다라마바사</a></td>
           <td>홍길동</td>
           <td>2020.05.21</td>
           <td>1</td>
        </tr>
       <tr>
           <td>1</td>
           <td><a href="postview_page.jsp?location=<%=value%>">동해물과 백두산이 마르고</a></td>
           <td>홍길동</td>
           <td>2020.05.21</td>
           <td>1</td>
        </tr>
      </tbody>
     </table>
 <a class="btn btn-light float-right mr-3">글쓰기</a>
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <li class="page-item"><a class="page-link" href="#">다음</a></li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">이전</a></li>
  </ul>
</nav>
     </div>
</body>
</html>