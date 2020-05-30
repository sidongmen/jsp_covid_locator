<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="covidLocator.model.*, java.util.*"  pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<jsp:useBean id="areas" scope="request" class="java.util.ArrayList" />

<%
String location = request.getParameter("location");
%>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="javascript:history.back();">
    <i class="fas fa-search-location"></i> 코로나 로케이터 version 1.0.1
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
    data-target="#navbarSupportedContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
     <ul class="navbar-nav ml-auto">
       <li class="nav-item active">
        <a class="btn btn-danger mr-2" href="maps_control.jsp?action=alert&location=<%=location%>">알림 <i class="fas fa-bell"></i></a>
        </li>
        <li class="nav-item active">
        <a class="btn btn-warning mr-2" href="maps_control.jsp?action=community&location=<%=location%>">커뮤니티 <i class="far fa-comment"></i></a>
        </li>
        <li class="nav-item active">
         <a class="btn btn-light mr-2" href="maps_control.jsp?action=infected&location=<%=location%>"><i class="fas fa-info-circle"></i> 확진자 정보</a>
         </li>
        <li class="nav-item dropdown">
           <a class="nav-link dropdown-toggle mr-2" href="#" id="navbarDropdown"
            role="button" data-toggle="dropdown"><%=location%></a>
            
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			<%
				for(CovidArea  area : (ArrayList<CovidArea>) areas) {
					String x = Double.toString(area.getArea_x());
					String y = Double.toString(area.getArea_y());
					if(area.getArea_id()!=1){
			%>
			    <div class="dropdown-divider"></div>
			    <% 
			    }
			    %>
			<a class="dropdown-item" style="display:inline;" href="maps_control.jsp?action=map&location=<%=area.getArea_name()%>&x=<%=area.getArea_x()%>&y=<%=area.getArea_y()%>"><%=area.getArea_name()%></a>
               <% if (location.equals(area.getArea_name())){
               %>
               <span style="color:#7bc143"><i class="fas fa-check"></i></span>
               <%}%>
			 <%
				}
			 %>
		</div>
        </li>
        <li class="nav-item">
           <a class="nav-link mr-2" href="maps_control.jsp?action=info&location=<%=location%>">About</a>
          </li>
     </ul>
     <%if(session.getAttribute("me")==null){ %>
      <a class="btn btn-primary" href="login.jsp">로그인</a>
      <%}else{ %>
      <a class="btn btn-danger" href="maps_control.jsp?action=logout">로그아웃</a>
      <%} %>
  </div>
</nav>