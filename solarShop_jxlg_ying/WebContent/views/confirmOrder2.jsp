<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<title>Insert title here</title>
<script type="text/javascript">
		$(function(){
			isUser();
		});
		//判断session中是否有用户,存在就显示出来
		function isUser(){
			var userid= "${user.userid}";
			if(userid==null||userid==''||userid==undefined){
			}else{
				$("#isUser").html("");
				var html="<a href='<%=request.getContextPath()%>/views/userinfo2.jsp'>"+userid+"</a>";
				$("#isUser").append(html);
			}
		}
		//跳转到更改用户信息页面
		function changeUserinfo(){
			var url="<%=request.getContextPath()%>/views/userinfo.jsp";
			window.location=url;
		}
		//跳转到修改购物车页面
		function changeShopcart(){
			var url="<%=request.getContextPath()%>/views/shopcart.jsp";
			window.location=url;
		}
		//提交订单 
		function submitOrder(){
			
			var paywayid=$("#paywayid").val();
			var url="<%=request.getContextPath()%>/action/order/saveOrder?paywayid="+paywayid+"";
			window.location=url;
			
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
			<div >
			
		
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
			</div>
			<div class="row-fluid">
				<div class="span12">
					<!-- <img alt="140x140" src="img/shopcart.png" /> -->
						<div>
						<h3>用户信息</h3>
						</div>
					<table class="table table-hover">
						<tbody>
							<tr>
								<td>
									用户名
								</td>
								<td id="userId">
									${sessionScope.userinfo.userId }
								</td>
							</tr>
							<tr class="success">
								<td >
									联系地址
								</td>
								<td id="address">
									${sessionScope.userinfo.province }${sessionScope.userinfo.city }${sessionScope.userinfo.country }${sessionScope.userinfo.street }
								</td>
								
							</tr>
							<tr class="error">
								<td>
									手机号码
								</td>
								<td id="cellphone">
									${sessionScope.userinfo.cellphone }
								</td>
							</tr>
							<tr class="warning">
								<td>
									邮箱地址
								</td>
								<td id="email">
									${sessionScope.userinfo.email }
								</td>
							</tr>
							<tr class="info">
								<td>
									邮编
								</td>
								<td id="zip">
									${sessionScope.userinfo.zip }
								</td>
							</tr>
						</tbody>
					</table> 
					<div>
					<button class="btn btn-primary" type="button" onclick="changeUserinfo()">修改用户信息</button>
					</div>
					<div>
					<h3>支付方式</h3>
					<select id="paywayid">
                          <c:forEach items="${sessionScope.payways}" var="payway">
		                          	<option value="${payway.paywayid }">${payway.paystyle }</option>
                          </c:forEach>
                          </select>
					</div>
					<div>
					<h3>商品详情</h3>
					
					</div>
					<table class="table table-hover">
					<thead>
							<tr>
								<th>
									序号
								</th>
								<th>
									商品名称
								</th>
								
								<th>
									商品单价
								</th>
								<th>
									商品数量
								</th>
								<th>
									商品总价
								</th>
								
							</tr>
						</thead>
						<%
						int i=1;
						%>
        			 <c:forEach items="${sessionScope.orderlines}" var="orderline">
         
						<tbody>
							<tr class="success">
								<td>
								<%=i++ %>
								</td>
								<td>
								<a href="<%=request.getContextPath()%>/action/product/getProductById/${orderline.productId }" target="_blank">${orderline.productName }</a>
								</td>
								<td>
								${orderline.unitPrice }
								</td>
								<td>
								${orderline.amount }
								</td>
								<td>
								${(orderline.amount)*(orderline.unitPrice) }
								</td>
							</tr>
						</tbody>
         			</c:forEach>
					</table>
					<div style="padding-left:1100px;font-size:12px;color:red;">
					<h5>合计：${sessionScope.totalPrice}￥</h5>
					</div> 
					<button class="btn btn-primary" type="button" onclick="changeShopcart()">修改商品</button>
					<div>
					</div>
					<div style="padding-left:1000px; width:200px; height:200px;">
						<button class="btn btn-danger btn-large btn-block" type="button" onclick="submitOrder()">提交订单</button>
					</div>
				</div>
			</div>
				<div class="container">
        		<div class="row">
        			<div class="col-sm-8 col-sm-offset-2">
        				<p><center>Copyright &copy;2012 - 2016 <a href="<%=request.getContextPath()%>/index2.jsp" target="_blank"><strong>solars</strong></a> 
        					.com <i class="fa fa-smile-o"></i></center></p>
        			</div>       			
        		</div>
        	</div>
		</div>
	</div>
</div>
</body>
</html>