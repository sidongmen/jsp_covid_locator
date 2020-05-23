<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*" 
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
          
          			<%
				for(CovidAlert  alert : (ArrayList<CovidAlert>) alerts) {
					String []chk = alert.getAlert_chk().split("/");
			%>
			<li class="list-group-item d-flex justify-content-between align-items-center">
            <%=alert.getAlert_title()%> <%=alert.getAlert_date()%>
              <%
               if(chk[0].equals("0")){
              %>
              <span class="badge badge-primary"><%=chk[1] %></span>
			    <%
               } else if(chk[0].equals("1")){
            	   %>
            	    <span class="badge badge-danger"><%=chk[1] %></span>
            	   <%
               } else if(chk[0].equals("2")){
            	   %>
            	     <span class="badge badge-warning"><%=chk[1] %></span>
            	   <%
               }
			    }
			    %>
			 </li>
          </ul>
        </div>
      </div>
    </div>
</body>
</html>