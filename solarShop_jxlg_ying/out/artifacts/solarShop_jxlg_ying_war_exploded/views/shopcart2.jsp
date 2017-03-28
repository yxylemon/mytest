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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<title>Insert title here</title>
<script type="text/javascript">
		$(function(){
			var oldAllPrice=0;
			var newAllPrice=0;
			showOrderline();
			isUser();
		});
		//判断当前session中是否存在用户,存在就把他显示出来
		function isUser(){
			var userid= "${user.userid}";
			if(userid==null||userid==''||userid==undefined){
			}else{
				$("#isUser").html("");
				var html="<a href='<%=request.getContextPath()%>/views/userinfo2.jsp'>"+userid+"</a>";
				$("#isUser").append(html);
			}
		}
		//显示购物车里的订单项
		function showOrderline(){
			$.ajax({
				type : "post",
      			url : "<%=request.getContextPath()%>/action/orderline/getAllOrderlineByUserId",
      			dataType : "json",
      			success: function(data){
      				var size=0;
      				var allPrice=0;
      				$("#table").html("");
      				$("#buttonGroup").html('');
      				$("#allprice").html("");
      				if(data.orderlines.length==0){
      					var html="<h3 class='text-left text-error'>"
      					+"<center>购物车空空如也,请前去主页购买太阳能！</center>"
      					+"</h3>";
      					$("#table").append(html);
      				}else{
      					
      				var html="<thead><tr><th>编号</th><th>产品名称</th><th>商品价格￥</th><th>商品数量</th><th>合计￥</th><th>操作</th></tr></thead>";
      				$("#table").append(html);
      				$.each(data.orderlines, function(i, item){
      					size=size+1;
      					var productId=item.productId;
      					var lineid=item.lineid;
      					var productName=item.productName;
      					var unitPrice=parseFloat(item.unitPrice);
      					var amount=item.amount;
      					var total=amount*unitPrice;
      					allPrice=allPrice+total;
				var html2="<tbody>"
					+"<tr>"
					+"<td>"+(i+1)+""
						+"</td>"
						+"<td><a href='<%=request.getContextPath()%>/action/product/getProductById/"+productId+"'>"+productName+"</a>"
						+"</td>"
						+"<td>"+unitPrice+""
						+"</td>"
						+"<td><a href='javascript:void(0)' onclick='addAmount(amount"+i+")'><img alt='' src='<%=request.getContextPath()%>/img/plus-blue.png'></a><input type='text' name='total"+i+"' id='amount"+i+"' value='"+amount+"'	style='width:40px; '  size='4' onblur='changeNum(this)'/><a href='javascript:void(0)' onclick='minus(amount"+i+")'><img alt='' src='<%=request.getContextPath()%>/img/minus-blue.png'></a>"
						+"</td>"
						+"<td>&nbsp;&nbsp;"+total+""
						+"</td>"
						+"<td>"
						+"<button class='btn btn-primary' type='button' onclick='deleteOrderline("+lineid+")'>删除</button>"
						+"<button class='btn btn-primary' type='button' onclick='saveChange("+lineid+","+i+")'>保存修改</button>"
						+"</td>"
						+"</tr>"
						+"</tbody>";
      					$("#table").append(html2);
      				});
      				if(allPrice!=0){
      							$("#allprice").text("总价"+allPrice+"￥");
      				}else{
      					$("#allprice").html("");
      				}
      				$("#buttonGroup").html('');
      				var html4=
      				"<button class='btn btn-primary' type='button' onclick='toConfirmOrder("+size+")'>提交订单</button>"
					+"<button class='btn btn-primary' type='button'  onclick='toIndex()'>继续购物</button>"
					+"<button class='btn btn-primary' type='button' onclick='deleteAllOrderline("+size+")'>清空购物车</button>";
      					$("#buttonGroup").append(html4);
      				}
      				
      			}
			});
		}
		//监听改变商品的数量
		function changeNum(data){
			var num=data.value;
			//获得数量的name
			var name=data.name;
			if(num==0){
				alert('对不起，产品数量不能小于 1 ');
				this.focus();
			}
		}
		//保存改变的订单项的信息
		function saveChange(lineid,i){
			var amount=$('#amount'+i).val();
			$.ajax({
				type : "post",
      			url : "<%=request.getContextPath()%>/action/orderline/saveOrderlineById",
      			dataType : "json",
      			data:{"lineid":lineid,'amount':amount},
      			success:function(data){
      				if(data.msg!=true){
      					alert("保存失败！");
      				}else{
      					alert("保存成功！");
      					showOrderline();
      				}
      			}
			});
		}
		

		//删除订单项
		function deleteOrderline(lineid){
			$.ajax({
				type : "post",
      			url : "<%=request.getContextPath()%>/action/orderline/deleteOrderlinePoductId",
      			dataType : "json",
      			data:{"lineid":lineid},
      			success:function(data){
      				if(data.msg!=true){
      					alert("删除失败！");
      				}else{
      					alert("删除成功！");
      					showOrderline();
      				}
      			}
			});
		}
		//删除购物车里的所有订单项
		function deleteAllOrderline(data){
			if(data==0){
				alert("购物车已经空空如也了！");
				return;
			}
			$.ajax({
				type : "post",
	  			url : "<%=request.getContextPath()%>/action/orderline/deleteAllOrderline",
	  			dataType : "json",
	  			success:function(data){
	  				if(data.msg!=true){
      					alert("删除失败！");
      				}else{
      					alert("删除成功！");
      					showOrderline();
      				}
	  			}
			});
			
		}
		//跳转到确认订单页面
		function toConfirmOrder(data){
			if(data!=0){
			var url="<%=request.getContextPath()%>/action/order/toOrderConfirm";
			window.location=url;
			}else{
				alert("请先选择你要购买的商品！");
			}
		}
		//跳转到主页
		function toIndex(){
			var url="<%=request.getContextPath()%>/index2.jsp";
			window.location=url;
		}
		//添加商品购买数量
		function addAmount(amount){
			var num=Number(amount.value)+1;
			amount.value=num;
		}
		//减少商品购买数量
		function minus(amount){
			var num=Number(amount.value)-1;
			if(num<=0){
				alert("对不起，产品数量不能小于 1");
			}else{
				
			amount.value=num;
			}
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
					<h3>购物车详情</h3>
					</div>
					<table class="table table-hover" id="table">
					</table> 
					<div id="allprice" style="padding-left:900px;font-size:15px;color:red;">
					
					</div>
					<div id="buttonGroup"></div>
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