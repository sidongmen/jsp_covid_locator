<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*, java.text.*" 
    pageEncoding="UTF-8"%>
    
  <%
  request.setCharacterEncoding("UTF-8");
   String value = request.getParameter("location");
   %>
 <jsp:useBean id="alerts" scope="request" class="java.util.ArrayList" /> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=value%>지역 알림</title>
</head>
<body>

        <jsp:include page="menubar.jsp">
          <jsp:param name="select" value="<%=value%>"/>
        </jsp:include>
 <div class="container">
      <div class="row">
        <div class="col-12">
          <div class="d-flex justify-content-between align-items-center m-4">
          <h1> <%=value%>지역 알림 <i class="far fa-bell"></i></h1>
             <%
          if(session.getAttribute("me") != null) {
        	  CovidUser me = (CovidUser)session.getAttribute("me");
        	  if (me.getUser_role() == 1){
    	    %>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Modal" data-whatever="@mdo">알림 추가</button>
          <% }
        	  }%>
          </div>
          <ul class="list-group">
          
          			<%
				for(CovidAlert  alert : (ArrayList<CovidAlert>) alerts) {
					String chk = alert.getAlert_chk();
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
			        SimpleDateFormat fm = new SimpleDateFormat("MM/dd");
			        Date dday = sf.parse(alert.getAlert_date());
			        String days = fm.format(dday);
			          
			%>
			<li class="list-group-item d-flex justify-content-between align-items-center">
            <div>
            <%=alert.getAlert_title()%> <a class="badge badge-light"><%=days%></a>
            </div>
            <div>
              <%
               if(chk.equals("new")){
              %>
              <span class="badge badge-primary"><%=chk %></span>
			    <%
               } else if(chk.equals("긴급")){
            	   %>
            	    <span class="badge badge-danger"><%=chk %></span>
            	   <%
               } else if(chk.equals("주의")){
            	   %>
            	     <span class="badge badge-warning"><%=chk %></span>
            	   <%
               }
              %>
              <%
               if(session.getAttribute("me") != null) {
        	  CovidUser me = (CovidUser)session.getAttribute("me");
        	  if (me.getUser_role() == 1){
    	    %>
             <a class="btn btn-danger m-4" href="maps_control.jsp?action=delete_a&location=<%=value%>&id=<%=alert.getAlert_id()%>">
              삭제
             </a>
             <%
        	  }
               }
             %>
               </div>
               <%
			    }
			    %>
			    
			 </li>
          </ul>
        </div>
      </div>
    </div>
    <!-- Modal -->

    <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><%=value%>지역 알림 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form method="post" action="maps_control.jsp?action=submit_a&location=<%=value%>">
      <div class="modal-body">
          <div class="form-group">
    <label for="exampleFormControlSelect1">분류</label>
    <select class="form-control" name="select">
      <option>new</option>
      <option>긴급</option>
      <option>주의</option>
    </select>
  </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">메세지:</label>
            <textarea class="form-control" name="message"></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary">추가 완료</button>
      </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>