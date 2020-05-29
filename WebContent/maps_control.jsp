<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="db" class="covidLocator.model.CovidBean"/>
<jsp:useBean id="user" class="covidLocator.model.CovidUser"/>
<jsp:setProperty name="user" property="*"/>

<% 
request.setCharacterEncoding("UTF-8");
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
  ArrayList<CovidPost> posts = db.getPost(location);
  request.setAttribute("areas",areas);
  request.setAttribute("posts",posts);
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
else if(action.equals("postview")){
	   String location = request.getParameter("location"); 
	   String postId = request.getParameter("id");
	   if(db.insertView(Integer.parseInt(postId))){
	   CovidPost post = db.getPostDetail(Integer.parseInt(postId));
	   request.setAttribute("areas",areas);
	   request.setAttribute("post",post);
	   pageContext.forward("postview_page.jsp?location="+location +"&page=" + postId);
	   }
}
else if(action.equals("postwrite")){
	 String location = request.getParameter("location"); 
	   request.setAttribute("areas",areas);
	   pageContext.forward("postWrite.jsp?location="+location);
}
else if(action.equals("login")){
	String email = request.getParameter("email");
	String pass = request.getParameter("password");
	CovidUser myProfile = db.getUser(email,pass);
	if(myProfile.getUser_id() != 0)
	{
		session.setAttribute("me",myProfile);
	    response.sendRedirect("index.jsp");
	}else{
		response.sendRedirect("login.jsp");
	}
}
else if(action.equals("submit_p")){
	 String location = request.getParameter("location"); 
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	Object chk_user = session.getAttribute("me");
	if(chk_user ==null)
		out.println("message : login plz");
	else{
		CovidUser me = (CovidUser)chk_user;
		CovidPost covidPost = new CovidPost();
		covidPost.setPost_user(me.getUser_id());
		covidPost.setPost_title(title);
		covidPost.setPost_content(content);
		if(db.insertPost(covidPost,location))
		{
			  ArrayList<CovidPost> posts = db.getPost(location);
			  request.setAttribute("areas",areas);
			  request.setAttribute("posts",posts);
			  pageContext.forward("community.jsp?location="+location);
		}else{
			  ArrayList<CovidPost> posts = db.getPost(location);
			  request.setAttribute("areas",areas);
			  request.setAttribute("posts",posts);
			  pageContext.forward("community.jsp?location="+location);
		}
	}
	
}
else if(action.equals("delete_p")){
	 String location = request.getParameter("location"); 
	 String postId = request.getParameter("id");
	 if(db.delPost(Integer.parseInt(postId))){
		  ArrayList<CovidPost> posts = db.getPost(location);
		  request.setAttribute("areas",areas);
		  request.setAttribute("posts",posts);
		  pageContext.forward("community.jsp?location="+location);
	 }else
	 {
		  ArrayList<CovidPost> posts = db.getPost(location);
		  request.setAttribute("areas",areas);
		  request.setAttribute("posts",posts);
		  pageContext.forward("community.jsp?location="+location);
	 }
}
else if(action.equals("submit_a")){
	 String location = request.getParameter("location"); 
		String title = request.getParameter("message");
		String select = request.getParameter("select");
		Object chk_user = session.getAttribute("me");
		if(chk_user ==null)
			out.println("message : login plz");
		else{
			CovidUser me = (CovidUser)chk_user;
			CovidAlert covidAlert = new CovidAlert();
			covidAlert.setAlert_chk(select);
			covidAlert.setAlert_title(title);
		
			if(db.insertAlert(covidAlert,location))
			{
				 ArrayList<CovidAlert> alerts = db.getAlert(location);
				 request.setAttribute("areas",areas);
				 request.setAttribute("alerts", alerts);
				 pageContext.forward("alert.jsp?location="+location);
			}else{
				 ArrayList<CovidAlert> alerts = db.getAlert(location);
				 request.setAttribute("areas",areas);
				 request.setAttribute("alerts", alerts);
				 pageContext.forward("alert.jsp?location="+location);
			}
		}
		
}
else if(action.equals("delete_a")){
	 String location = request.getParameter("location"); 
	 String alertId = request.getParameter("id");
	 if(db.delAlert(Integer.parseInt(alertId))){
		 ArrayList<CovidAlert> alerts = db.getAlert(location);
		 request.setAttribute("areas",areas);
		 request.setAttribute("alerts", alerts);
		 pageContext.forward("alert.jsp?location="+location);
	 }else
	 {
		 ArrayList<CovidAlert> alerts = db.getAlert(location);
		 request.setAttribute("areas",areas);
		 request.setAttribute("alerts", alerts);
		 pageContext.forward("alert.jsp?location="+location);
	 }
}
else if(action.equals("logout")){
	session.invalidate();
	response.sendRedirect("index.jsp");
}

%>