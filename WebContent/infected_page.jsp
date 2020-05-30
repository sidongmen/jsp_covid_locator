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
   .idt{
  display:inline;
  border-style:solid;
  border-color:#f56e6e;
  background-color:#f56e6e;
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
        	   if(daysbetween == 0) {
           %> 
             <td>
           <%=days%>
           <div class="idt">오늘</div>
           </td>
           
           <% } else {%>
             <td>
           <%=days%>
           <div class="idx">D+<%=daysbetween %></div>
           </td>
    
           <% 
           }
        	   %>
        	   <td>
          <a href="https://<%=hos[1]%>"><%=hos[0]%></a>
          
          </td>
        	   <%
           }
           
           else{%>
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

    <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><%=value%>지역 확진자 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form method="post" action="maps_control.jsp?action=submit_i&location=<%=value%>">
      <div class="modal-body">
          <div class="form-group">
    <label>국적</label>
    <select class="form-control" name="selectContry">
      <option>대한민국/kr</option>
      <option>일본/jp</option>
      <option>미국/us</option>
    </select>
  </div>
            <div class="form-group">
    <label for="exampleFormControlSelect1">성별</label>
    <select class="form-control" name="selectSex">
      <option value="0">남성</option>
      <option value="1">여성</option>
     </select>
      </div>
      <div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text">만</span>
  </div>
  <input type="text" name="age" class="form-control" aria-label="age">
  <div class="input-group-append">
    <span class="input-group-text">나이</span>
  </div>
   </div>
   
   <div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">거주지</span>
  </div>
  <input type="text" name="address" class="form-control" placeholder="거주지 정보를 입력해주세요." aria-label="address" aria-describedby="basic-addon1">
</div>

   <div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">직업</span>
  </div>
  <input type="text" name="job" class="form-control" placeholder="직업을 입력해주세요." aria-label="job" aria-describedby="basic-addon1">
</div>
<div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text">확진 판정 월/일</span>
  </div>
  <input type="text" name="month" placeholder="월" aria-label="month" class="form-control">
  <input type="text" name="day" placeholder="일" aria-label="day" class="form-control">
</div>
          <div class="form-group">
            <label class="col-form-label">추정 감염경로:</label>
            <textarea class="form-control" name="source"></textarea>
          </div>
          
             <div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">격리시설</span>
  </div>
  <input type="text" name="where" class="form-control" placeholder="대학병원, 보건소 및 자택 등" aria-label="where" aria-describedby="basic-addon1">
</div>

   <div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">격리시설 링크</span>
  </div>
  <input type="text" name="whereLink" class="form-control" placeholder="www.hospital.com" aria-label="whereLink" aria-describedby="basic-addon1">
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