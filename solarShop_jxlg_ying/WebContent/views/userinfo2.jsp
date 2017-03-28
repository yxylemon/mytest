<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language = "JavaScript" src = "<%=request.getContextPath()%>/js/main.js"></script>
<script class='resources library' src='<%=request.getContextPath()%>/js/area.js' type='text/javascript'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<title>Insert title here</title>
<script type="text/javascript">
			var delay=60;
			var isCode=false;
			var t1=null;
			$(function(){
				getUserInfo();
				isUser();
			});
			//判断当前session中是否存在用户,存在就显示出来
			function isUser(){
				var userid= "${user.userid}";
				if(userid==null||userid==''||userid==undefined){
				}else{
					$("#isUser").html("");
					var html="<a href='<%=request.getContextPath()%>/views/userinfo2.jsp'>"+userid+"</a>";
					$("#isUser").append(html);
				}
			}
			//给用户动态赋值
			function getUserInfo(){
				var userid= "${user.userid}";
				$.ajax({
					type : "post",
	    			url : "action/user/getUserInfo",
	    			data:{"userid":userid},
	    			dataType : "json",
					success: function(data){
						var user=data.user;
						if(data.userinfo!=false){
							var userinfo=data.userinfo;
							console.log(data.userinfo);
							var html=
						"<tbody>"
							+"<tr>"
							+"<td>"
							+"<b>用户名</b>：<br>注册用户名长度限制为0－16字节<input type='hidden' name='userid' value='"+userinfo.userId+"'>"
							+"</td>"
							+"<td>"
							+"<input type='text' maxLength='8' size='32' disabled value='"+userinfo.userId+"' style='font-family: Tahoma,Verdana,宋体; font-size: 12px; line-height: 15px; color: #000000'>"
							+"</td>"
							+"</tr>"
							+"<tr class='success'>"
							+"<td>"
							+"<b>密码(至少6位，至多8位)</b>：<br>请输入密码，区分大小写。<br>请不要使用任何类似 \'*\'、\' \' 或 HTML 字符'"
							+"</td>"
							+"<td>"
							+"<input type='password' maxLength='8' size='32' name='password' value='"+user.password+"' style='font-family: Tahoma,Verdana,宋体; font-size: 12px; line-height: 15px; color: #000000'>"
							+"</td>"
							+"</tr>"
							+"<tr class='error'>"
							+"<td>"
							+"<b>密码(至少6位，至多8位)</b>：<br>请再输一遍确认"
							+"</td>"
							+"<td>"
							+"<input type='password' maxLength='8' size='32' name='password2' value='"+user.password+"' style='font-family: Tahoma,Verdana,宋体; font-size: 12px; line-height: 15px; color: #000000'>"
							+"</td>"
							+"</tr>"
							+"<tr class='success'>"
							+"<td>"
							+"所在地区"
							+"</td>"
							+"<td>"
							+"<div class='info'>"
							+"	<div>"
							+"	<select id='province' name='province'></select>"  
							+"   <select id='city' name='city' ></select>"  
							+"   <select id='country' name='country'></select>"
							+"</div>"
			    			+"<div id='show'></div>"
							+"</div>"
							+"</td>"
							+"<tr class='error'>"
							+"<td>"
							+"联系地址"
							+"</td>"
							+"<td>"
							+"<textarea name='street' id='street' rows='1' cols='30'>"+userinfo.street+"</textarea>"
							+"</td>"
							+"</tr>"
							+"<tr class='success'>"
							+"<td>"
							+"手机号码"
							+"</td>"
							+"<td>"
							+"	<input type='text' size='32' maxlength='16' name='cellphone' id='cellphone' value='"+userinfo.cellphone+"' style='font-family: Tahoma,Verdana,宋体; font-size: 12px; line-height: 15px; color: #000000'>"
							+"<input type='text' name='code' placeholder='验证码...'  id='form-code' onBlur='checkCode(this)'>"
							+"<button type='button'  onclick='sendCode()' id='delay' >点击获取验证码</button>"
							+"</td>"
							+"</tr>"
							+"<tr class='warning'>"
							+"<td>"
							+"邮箱地址"
							+"</td>"
							+"<td>"
							+"<input maxLength='50' size='32' maxlength='32' name='email' value='"+userinfo.email+"' style='font-family: Tahoma,Verdana,宋体; font-size: 12px; line-height: 15px; color: #000000'></td>"
							+"</td>"
							+"</tr>"
							+"<tr class='info'>"
							+"<td>"
							+"邮编"
							+"</td>"
							+"<td>"
							+"<input type='text' size='32' maxlength='8' name='zip' value='"+userinfo.zip+"' style='font-family: Tahoma,Verdana,宋体; font-size: 12px; line-height: 15px; color: #000000'>"
							+"</td>"
							+"</tr>"
							+"</tbody>";
							var html2="<div style='display: none;'><input type='text' name='contactid' value='"+userinfo.contactid+"'/><input type='text' name='userId' value='"+userinfo.userId+"'/></div>"
							var html3=
								"<div style='padding-left:300px;'>"
							    +"<button class='btn btn-primary' type='button' onclick='submitForm()'>修改用户信息</button>";
						
							$("#table").append(html);
							$("#table").append(html2);
							$("#table").append(html3);
							 _init_area();
							var province = document.getElementById('province');
							province.options[0].value = userinfo.province;
							province.options[0].text = userinfo.province; 
							var city = document.getElementById('city');
							city.options[0].value = userinfo.city;
							city.options[0].text = userinfo.city; 
							var country = document.getElementById('country');
							country.options[0].value = userinfo.country;
							country.options[0].text = userinfo.country; 
						}
					}
				});
			}
	//提交用户信息修改
	function submitForm(){

		var flag=checkReg();
		if(flag==false){
			return;
		}
		if((flag==true)&&(isCode==true)){
			alert("修改成功！");
			document.reg.submit();
		}else{
			alert("请检查验证码是否正确！");
		}
	}
	
	 //发送验证码
    function sendCode(){
    	var tel=$('#cellphone').val();
    	t1=setInterval("setdelayTime()",1000);
    	  $.ajax({
			type : "post",
			url : "action/user/getCode2",
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
  			success:function(data){
  				if(data.msg!=true){
  					alert("您输入的验证码有误！");
  					}else{
  						isCode=true;
  					}
  				}
  			});  
    }
		</script>
</head>
<body  background="<%=request.getContextPath()%>/img/bg.jpg">

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<h2 class="text-left text-success">
			<center>理工太阳能热水器销售商场</center>
			</h2>
						<div class="navbar">
				<div class="navbar-inner">
					<div class="container-fluid">
						 <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></a> <a href="<%=request.getContextPath()%>/index2.jsp" class="brand">太阳能热水器商城</a>
						<div class="nav-collapse collapse navbar-responsive-collapse">
							<ul class="nav">
								<li >
									<a href="<%=request.getContextPath()%>/index2.jsp">首页</a>
								</li>
								<li>
									<a href="<%=request.getContextPath()%>/views/shopcart2.jsp">购物车</a>
								</li>
								<li>
									<a href="<%=request.getContextPath()%>/views/userinfo2.jsp">个人中心</a>
								</li>
								<li>
									<a href="<%=request.getContextPath()%>/views/order2.jsp">我的订单</a>
								</li>
							</ul>
							<ul class="nav pull-right">
								<li id="isUser">
									<a href="<%=request.getContextPath()%>/login.jsp">登录</a>
								</li>
								<li>
									<a href="<%=request.getContextPath()%>/register.jsp">注册</a>
								</li>
								<li>
									<a href="<%=request.getContextPath()%>/loginOut">退出</a>
								</li>
								<li class="divider-vertical">
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row-fluid">
						<div style="padding-left:10px;">
						<h3>个人中心</h3>
						</div>
				<div class="span11" style="padding-left:20px;">
					<!-- <img alt="140x140" src="img/a.jpg" /> -->
					<form method="post" name="reg" action='action/user/changeUserinfo'>
					<table class="table table-hover" id="table">
					</table> 
					</form>
					<!-- <div style="padding-left:300px;">
 <button class="btn btn-primary" type="button">修改用户信息</button> -->
					</div>
				</div>
			</div>
<div class="container">
        		<div class="row">
        			<div class="col-sm-8 col-sm-offset-2">
        				<p><center>Copyright &copy;2004 - 2013 <a href="<%=request.getContextPath()%>/index2.jsp" target="_blank"><strong>solars</strong></a> 
        					.com <i class="fa fa-smile-o"></i></center></p>
        			</div>       			
        		</div>
        	</div>
		</div>
	</div>
</div>
</body>
</html>