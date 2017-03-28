function checkReg() {
	var temp;
	temp = new String(document.reg.password.value);
	if(document.reg.userid.value == "") {
		alert("请输入用户名!");
		document.reg.userid.focus();
		return false;
	}
	if(document.reg.password.value == "") {
		alert("请输入密码!");
		document.reg.password.focus();
		return false;
	}else if(temp.length < 6 || temp.length > 8) {
		alert("您的密码少于6位或多于8位!");
		document.reg.password.focus();
		return false;
	}
	if(document.reg.password2.value == "") {
		alert("请再次输入密码!");
		document.reg.password2.focus();
		return false;
	} else if(document.reg.password.value != document.reg.password2.value) {
		alert("您二次密码输入不一致!");
		document.reg.password.value = "";
		document.reg.password2.value = "";
		document.reg.password.focus();
		return false;
	}
	if(document.reg.zip.value==''){
		alert('邮编不能为空');
		document.reg.zip.focus();
		return false;
	}
	if(document.reg.street.value==''){
		alert('地址不能为空');
		document.reg.street.focus();
		return false;
	}
	if(document.reg.email.value != "" || IsEmail(document.reg.email.value)) {
		alert("您的E-mail不符合规范!");
		document.reg.email.focus();
		return false;
	}
	document.reg.submit();
}

function IsEmail(item){
	var etext
	var elen
	var i
	var aa
	var uyear,umonth,uday
	etext=item;
	elen=etext.length;
	if (elen<5)
 		return true;
	i= etext.indexOf("@",0)
	if (i==0 || i==-1 || i==elen-1)
 		return true;
	else
 		{if (etext.indexOf("@",i+1)!=-1)
  			return true;}
		if (etext.indexOf("..",i+1)!=-1)
 		return true;
	i=etext.indexOf(".",0)
	if (i==0 || i==-1 || etext.charAt(elen-1)=='.')
 		return true;
	if ( etext.charAt(0)=='-' ||  etext.charAt(elen-1)=='-')
 		return true;
	if ( etext.charAt(0)=='_' ||  etext.charAt(elen-1)=='_')
 		return true;
	for (i=0;i<=elen-1;i++)
		{ aa=etext.charAt(i)
 		 if (!((aa=='.') || (aa=='@') || (aa=='-') ||(aa=='_') || (aa>='0' && aa<='9') || (aa>='a' && aa<='z') || (aa>='A' && aa<='Z')))
   			return true;
		}
	return false;
}