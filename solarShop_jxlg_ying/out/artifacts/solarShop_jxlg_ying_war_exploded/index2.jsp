<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<title>Insert title here</title>
<script type="text/javascript">
var pages=1;
var productSize=0;
var maxPage=0;
var pageList=12;
var searchName=null;
$(function(){
	/* menuTest(); */
 	ajaxpage(1, maxPage);
 	isUser();
});
function menuTest(){
	  //获取要定位元素距离浏览器顶部的距离
    var navH = $(".nav").offset().top;
	  
	  
    //滚动条事件
    $(window).scroll(function(){
            //获取滚动条的滑动距离
            var scroH = $(this).scrollTop();
            //滚动条的滑动距离大于等于定位元素距离浏览器顶部的距离，就固定，反之就不固定
            if(scroH>=navH){
                    $(".nav").css({"position":"fixed","top":0,"left":0});
            }else if(scroH<navH){
                    $(".nav").css({"position":"static","margin":"0 auto"});
            }
            console.log(scroH);
            console.log(navH);
            console.log(scroH==navH);
    })
}
//判断当前sssion是否存在用户，如果存在就显示当前用户
function isUser(){
	var userid= "${user.userid}";
	if(userid==null||userid==''||userid==undefined){
	}else{
		$("#isUser").html("");
		var html="<a href='<%=request.getContextPath()%>/views/userinfo2.jsp'>"+userid+"</a>";
		$("#isUser").append(html);
	}
}
//分页显示当前商品
function showData(page){
	var params={};
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/getProductByPage",
		dataType : "json",
		data:{"page":page,"pageList":pageList},
		async : false,
		success:function(data){
			$("#product1").html("");
			$("#product2").html("");
			$("#product3").html("");
			var products=data.result;
			var size=data.maxpage;
			productSize=data.productSize;
			
			maxPage=Math.ceil(parseFloat(size)/pageList);
			$.each(products, function(i, item){
				var html="<div class='col-xs-3 span3'><a href='<%=request.getContextPath()%>/action/product/getProductById/"+item.productid+"'>"
					+"<img class='img-polaroid' alt='140x140' src='"+item.images+"' /></a><span class='label'>"+item.name+",价格："+item.baseprice+"元</span>"
					+"<div><h5>购买量："+item.amount+"台------<a href='javascript:void(0);' onclick='addProduct("+item.productid+")'>加入购物车</a></h5></div>"
					+"</div>";
					if(i<4){
					$("#product1").append(html);
					}
					 if(4<=i&&i<8){
						$("#product2").append(html);
					}
					if(8<=i&&i<12){
						$("#product3").append(html);
					} 
			});
		}
	});
}
//搜索商品通过模糊查询
function searchProductByname(){
	var name=$("#searchName").val();
	console.log(name);
	if(name==null||name==''){
		alert("请输入搜索内容！");
	}else{
		$("#clearTemp").html("");
		searchName=name;
		ajaxpage(1, maxPage);
	}
}
//显示搜索出来的商品
function showDataBySearch(page){
	var params={};
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/getProductBySearch",
		dataType : "json",
		data:{"searchName":searchName,"page":page,"pageList":pageList},
		async : false,
		success:function(data){
			$("#product1").html("");
			$("#product2").html("");
			$("#product3").html("");
			var products=data.result;
			var size=data.maxpage;
			productSize=data.productSize;
			if(productSize==0){
				var html="<h3 class='text-left text-warning'><center>抱歉，没有匹配的商品！</center></h3>";
				$("#product1").append(html);
				$('#showPages').html("");
			}else{
			maxPage=Math.ceil(parseFloat(size)/pageList);
			$.each(products, function(i, item){
				var html="<div class='col-xs-3 span3'><a href='<%=request.getContextPath()%>/action/product/getProductById/"+item.productid+"'>"
							+"<img class='img-polaroid' alt='140x140' src='"+item.images+"' /></a><span class='label'>"+item.name+",价格："+item.baseprice+"元</span>"
							+"<div><h5>购买量："+item.amount+"台------<a href='javascript:void(0);' onclick='addProduct("+item.productid+")'>加入购物车</a></h5></div>"
							+"</div>";
					console.log(html);
					if(i<4){
					$("#product1").append(html);
					}
					 if(4<=i&&i<8){
						$("#product2").append(html);
					}
					if(8<=i&&i<12){
						$("#product3").append(html);
					} 
			});
			}
		}
	});
}
//添加商品
function addProduct(productId){
	$.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/action/product/addProduct",
		dataType : "json",
		data:{'productid':productId},
		success:function(data){
		alert("添加购物车成功！");
		},
		error:function(){
			var url="<%=request.getContextPath()%>/login.jsp";
			window.location=url;
		}
	});
}

//分页时页面大于5时
function pagetest(page, maxPa) {
	var row = "<li><a href=\"javascript:void(0);\"onclick=\"previouspage()\">首页</a></li>";
	$('#showPages').append(row);
	var row = "<li><a href=\"javascript:void(0);\"onclick=\"lastPage()\">上一页</a></li>";
	$('#showPages').append(row);
	if (maxPa > page + 3) {
		for (var i = page - 2; i <= page + 2; i++) {
			row = "<li id=\""+i+"\"><a href=\"javascript:void(0);\" onclick=\"ajaxpage("
					+ i + ',' + maxPa + ")\">" + i + "</a></li>";
			$('#showPages').append(row);
		}

	} else {
		for (var i = maxPa - 4; i <= maxPa; i++) {
			row = "<li id=\""+i+"\"><a href=\"javascript:void(0);\" onclick=\"ajaxpage("
					+ i + ',' + maxPa + ")\">" + i + "</a></li>";
			$('#showPages').append(row);
		}
	}
	row = "<li ><a href=\"javascript:void(0);\" onclick=\"nextPage()\">下一页</a></li>";
	$('#showPages').append(row);
	row = "<li><a href=\"javascript:void(0);\" onclick=\"endPage()\">尾页</a></li>";
	$('#showPages').append(row);

}
//初始化页面
function pagetest2(maxPa) {
	var row = "<li><a href=\"javascript:void(0);\"onclick=\"previouspage()\">首页</a></li>";
	$('#showPages').append(row);
	var row = "<li><a href=\"javascript:void(0);\"onclick=\"lastPage()\">上一页</a></li>";
	$('#showPages').append(row);
	if (maxPa >= 5) {
		for (var i = 1; i <= 5; i++) {
			row = "<li id=\""+i+"\"><a href=\"javascript:void(0);\" onclick=\"ajaxpage("
					+ i + ',' + maxPa + ")\">" + i + "</a></li>";
			$('#showPages').append(row);
		}
	} else {
		for (var i = 1; i <= maxPa; i++) {
			row = "<li id=\""+i+"\"><a href=\"javascript:void(0);\" onclick=\"ajaxpage("
					+ i + ',' + maxPa + ")\">" + i + "</a></li>";
			$('#showPages').append(row);
		}
	}
	row = "<li><a href=\"javascript:void(0);\" onclick=\"nextPage()\">下一页</a></li>";
	$('#showPages').append(row);
	row = "<li><a href=\"javascript:void(0);\" onclick=\"endPage()\">尾页</a></li>";
	$('#showPages').append(row);
}
//分页操作
function ajaxpage(page, maxPa) {
	pages = page;
	if(searchName==null||searchName==""){
	showData(pages);
	}else{
		showDataBySearch(pages);
	}
	maxPa=maxPage;
	if(productSize!=0){
		if (page >= 5) {
			$('#showPages').html("");
			pagetest(parseInt(page), maxPa);
			changeColor(page);
		}
		if (page < 5) {
			$('#showPages').html("");
			pagetest2(maxPa);
			changeColor(page);
		}
	}
	
}
//首页
function previouspage() {
	ajaxpage(1, maxPage);
}
//尾页
function endPage() {
	ajaxpage(maxPage, maxPage);
}
//上一页
function lastPage() {
	if (pages == 1) {
		alert("这已经是首页了");
		ajaxpage(1, maxPage);
	} else {
		ajaxpage(pages - 1, maxPage);
	}
}
//下一页
function nextPage() {
	if (pages == maxPage) {
		alert("已经是最后一页了");
		ajaxpage(maxPage, maxPage);
	} else {
		ajaxpage(pages + 1, maxPage);
	}
}
//选中页码改变颜色
function changeColor(page) {
	if( document.getElementById(page)!=null){
		 document.getElementById(page).setAttribute("class", "active");
	}
	
}
</script>
<style>
 .pagination ul>.active>a, .pagination ul>.active>a:hover
{
 	z-index: 2;
    color: #fff;
    cursor: default;
    background-color: #337ab7;
    border-color: #337ab7;
}
.img-polaroid {
width:304px; height:222px;
}
</style>
</head>
<body  background="img/bg.jpg" >
<div id="LG" class="container-fluid" style="height: 100%;">
	<div class="row-fluid">
		 <div class="span11" style="padding-left:50px"> 
			<h2 class="text-left text-success" style="padding-top: 40px;">
			<center>理工太阳能热水器销售商场</center>
				
			</h2>
			
			<div class="navbar">
			<!-- 标题栏悬浮 -->
<!-- 			<div class="navbar navbar-fixed-top "> -->
				<div class="navbar-inner">
					<div class="container-fluid">
					<!-- <div class="navbar "> -->
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
					<!-- </div> -->
					</div>
				</div>
			</div>
			<form class="form-search">
				<input class="input-medium search-query" type="text" id="searchName" placeholder="商品名称..."/><button class="btn btn-danger" type="button" onclick="searchProductByname()">搜索</button>
			</form>
			<div id="clearTemp">
			<div class="carousel slide" id="carousel-11856">
				<ol class="carousel-indicators">
					<li data-slide-to="0" data-target="#carousel-11856">
					</li>
					<li data-slide-to="1" data-target="#carousel-11856">
					</li>
					<li data-slide-to="2" data-target="#carousel-11856" class="active">
					</li>
				</ol>
				<div class="carousel-inner">
					<div class="item">
					<a href="<%=request.getContextPath()%>/action/product/getProductById/178">
						<img alt="" src="img/micoe.jpg" /></a>
						<div class="carousel-caption">
							<h4>
								四季沐歌
							</h4>
							<p>
							采用德国真空磁控溅射金属陶瓷（CERMET）镀膜带，集热高，热损小，吸收率高达97%，发射率低至5%，太阳能光热转化比挑战极限；集热效率高、得热量大
							</p>
						</div>
					</div>
					<div class="item">
					<a href="<%=request.getContextPath()%>/action/product/getProductById/100">
						<img alt="" src="img/haier.jpg" /></a>
						<div class="carousel-caption">
							<h4>
								Haier
							</h4>
							<p>  专利横式发泡，均匀致密保温持久专属三抗支架，抗风抗压抗腐蚀  高温速热配比，热水一呼即应
							</p>
						</div>
					</div>
					<div class="item active">
					<a href="<%=request.getContextPath()%>/action/product/getProductById/16">
						<img alt="" src="img/sunrain2.jpg" /></a>
						<div class="carousel-caption">
							<h4>
								太阳雨太阳能
							</h4>
							<p>
							采用微电脑导航，特有人性化智能控制操作系统，智能调节太阳能热水器系统水温，采用国际领先的“非稳态热效率”计算方法，实现容积、集热面积和保热性能的最佳配比，操作更轻松，热水更便捷。
							</p>
						</div>
					</div>
				</div> <a data-slide="prev" href="#carousel-11856" class="left carousel-control">‹</a> <a data-slide="next" href="#carousel-11856" class="right carousel-control">›</a>
			</div>
			</div>
<!-- 			<div class="btn-group">
				 <button class="btn" type="button" value="分类1">分类1<em class="icon-align-left"></em></button> <button class="btn" type="button">分类1<em class="icon-align-center"></em></button> <button class="btn" type="button">分类1<em class="icon-align-right"></em></button> <button class="btn" type="button">分类1<em class="icon-align-justify"></em></button>
			</div> -->
			<div class="row" id="product1">
			</div>
			<div class="row" id="product2">
				
			</div>
			<div class="row" id="product3">
			</div>
			
			<div class="pagination pagination-centered">
			
				<ul id="showPages">
				</ul>
			</div>
			
			<div class="container-fluid">
						<div class="form-group">
							<div class="col-sm-12">
								<div id="showData"></div>
							</div>
							<div id="dhn-pagebuttons" class="col-sm-12">
								<ul id="Mypagination" class="pagination pagination-centered">
								</ul>
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