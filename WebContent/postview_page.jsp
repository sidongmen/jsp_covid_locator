<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="covidLocator.model.*, java.util.*" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
String value = request.getParameter("location");
CovidPost post = (CovidPost) request.getAttribute("post");
%>


<!DOCTYPE html>
<html lang="kr">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>게시물</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/blog-post.css" rel="stylesheet">

</head>

<body>

	<jsp:include page="menubar.jsp">
		<jsp:param name="select" value="<%=value%>" />
	</jsp:include>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<!-- Post Content Column -->
			<div class="col">
 
			<div class="d-flex justify-content-between align-items-center">
				<h1 class="mt-4"><%=post.getPost_title()%> 				
				</h1>
								   <%
          if(session.getAttribute("me") != null) {
        	  CovidUser me = (CovidUser)session.getAttribute("me");
               if(me.getUser_nickname().equals(post.getPost_nickname()) || me.getUser_role() == 1){
    	    %>
    	    <div>
               <djv class="btn btn-secondary mr-3">변경</djv>
               <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal">
              삭제
             </button>
             </div>
          <% }
        	  }%>
			</div>

				<!-- Author -->
				<p class="lead">
					by <a href="#"><%=post.getPost_nickname()%></a>
				</p>

				<hr>

				<!-- Date/Time -->
				<p><%=post.getPost_date()%></p>

				<hr>

				<!-- Post Content -->
				<div class="mx-auto" style="height: 200px;">
				<p class="lead">
					<%=post.getPost_content()%>
				</p>
                </div>


				<!-- Comments Form -->
				<div class="card my-4">
					<h5 class="card-header">댓글 남기기:</h5>
					<div class="card-body">
						<form>
							<div class="form-group">
								<textarea class="form-control" rows="3"></textarea>
							</div>
							<button type="submit" class="btn btn-primary">완료</button>
						</form>
					</div>
				</div>

				<!-- Single Comment -->
				<div class="media mb-4">
					<img class="d-flex mr-3 rounded-circle"
						src="http://placehold.it/50x50" alt="">
					<div class="media-body">
						<h5 class="mt-0">댓글 기능 없음</h5>
						댓글 기능은 기말텀에 추가하도록 하겠습니다.
					</div>
				</div>


			</div>

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시물 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       이 게시물을 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">아니요</button>
        <a class="btn btn-primary" href="maps_control.jsp?action=delete_p&location=<%=value%>&id=<%=post.getPost_id()%>">삭제</a>
      </div>
    </div>
  </div>
</div>
</body>

</html>