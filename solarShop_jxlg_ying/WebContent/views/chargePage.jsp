<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>MiniCheckout</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/pinus.css">
    <script src="<%=request.getContextPath()%>/assets/js/jquery-1.11.1.min.js"></script>
</head>
<body>
<header>
    <div class="h_content">
        <span></span>
    </div>
</header>
<section class="block">
    <div class="content2">
        <div class="app">
            <span class="iphone"><img src="<%=request.getContextPath()%>/images/bgpic.jpg" width="100%" height="auto"></span>
            <label class="text_amount">
                <input id="amount" type="text" placeholder="金 额" value="${sessionScope.chargePrice}" disabled="disabled"/>
            </label>

            <div class="ch">
                <span class="up" onclick="wap_pay('alipay_pc_direct')">支付宝网页支付</span>
                <br>
            </div>
        </div>
    </div>
</section>
<script src="<%=request.getContextPath()%>/js/pingpp-pc.js" type="text/javascript"></script>
<script>
   <%--  function wap_pay(channel) {
        var amount = document.getElementById('amount').value * 100;

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "<%=request.getContextPath()%>/chargeTest", true);
        xhr.setRequestHeader("Content-type", "application/json");
        xhr.send(JSON.stringify({
            channel: channel,
            amount: amount
        }));

        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log(xhr.responseText);
                pingppPc.createPayment(xhr.responseText, function(result, err) {
                    console.log(result);
                    console.log(err);
                });
            }
        }
    } --%>
   /*  $(function(){
    	setUserCookie();
    }); */
    function wap_pay(channel){
    	var amount = document.getElementById('amount').value * 100;
    	$.ajax({
    		type : "post",
			url : "<%=request.getContextPath()%>/action/charge/chargeTest",
			data:{"channel":channel,"amount":amount},
			dataType : "json",
			success:function(data){
				pingppPc.createPayment((JSON.stringify(data.charge)), function(result, err) {
                    console.log(result);
                    console.log(err);
                });
			}
    	});
    }
    
    function refuntest(){
    	$.ajax({
    		type : "post",
    		url : "<%=request.getContextPath()%>/refunchargeTest",
    		dataType : "json",
    		success:function(data){
    			alert("success!");
    		}
    	});
    	
    }
    
    /* function setUserCookie(){
    	var userid='${user.userid}';
    	var password='${user.password}';
    	document.cookie="userid="+userid+"";
    	document.cookie="password="+password+"";
    } */
</script>
</body>
</html>
