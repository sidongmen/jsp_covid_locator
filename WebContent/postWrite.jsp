<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String value = request.getParameter("location");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="menubar.jsp">
		<jsp:param name="select" value="<%=value%>" />
	</jsp:include>
	<div class="container">
		<div class="m-4">
			<h1>게시물 작성</h1>
		</div>
		<form method="POST" action="maps_control.jsp?action=submit_p&location=<%=value%>">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">제목</span>
				</div>
				<input type="text" name="title" class="form-control" placeholder="제목을 입력하시오"
					aria-label="Username" aria-describedby="basic-addon1">
			</div>
			<p class="m-2">내용</p>
			<div class="form-group">
				<textarea name="content" class="form-control" rows="10"></textarea>
			</div>
			<button type="submit" class="btn btn-primary btn-lg btn-block">작성
				완료!</button>
		</form>
	</div>
</body>
</html>