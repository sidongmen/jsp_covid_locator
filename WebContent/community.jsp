<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*, java.text.*" 
    pageEncoding="UTF-8"%>
    
  <%
  request.setCharacterEncoding("UTF-8");
   String value = request.getParameter("location");
   String pageAt = request.getParameter("page");
   CovidPaging paging = (CovidPaging)request.getAttribute("page");
   int now = pageAt != null ? Integer.parseInt(pageAt) : 1;
   int prev=1;
   int next=1;
   if (now == paging.getPaging_firstPage()){
	   prev=1;
   }else{
	   prev = now -1;
   }
   
   if (now == paging.getPaging_lastPage()){
	   next = paging.getPaging_lastPage();
   }else{
	   next = now +1;
   }
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
          <th style="width: 15%; text-align:center;">번호</th>
          <th style="width: 50%; text-align:center;">제목</th>
          <th style="width: 10%; text-align:center;">작성자</th>
          <th style="width: 15%; text-align:center;">날짜</th>
          <th style="width: 10%; text-align:center;">조회수</th>
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
           <td style="text-align:center;"><%=post.getPost_id()%></td>
           <td><a href="maps_control.jsp?action=postview&location=<%=value%>&id=<%=post.getPost_id()%>"><%=post.getPost_title()%></a></td>
           <td style="text-align:center;"><%=post.getPost_nickname()%></td>
           <td style="text-align:center;"><%=days%></td>
           <td style="text-align:center;"><%=post.getPost_view()%></td>
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
    <li class="page-item"><a class="page-link" href="maps_control.jsp?action=community&location=<%=value%>&page=<%=prev%>">이전</a></li>
    <%
     for (int i=1; i<=paging.getPaging_lastPage();i++) {
    	 if (now == i) {
    %>
     <li class="page-item active"><a class="page-link" href="maps_control.jsp?action=community&location=<%=value%>&page=<%=i%>"><%=i%></a></li>
    <% }else{%>
    <li class="page-item"><a class="page-link" href="maps_control.jsp?action=community&location=<%=value%>&page=<%=i%>"><%=i%></a></li>
    <%}
    	 } %>
    <li class="page-item"><a class="page-link" href="maps_control.jsp?action=community&location=<%=value%>&page=<%=next%>">다음</a></li>
  </ul>
</nav>
     </div>
</body>
</html>