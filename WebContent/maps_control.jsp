<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="covidLocator.model.*, java.util.*, java.net.URLEncoder" pageEncoding="UTF-8"%>
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
  ArrayList<CovidPost> posts;
  if(request.getParameter("page") != null){
	  int pageAt = Integer.parseInt(request.getParameter("page"));
  posts = db.getPost(location,pageAt);
  }else
  {
 posts = db.getPost(location,1);
  }
  CovidPaging paging = db.pagination(location);
  request.setAttribute("areas",areas);
  request.setAttribute("posts",posts);
  request.setAttribute("page",paging);
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
			response.sendRedirect("maps_control.jsp?action=community&location="+ URLEncoder.encode(location,"UTF-8"));
		}else{
			response.sendRedirect("maps_control.jsp?action=community&location="+ URLEncoder.encode(location,"UTF-8"));
		}
	}
	
}
else if(action.equals("delete_p")){
	 String location = request.getParameter("location"); 
	 String postId = request.getParameter("id");
	 if(db.delPost(Integer.parseInt(postId))){
		 response.sendRedirect("maps_control.jsp?action=community&location="+ URLEncoder.encode(location,"UTF-8"));
	 }else
	 {
		 response.sendRedirect("maps_control.jsp?action=community&location="+ URLEncoder.encode(location,"UTF-8"));
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
				 response.sendRedirect("maps_control.jsp?action=alert&location="+ URLEncoder.encode(location,"UTF-8"));
			}else{
				 response.sendRedirect("maps_control.jsp?action=alert&location="+ URLEncoder.encode(location,"UTF-8"));
			}
		}
		
}
else if(action.equals("delete_a")){
	 String location = request.getParameter("location"); 
	 String alertId = request.getParameter("id");
	 if(db.delAlert(Integer.parseInt(alertId))){
		 response.sendRedirect("maps_control.jsp?action=alert&location="+ URLEncoder.encode(location,"UTF-8"));
	 }else
	 {
		 response.sendRedirect("maps_control.jsp?action=alert&location="+ URLEncoder.encode(location,"UTF-8"));
		
	 }
}

else if(action.equals("submit_i")){
	 String location = request.getParameter("location"); 
		String contry = request.getParameter("selectContry");
		String sex = request.getParameter("selectSex");
		String age = request.getParameter("age");
		String address = request.getParameter("address");
		String job = request.getParameter("job");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String source = request.getParameter("source");
		String where = request.getParameter("where");
		String whereLink = request.getParameter("whereLink");

		Object chk_user = session.getAttribute("me");
		if(chk_user ==null)
			out.println("message : login plz");
		else{
			String[] cnt = contry.split("/");
			CovidPatient patient = new CovidPatient();
			patient.setPatient_cntname(cnt[0]);
			patient.setPatient_cntcode(cnt[1]);
			patient.setPatient_sex(Integer.parseInt(sex));
			patient.setPatient_age(Integer.parseInt(age));
			patient.setPatient_home(address);
			patient.setPatient_job(job);
			patient.setPatient_route(source);
			patient.setPatient_first("2020-"+month+"-"+day);
			patient.setPatient_hospi(where+'@'+whereLink);
		
			if(db.insertPatient(patient,location))
			{
				response.sendRedirect("maps_control.jsp?action=infected&location="+ URLEncoder.encode(location,"UTF-8"));
			
			}else{
				response.sendRedirect("maps_control.jsp?action=infected&location="+ URLEncoder.encode(location,"UTF-8"));
			}
		}
		
}

else if(action.equals("logout")){
	session.invalidate();
	response.sendRedirect("index.jsp");
}

%>