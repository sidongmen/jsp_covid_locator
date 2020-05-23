<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>코로나 로케이터 로그인</title>
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<style type="text/css">
   
   body{
    background-color:#292b2c;
   }
   
	.login-form {
		width: 300px;
    	margin: 100px auto;
	}
	
	.login-form form {
    	margin-bottom: 15px;
        background: #f7f7f7;
        box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
        padding: 30px;
        border-radius:10px;
    }

    .login-form h2 {
        margin: 0 0 15px;
    }
    .form-control, .btn {
        min-height: 38px;
        border-radius: 2px;
    }
    .btn {        
        font-size: 15px;
        font-weight: bold;
    }
</style>
</head>
<body>

<div class="login-form">
   <a class="btn btn-primary m-3" href="javascript:history.back();">뒤로가기</a>
    <form action="maps_control.jsp?action=login" method="post">
        <h2 class="text-center">로그인</h2>       
        <div class="form-group">
            <input type="text" name="email"class="form-control" placeholder="이메일" required="required">
        </div>
        <div class="form-group">
            <input type="password" name="password" class="form-control" placeholder="비밀번호" required="required">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">확인</button>
        </div>
        <div class="clearfix">
            <label class="pull-left checkbox-inline"><input type="checkbox">저장</label>
            <a href="#" class="pull-right">비밀번호를 잊어버리셨나요?</a>
        </div>        
    </form>
    <p class="text-center"><a href="#">회원가입</a></p>
</div>

</body>
</html>   