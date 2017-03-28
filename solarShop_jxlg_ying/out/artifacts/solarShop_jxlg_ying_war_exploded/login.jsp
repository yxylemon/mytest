<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/form-elements.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-57-precomposed.png">
</head>
<body>
  <!-- Top content --> 
   
<%--  <div>
   <%@ include file="template_top.jsp" %>
 </div>  --%>                 
	<!-- Top content end -->	  
				<div class="row">
                        <div class="col-sm-5">
                        	<div class="form-box">
	                        	<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3>登录主页</h3>
	                            		<p>请输入用户名和密码:</p>
	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-lock"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom">
				                    <form role="form" action="Login" method="post" class="login-form">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-username">Username</label>
				                        	<input type="text" name="userid" placeholder="用户名..." class="form-username form-control" id="form-username" onBlur="checkUser(this)">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password</label>
				                        	<input type="password" name="password" placeholder="密码..." class="form-password form-control" id="form-password">
				                        </div>
				                        <button type="submit" class="btn">登录</button>
				                    </form>
				                    <div class="btn" onclick="toregister()">没有账号？点击注册</div>
			                    </div>
		                    </div>              
						</div>
				</div>
				
<!-- Footer -->
<%-- <footer>      	
   <div>
   <%@ include file="template_footer.jsp" %>
 </div> 
</footer> --%>

        <!-- Javascript -->
      <script src="<%=request.getContextPath()%>/assets/js/jquery-1.11.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/jquery.backstretch.min.js"></script>
        <!--  <script src="<%=request.getContextPath()%>/assets/js/jquery-2.1.1.min.js"></script>  -->
        <script src="<%=request.getContextPath()%>/assets/js/scripts.js"></script>
        <script type="text/javascript">
      /*   $(function(){
        	 getFlag();
		}); */
        //检验当前用户名是否存在
        function checkUser(userid){
        	var temp=userid.value;
        	$.ajax({
    			type : "post",
    			url : "userisExist",
    			data:{"userid":temp},
    			dataType : "json",
    			success:function(data){	   				
    				   if(!data.isExist){
    					   alert("用户不存在");
    				   }			
    			},
    			error:function(){   
    				alert("错误。。。。");
    			}
    		}); 
        }
        //跳转到注册页面
        function toregister(){
        	location.href="register.jsp";
        }
       /*  function getFlag(){
        	var flag="${flag}";
        	alert(flag);
        } */
        </script>
        <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

</body>
</html>