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

request.setAttribute("areas",areas);
pageContext.forward("maps.jsp?location="+location+"&x="+x+"&y="+y);
}
else if(action.equals("community"))
{
  String location = request.getParameter("location"); 
  request.setAttribute("areas",areas);
  pageContext.forward("community.jsp?location="+location);
}
else if(action.equals("infected")) //지역별 확진자 이동경로
{
	 String location = request.getParameter("location");
	 ArrayList<CovidPatient> patients = db.getPatient(location);
	 request.setAttribute("areas",areas);
	 request.setAttribute("patients",patients);
	 pageContext.forward("infected_page.jsp?location="+location);
}
else if(action.equals("alert"))
{
	 String location = request.getParameter("location"); 
	 ArrayList<CovidAlert> alerts = db.getAlert(location);
	 request.setAttribute("areas",areas);
	 request.setAttribute("alerts", alerts);
	 pageContext.forward("alert.jsp?location="+location);
}
else if(action.equals("info"))
{
	 String location = request.getParameter("location"); 
	  request.setAttribute("areas",areas);
	  pageContext.forward("info.jsp?location="+location);
}
else if(action.equals("login")){
	String email = request.getParameter("email");
	String pass = request.getParameter("password");
	boolean chk = db.getUser(email,pass);
	if(chk==true)
	{
		session.setAttribute("id",email);
	    response.sendRedirect("index.jsp");
	}else{
		response.sendRedirect("login.jsp");
	}
}
else if(action.equals("logout")){
	session.invalidate();
	response.sendRedirect("index.jsp");
}

%>