<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<title>Insert title here</title>


</head>
<body  background="img/bg.jpg">
<div id="LG" class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<h3 class="text-left text-success">
			<center>理工太阳能热水器销售商场</center>
				
			</h3>
			
			<div class="navbar">
				<div class="navbar-inner">
					<div class="container-fluid">
						 <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></a> <a href="#" class="brand">太阳能热水器商城</a>
						<div class="nav-collapse collapse navbar-responsive-collapse">
							<ul class="nav">
								<li class="active">
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
								<li>
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
		</div>
	</div>
</div>
</body>
</html>