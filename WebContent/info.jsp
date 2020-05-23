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
          <jsp:param name="select" value="<%=value%>"/>
        </jsp:include>
       <div class="m-3">
       <h3>개발자 : 홍성찬(192viva@gmail.com)</h3>
       </div>
</body>
</html>