<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*, java.text.*" 
    pageEncoding="UTF-8"%>
    
  <%
  request.setCharacterEncoding("UTF-8");
   String value = request.getParameter("location");
   %>
  <jsp:useBean id="posts" scope="request" class="java.util.ArrayList" /> 
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
      
      	<%
				for(CovidPost post : (ArrayList<CovidPost>) posts) {
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
			        SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
			        Date dday = sf.parse(post.getPost_date());
			        String days = fm.format(dday);
				%>
			 <tr>
           <td><%=post.getPost_id()%></td>
           <td><a href="maps_control.jsp?action=postview&location=<%=value%>&id=<%=post.getPost_id()%>"><%=post.getPost_title()%></a></td>
           <td><%=post.getPost_nickname()%></td>
           <td><%=days%></td>
           <td><%=post.getPost_view()%></td>
                 </tr>
				
			    <%}%>
      </tbody>
     </table>
     <%
     if(session.getAttribute("me")!= null) {
    	 %>
 <a class="btn btn-light float-right mr-3"href="maps_control.jsp?action=postwrite&location=<%=value%>">글쓰기</a>
   <%}%>
    
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