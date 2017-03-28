<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/date.format.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<!-- 自加，jquery-confirm -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jquery-confirm/jquery-confirm.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jquery-confirm/Font-Awesome-4.5.0/css/font-awesome.min.css"/>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath() %>/jquery-confirm/jquery-confirm.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
		var payStyle;
		var statusName;
		var workingConfirm;
		$(function(){
			chargeSuccess();
			getAllOrder();
			isUser();
		});
		//判断session中是否有用户,有就显示出来
		function isUser(){
			var userid= "${user.userid}";
			if(userid==null||userid==''||userid==undefined){
			}else{
				$("#isUser").html("");
				var html="<a href='<%=request.getContextPath()%>/views/userinfo2.jsp'>"+userid+"</a>";
				$("#isUser").append(html);
			}
		}
		//通过付款id获得付款方式
		function getPayStyle(paywayid){
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/action/payway/getPaywayByid",
				dataType : "json",
				data:{"paywayid":paywayid},
				async : false,
				success:function(data){
					var payway=data.payway;
					 payStyle=payway.paystyle;
				}
			});
		}
		//获得订单状态
		function getOrderStatus(statusid){
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/action/orderStatus/getOrderStatusById",
				dataType : "json",
				data:{"statusid":statusid},
				async : false,
				success:function(data){
					var orderStatus=data.orderStatus;
					statusName=orderStatus.name;
				}
			});
		}
		//获得所有用户订单
		function getAllOrder(){
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/action/order/getAllOrder",
				dataType : "json",
				 complete:function(){
	                	//加载提示框销毁
	                	workingConfirm.close();
	                },
				success:function(data){
					$("#showOrder").html('');
					var html=
					"<tr>"
					+"<th>"
					 +"操作"
					+"</th>"
					+"<th >"
					+"序号"
					+"</th>"
					+"<th>"
					+"订单编号"
					+"</th>"
					+"<th>"
					+"订单金额"
					+"</th>"
					+"<th >"
					+"交付时间"
					+"</th>"
					+"<th>"
					+"付款方式"
					+"</th>"
					+"<th >"
					+"订单状态"
					
					+"</th>"
					+"</tr>";
					$("#showOrder").append(html);
					
					$.each(data.orders, function(i, item){
						var orderid=item.orderid;
						var cost=item.cost;
						var orderstatus=item.orderstatusId;
						 getOrderStatus(orderstatus);
						var paywayId=item.paywayId;
						getPayStyle(paywayId);
						var finished=item.finished;
						var deadline=item.deadline;
						var d=new Date(deadline);
					    var deadline2=getFormatDate(d,"yyyy-MM-dd hh:mm:ss");
						var temp1="明细";
						var temp2="退款";
						var html3=null;
						if(finished==0){
							 temp1="删除";
							 temp2="付款";
						}
						var html2=
						"<tbody>"
						+"<tr>"
						+"<td >"
						+"<button type='button' class='btn btn-primary' onclick='btEven(\""+temp1+"\",\""+orderid+"\","+cost+")' >"+temp1+"</button>"
						+"<button type='button' class='btn btn-primary' onclick='btEven(\""+temp2+"\",\""+orderid+"\","+cost+")'>"+temp2+"</button>"
						+"</td>"
						 +"<td >"
						+(i+1)
						+"</td>" 
						+"<td >"
						+"<a href='<%=request.getContextPath()%>/action/order/toOrderInfo?orderid="+orderid+"'>"+orderid+"</a>"
						+"</td>"
						+"<td>"
						+cost
						+"￥</td>"
						+"<td >"
						+deadline2
						+"</td>"
						+"<td >"
						+ payStyle
						+"</td>"
						+"<td>"
						+statusName
						+"</td>";
						
						+"</tr>"
						+"</tbody>";
						
						html4=html3+html2;
						$("#showOrder").append(html2);
					});
				}
			});
		}
		//查询订单是否支付
		function chargeSuccess(){
			
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/action/order/chargeSuccess",
				dataType : "json",
				async: false,
                beforeSend:function(){
                	workingConfirm = $.confirm({
                		backgroundDismiss: false,
                		cancelButton: false, 
                	    confirmButton: false,
                	    closeIcon: false,
                	    icon: 'fa fa-spinner fa-spin',
                	    title: '请求数据中!',
                	    content: '正在请求数据，请稍候...'
                	});
                },
				success:function(data){
					
				}
			});
		}
		function beforeTo(){
			workingConfirm = $.confirm({
        		backgroundDismiss: false,
        		cancelButton: false, 
        	    confirmButton: false,
        	    closeIcon: false,
        	    icon: 'fa fa-spinner fa-spin',
        	    title: '请求数据中!',
        	    content: '正在请求数据，请稍候...'
			});
		}
		//跳转到单个订单详情页面
		function orderDtail(orderid){
			var hh=orderid;
			var url="<%=request.getContextPath()%>/action/order/toOrderInfo?orderid="+orderid;
			window.location=url;
		}
		//订单退款
		function refunCharge(orderid,cost){
			var amount=cost;
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/action/charge/refunCharge",
				dataType : "json",
				data:{"orderid":orderid,"amount":amount},
				success:function(data){
					var isrefunCharge=data.isrefunCharge;
					if(isrefunCharge==true){
						alert("退款成功！");
						getAllOrder();
					}else{
						alert("退款失败！");
					}
				}
			});
		}
		//删除订单
		function deleteOrder(orderid){
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/action/order/deleteOrder",
				dataType : "json",
				data:{"orderid":orderid},
				success:function(data){
					var msg=data.msg;
					if(msg==true){
						alert("删除成功！");
						getAllOrder();
					}else{
						alert("删除失败！");
					}
				}
			});
		}
		//订单付款
		function payOrder(orderid){
			var url="<%=request.getContextPath()%>/action/order/saveOrderbyid?orderid="+orderid+"";
			window.location=url;
		}
		function btEven(temp,orderid,cost){
			var temp2=temp;
			if(temp2=="删除"){
				deleteOrder(orderid);
			}else if(temp2=="付款"){
				payOrder(orderid);
			}else if(temp2=="明细"){
				orderDtail(orderid);
			}else if(temp2=="退款"){
				refunCharge(orderid,cost);
			}
		}
		</script>
</head>
<body  background="<%=request.getContextPath()%>/img/bg.jpg">

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div class="page-header">
							<h2 class="text-left text-success">
			<center>理工太阳能热水器销售商场</center>
				
			</h2>
			</div>
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
			<h3>定单详情</h3>
			<div id="dhn-table" class="container-fluid"
								style="background-color: white">
								<table id="showOrder"
									class="table table-bordered dhn-mytable">
									</table>
									</div>
			<!-- <div class="row">
				<div class="span12">
					<img alt="140x140" src="img/shopcart.png" />
					<h3>定单详情</h3>
					</div>
					<table class="table table-hover" >
					</table> 
					<div>
					</div>
				</div> -->
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