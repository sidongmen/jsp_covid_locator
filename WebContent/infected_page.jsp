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
          <div class="m-4">
          <h1> <%=value%> 확진자</h1>
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
        
        
</body>
</html>