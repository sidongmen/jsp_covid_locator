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
          <tr>
           <td>5</td>
           <td>대한민국 <img src="https://www.countryflags.io/kr/shiny/16.png"></td>
           <td>남성</td>
           <td>만 28세</td>
           <td>울산 동구</td>
           <td>교사</td>
           <td>해외입국자(마닐라)</td>
           <td>5/21  <div class="idx">D+3</div></td>
          <td><a href="#">울산대학교병원</a></td>
          </tr>
            <tr>
           <td>4</td>
           <td>일본 <img src="https://www.countryflags.io/jp/shiny/16.png"></td>
           <td>남성</td>
           <td>만 54세</td>
           <td>울주군</td>
           <td>무직</td>
           <td>해외입국자(미국)</td>
           <td>5/18 <div class="idx">D+7</div></td>
         <td><a href="#">울산대학교병원</a></td>
          </tr>
           <tr>
           <td>3</td>
           <td>대한민국 <img src="https://www.countryflags.io/kr/shiny/16.png"></td>
           <td>남성</td>
           <td>만 54세</td>
           <td>울주군</td>
           <td>무직</td>
           <td>해외입국자(미국)</td>
           <td>5/18 <div class="ido">퇴원</div></td>
           <td>05/25</td>
          </tr>
          <tr>
           <td>2</td>
            <td>미국 <img src="https://www.countryflags.io/us/shiny/16.png"></td>
           <td>남성</td>
           <td>만 54세</td>
           <td>울주군</td>
           <td>무직</td>
           <td>해외입국자(미국)</td>
           <td>5/18 <div class="ido">퇴원</div></td>
           <td>05/26</td>
          </tr>
           <tr>
           <td>1</td>
           <td>대한민국 <img src="https://www.countryflags.io/kr/shiny/16.png"></td>
           <td>남성</td>
           <td>만 54세</td>
           <td>울주군</td>
           <td>무직</td>
           <td>해외입국자(미국)</td>
           <td>5/18 <div class="ido">퇴원</div></td>
           <td>05/31</td>
          </tr>
        </tbody>
          </table>
        </div>
        
        
</body>
</html>