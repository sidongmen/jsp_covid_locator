<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="covidLocator.model.*, java.util.*, java.text.*" pageEncoding="UTF-8"%>
    
    <%
  request.setCharacterEncoding("UTF-8");
   String value = request.getParameter("location");
   
   %>
 <jsp:useBean id="patients" scope="request" class="java.util.ArrayList" />  
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>확진자 정보</title>
<style type="text/css">
 .idx{
  display:inline;
  border-style:solid;
  border-color:#FFDC3C;
  background-color:#FFDC3C;
  padding: 2px;
  border-radius: 30px;
  font-size: small;
 }
 
  .ido{
  display:inline;
  border-style:solid;
  border-color:#3CB371;
  background-color:#3CB371;
  padding: 2px;
  border-radius: 30px;
  font-size: small;
  color: white;
 }
</style>
</head>
<body>
        <jsp:include page="menubar.jsp">
          <jsp:param name="select" value="<%=value%>"/>
        </jsp:include>
          
        <div class="container">
          <div class="d-flex justify-content-between align-items-center m-4">
          <h1> <%=value%> 확진자 </h1>
          <%
          if(session.getAttribute("me") != null) {
        	  CovidUser me = (CovidUser)session.getAttribute("me");
        	  if (me.getUser_role() == 1){
    	    %>
          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Modal" data-whatever="@mdo">확진자 추가</button>
          <% }
        	  }%>
          </div>
          <table class="table table-hover">
          <thead>
          <tr>
            <th>환자</th>
            <th>국적</th>
            <th>성별</th>
            <th>나이</th>
            <th>거주지</th>
            <th>직업</th>
            <th>추정 감염경로</th>
            <th>확진일</th>
            <th>격리시설/퇴원일</th>
          </tr>
        </thead>
        <tbody>
        
        	<%for(CovidPatient  patient : (ArrayList<CovidPatient>) patients) {%>
			    <tr>
           <td><%=patient.getPatient_id()%></td>
           <td><%=patient.getPatient_cntname()%> <img src="https://www.countryflags.io/<%=patient.getPatient_cntcode()%>/shiny/16.png"></td>
           <td>
             <% if(patient.getPatient_sex()==0){%>남성<%} else {%>여성<%} %>
           </td>
           <td>만 <%=patient.getPatient_age()%>세</td>
           <td><%=patient.getPatient_home()%></td>
           <td>
           <% if(patient.getPatient_job()==null){%>무직<%} else {%><%=patient.getPatient_job()%><%} %>
           <td><%=patient.getPatient_route()%></td>
           <%
           Date now = new Date();
           SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
           SimpleDateFormat fm = new SimpleDateFormat("MM/dd");
           Date dday = sf.parse(patient.getPatient_first());
           long diff = now.getTime()-dday.getTime();
           int daysbetween = (int)(diff / (1000*60*60*24));
           String days = fm.format(dday);
           String hospi = patient.getPatient_hospi();
           String[] hos = hospi.split("@");
           if (patient.getPatient_end()==null){
           %> 
             <td>
           <%=days%>
           <div class="idx">D+<%=daysbetween %></div>
           </td>
           
           <td>
          <a href="https://<%=hos[1]%>"><%=hos[0]%></a>
          
          </td>
          
           <% }else{%>
           <td>
           <%=days%>
            <div class="ido">퇴원</div>
            </td>
            <td>
          <a><%=fm.format(sf.parse(patient.getPatient_end()))%></a>
          
          </td>
           <%}%>
          </tr>
			   
			 <%
				}
			 %>
			 
        </tbody>
          </table>
        </div>
    <!-- Modal -->

    <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><%=value%>지역 확진자 추가</h5>
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