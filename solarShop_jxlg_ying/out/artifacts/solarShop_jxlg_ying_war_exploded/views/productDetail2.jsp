<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
String path=request.getContextPath();
String basePath= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<title>Insert title here</title>
<script type="text/javascript">
		$(function(){
			getProduct();
			isUser();
		});
		//判断当前session 中是否存在用户,存在就显示出来
		function isUser(){
			var userid= "${user.userid}";
			if(userid==null||userid==''||userid==undefined){
			}else{
				$("#isUser").html("");
				var html="<a href='<%=request.getContextPath()%>/views/userinfo2.jsp'>"+userid+"</a>";
				$("#isUser").append(html);
			}
		}
		var productid;
		//获得产品信息
		function getProduct(){
			var baseprice='${product.baseprice}';
			var manufacturer='${product.manufacturer}';
			productid='${product.productid}';
			var productName='${product.name}';
			var description="${product.description}";
			var images='${product.images}';
			var amount='${product.amount}';
			var html="<img class='img-polaroid' alt='140x140' src='<%=request.getContextPath()%>/"+images+"' />";
			
			$("#images").html(html);
			$("#price").text(baseprice+"￥");
			$("#publish").text(manufacturer);
			$("#description").html(description);
			 $("#productName").text(productName);
			 $("#amount").text(amount+"台");
		}
		//把产品添加到购物车
		function addProduct(){
			
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/action/product/addProduct",
				dataType : "json",
				data:{'productid':productid},
				success:function(data){
					var url="<%=request.getContextPath()%>/views/shopcart2.jsp";
					window.location=url;
				}
			});
		}
		</script>
		<style type="text/css">
		.img-polaroid {
			width:400px; height:300px;
		}
		</style> 
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
			<div class="row-fluid" style="padding-top:50px;">
				<div class="span8">
				<div style="padding-left:50px;">
				<h3>商品图片</h3>
				</div>
				<div id="images"></div>
				</div>
				<div class="span4"  style="padding-top:50px;">
				<div style="padding-left:50px;">
				<h3>商品详情</h3>
				</div>
					<table class="table">
						<tbody>
							<tr>
								<td >
									产品名称
								</td>
								<td id="productName">
								</td>
							</tr>
							<tr class="success">
								<td>
									产品价格
								</td>
								<td id="price">
								</td>
							</tr>
							<tr class="warning">
								<td>
									产品销量
								</td>
								<td id="amount">
								</td>
							</tr>
							<tr class="error">
								<td>
									上架时间
								</td>
								<td id="deadline">
									02-04-2012
								</td>
							</tr>
							<tr class="warning">
								<td>
									生产商
								</td>
								<td id="publish">
								</td>
							</tr>
						</tbody>
					</table>
					 <button class="btn btn-danger btn-large btn-block" onclick="addProduct()" type="button">加入购物车</button>
				</div>
			</div>
				<h3>商品介绍</h3>
			<div id="description">
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