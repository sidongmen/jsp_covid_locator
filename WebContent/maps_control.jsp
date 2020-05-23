<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="db" class="covidLocator.model.CovidBean"/>
<jsp:useBean id="user" class="covidLocator.model.CovidUser"/>
<jsp:setProperty name="user" property="*"/>

<% 
String action = request.getParameter("action"); 

ArrayList<CovidArea> areas = db.getArea();

if(action.equals("map")){
String location = request.getParameter("location"); 
Double x = Double.parseDouble(request.getParameter("x"));
Double y = Double.parseDouble(request.getParameter("y"));
CovidUser coviduser = db.getUser();

request.setAttribute("users",coviduser);

request.setAttribute("datas", coviduser);

request.setAttribute("areas",areas);
pageContext.forward("maps.jsp?location="+location+"&x="+x+"&y="+y);
}
else if(action.equals("community")){
  String location = request.getParameter("location"); 
  request.setAttribute("areas",areas);
  pageContext.forward("community.jsp?location="+location);
}else if(action.equals("infected")){
	 String location = request.getParameter("location"); 
	  request.setAttribute("areas",areas);
	  pageContext.forward("infected_page.jsp?location="+location);
}else if(action.equals("alert")){
	 String location = request.getParameter("location"); 
	  request.setAttribute("areas",areas);
	  pageContext.forward("alert.jsp?location="+location);
}else if(action.equals("info")){
	 String location = request.getParameter("location"); 
	  request.setAttribute("areas",areas);
	  pageContext.forward("info.jsp?location="+location);
}

%>