<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <link rel="shortcut icon" href="assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/assets/ico/apple-touch-icon-57-precomposed.png">
<title>Insert title here</title>
</head>
<body>
 <!-- Top content -->
<%-- <div>
   <%@ include file="template_top.jsp" %>
 </div>  --%>
	<!-- Top content end -->
	<div class="row">
	      
          <div class="col-sm-1"></div>                    	
              <div class="col-sm-5">                       	
                    <div class="form-box">
                        <div class="form-top">
	                        <div class="form-top-left">
	                        	<h3>注册</h3>
	                            	<p>请输入注册信息:</p>
	                        </div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-pencil"></i>
	                        		</div>
	                      </div>
	                            <div class="form-bottom">
	                            <!--   -->
				                    <form role="form"  class="registration-form" action="register" method="post" name="reg" onsubmit="return checkSubmit()">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-first-name">userid</label>
				                        	<input type="text" name="userid" placeholder="用户名..." class="form-first-name form-control" id="form-first-name" onBlur="checkUser(this)">
				                        </div>
				                       <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password</label>
				                        	<input type="password" name="password" placeholder="密码..." class="form-password form-control" id="form-password">
				                        </div>
				                         <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password2</label>
				                        	<input type="password" name="password2" placeholder="密码确认..." class="form-password form-control" id="form-password">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-email">Email</label>
				                        	<input type="text" name="email" placeholder="Email..." class="form-email form-control" id="form-email">
				                        </div>
				                       <div class="form-group">
				                       <label class="sr-only" for="form-country">所在地区</label>
											<div class="info">
												<div>
													<select id="province" name="province" class="form-country form-control"></select>  
												    <select id="city" name="city" class="form-country form-control"></select>  
												    <select id="country" name="country" class="form-country form-control"></select>
												    <script class="resources library" src="js/area.js" type="text/javascript"></script>
												    <script type="text/javascript">_init_area();</script>
												    </div>
									    			<div id="show"></div>
											</div>
										</div>
									<div class="form-group">
				                    		<label class="sr-only" for="form-first-street1">联系地址</label>
				                        	<input type="text" name="street" placeholder="联系地址..." class="form-street1 form-control" id="form-street1">
				                     </div>
									<div class="form-group">
				                    		<label class="sr-only" for="form-first-zip">邮编</label>
				                        	<input type="text" name="zip" placeholder="邮编..." class="form-zip form-control" id="form-zip">
				                     </div>
				                     <div class="form-group">
				                    		<label class="sr-only" for="form-first-cellphone">联系电话</label>
				                        	<input type="text" name="cellphone" placeholder="联系电话..." class="form-zip form-cellphone" id="form-cellphone">
				                     </div>
				                     <div class="form-group">
				                    		<label class="sr-only" for="form-first-code">验证码</label>
				                        	<input type="text" name="code" placeholder="验证码..." class="form-zip form-code" id="form-code" onBlur="checkCode(this)">
				                     <button type="button" class="btn" onclick="sendCode()" id="delay" >点击获取验证码</button>
				                     </div>
									<button type="button" class="btn" onclick="checkSubmit()">注册</button>
				           </form>
				             
				           <div style="padding-left:200px;">
				          		 
                     		</div>
			             </div>
                   </div>
                </div>
            </div>
         </div>
                                	
	</div>
	<!-- Footer -->
  <footer>      	
   <div>
   <%@ include file="template_footer.jsp" %>
 </div> 
</footer>
        <!-- Javascript -->
        <script src="<%=request.getContextPath()%>/assets/js/jquery-1.11.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/jquery.backstretch.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/scripts.js"></script>
        <script src = "<%=request.getContextPath()%>/js/register.js"></script>   
        <script  src = "<%=request.getContextPath()%>/js/main.js"></script>
         <script type="text/javascript">
         var delay=60;
         var t1=null;
         var isCode=false;
         var isUser=false;
        
         //验证用户是否存在
        function checkUser(userid){
        	var temp=userid.value;
        	$.ajax({
    			type : "post",
    			url : "userisExist",
    			data:{"userid":temp},
    			dataType : "json",
    			success:function(data){	   				
    				   if(data.isExist){
    					   alert("用户已存在");
    					   isUser=true;
    				   }else{
    					   
    				   }			
    			},
    			error:function(){   
    				alert("错误。。。。");
    			}
    		}); 
        }
        //发送验证码
        function sendCode(){
        	var tel=$('#form-cellphone').val();
        	t1=setInterval("setdelayTime()",1000);
        	  $.ajax({
    			type : "post",
    			url : "action/user/getCode",
    			data:{"tel":tel},
    			dataType : "json",
    			success:function(data){
    				if(data.msg!=true){
    					alert("验证码发生失败，请检测手机号码是否正确!");
    				}
    				
    				}
    			});  
        	  }
        //验证码定时设置
         function setdelayTime(){
        	
        	if(delay==0){
        		window.clearInterval(t1);
        		$('#delay').attr("disabled",false);
        		$('#delay').text("点击获取验证码");
        		delay=60;
        	}else{
        	$('#delay').attr("disabled",true);
        	$('#delay').text(delay+"秒后重新发送");
        	delay=delay-1;
        	}
        } 
        //检验验证码是否正确
        function checkCode(data){
        	 var code=data.value;
        	  $.ajax({
      			type : "post",
      			url : "action/user/checkCode",
      			data:{"code":code},
      			dataType : "json",
      			async : false,
      			success:function(data){
      				if(data.msg!=true){
      					alert("您输入的验证码有误！");
      					}else{
      						isCode=true;
      					}
      				}
      			});  
        }
        //检验验证码是否正确
        function checkCode2(data){
        	 var code=data;
        	 alert(code);
        	  $.ajax({
      			type : "post",
      			url : "action/user/checkCode",
      			data:{"code":code},
      			dataType : "json",
      			async : false,
      			success:function(data){
      				if(data.msg!=true){
      					alert("您输入的验证码有误！");
      					}else{
      						isCode=true;
      					}
      				}
      			});  
        }
        //表单提交验证
        function checkSubmit(){
        	var flag=checkReg(); 
        	var code=document.reg.code.value;
        	checkCode2(code);
        	alert("isCode"+isCode);
        	 if(flag==false){
        		return false;
        	}
        	else  if((isCode!=true)||(isUser==true)){
        			alert("用户存在或验证码错误");
        			return false;
        	}else{
        	 document.reg.submit();
        	}
        }
        
        </script> 	
</body>
</html>