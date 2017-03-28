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
	showUserInfo();
	showPayway();
	showOrderDetail();
	showOrderCost();
	isUser();
});
//判断当前session中是否存在用户,有就显示出来
function isUser(){
	var userid= "${user.userid}";
	if(userid==null||userid==''||userid==undefined){
	}else{
		$("#isUser").html("");
		var html="<a href='<%=request.getContextPath()%>/views/userinfo2.jsp'>"+userid+"</a>";
		$("#isUser").append(html);
	}
}
//显示用户信息
function showUserInfo(){
	var userid="${user.userid}";
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/action/user/getUserInfo",
		dataType : "json",
		data:{"userid":userid},
		success:function(data){
			var user=data.user;
		if(data.userinfo!=false){
			var userinfo=data.userinfo;
			var userid=userinfo.userId;
			var province=userinfo.province;
			var city=userinfo.city;
			var country=userinfo.country;
			var street=userinfo.street;
			var zip=userinfo.zip;
			var email=userinfo.email;
			var cellphone=userinfo.cellphone;
			var address=province+city+country+street;
			$("#userId").text(userid);
			$("#address").text(address);
			$("#cellphone").text(cellphone);
			$("#email").text(email);
			$("#zip").text(zip);
			}
		}
	});
}
//显示付款方式
function showPayway(){
	var orderid='${orderinfoId}';
	var paywayid;
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/action/order/getOrderById",
		dataType : "json",
		data:{"orderid":orderid},
		success:function(data){
			var order=data.order;
			paywayid=order.paywayId;
			
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/action/payway/getPaywayByid",
		dataType : "json",
		data:{"paywayid":paywayid},
		success:function(data){
			var payway=data.payway;
			var paywayStyle=payway.paystyle;
			$("#paystyle").text(paywayStyle);
		}
	});
		}
	});
}
//显示订单详情
function showOrderDetail(){
	$("#orderTable").html('');
	var orderid='${orderinfoId}';
	var html="<thead>"
	+"<tr>"
	+"<th>"
	+"序号"
	+"</th>"
	+"<th>"
	+"商品名称"
	+"</th>"
	+"<th>"
	+"商品单价"
	+"</th>"
	+"<th>"
	+"商品数量"
	+"</th>"
	+"<th>"
	+"商品总价"
	+"</th>"
	+"</tr>"
	+"</thead>";
				$("#orderTable").append(html);
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/action/orderline/getOrderlineByorderId",
		dataType : "json",
		data:{"orderid":orderid},
		async: false,
		success:function(data){
			$.each(data.orderlines, function(i, item){
				var productName=item.productName;
				var productId=item.productId;
				var unitPrice=item.unitPrice;
				var amount=item.amount;
				var total=unitPrice*amount;
				var html2="<tbody>"
				+"<tr class='success'>"
				+"<td>"
				+i
				+"</td>"
				+"<td>"
				+"<a href='<%=request.getContextPath()%>/action/product/getProductById/"+productId+"' target='_blank'>"+productName+"</a>"
				+"</td>"
				+"<td>"
				+unitPrice
				+"￥</td>"
				+"<td>"
				+amount
				+"</td>"
				+"<td>"
				+total
				+"￥</td>"
				+"</tr>"
				+"</tbody>";
				$("#orderTable").append(html2);
			});
		}
	});
}
//显示订单总价
function showOrderCost(){
	$("#table2").html('');
	var orderid='${orderinfoId}';
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/action/order/getOrderById",
		dataType : "json",
		data:{"orderid":orderid},
		success:function(data){
			var order=data.order;
			var cost=order.cost;
			$("#totalPrice").text("合计："+cost+"￥");
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
							<tr class="info">
								<td>
									用户名
								</td>
								<td id="userId">
								</td>
							</tr>
							<tr class="success">
								<td >
									联系地址
								</td>
								<td id="address">
								</td>
								
							</tr>
							<tr class="error">
								<td>
									手机号码
								</td>
								<td id="cellphone">
								</td>
							</tr>
							<tr class="warning">
								<td>
									邮箱地址
								</td>
								<td id="email">
								</td>
							</tr>
							<tr class="info">
								<td>
									邮编
								</td>
								<td id="zip">
								</td>
							</tr>
						</tbody>
					</table> 
					 <div>
					<h3>支付方式</h3>
					<table class="table table-hover">
						<tbody>
							<tr class="info">
								<td>
									付款方式
								</td>
								<td id="paystyle">
								</td>
							</tr>
							</tbody>
					</table>
					</div>
					<div>
					 <h3>商品详情</h3>
					</div>
					<table class="table table-hover" id="orderTable">
					</table>
					<div style="padding-left:1100px;font-size:12px;color:red;">
					<h5 id="totalPrice"></h5>
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