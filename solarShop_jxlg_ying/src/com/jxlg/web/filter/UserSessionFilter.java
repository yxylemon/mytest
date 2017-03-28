package com.jxlg.web.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

public class UserSessionFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		 // 不拦截的url  
		String[] notFilter = new String[] {"/index.jsp","/register.jsp","Login","register","getCode","getCode2","checkCode"};  
  
        // 请求的url  
        String url = request.getRequestURI();  
          
        if((url.indexOf("action") != -1)||(url.indexOf("views") != -1)){  
            boolean doFilter = chek(notFilter,url);  
            if(doFilter){  
                Object obj = request.getSession().getAttribute("user");  
                if(null==obj){  
                    // 如果session中不存在登录者实体，则弹出框提示重新登录  
                    PrintWriter out = response.getWriter();  
                    String loginPage = request.getContextPath()+"/login.jsp";  
                    StringBuilder builder = new StringBuilder();  
                    builder.append("<script type=\"text/javascript\">");  
                    builder.append("window.top.location.href='");  
                    builder.append(loginPage);  
                    builder.append("';");  
                    builder.append("</script>");  
                    out.print(builder.toString());  
                }else {  
                    filterChain.doFilter(request, response);  
                }  
            }else{  
                filterChain.doFilter(request, response);  
            }  
        }else{  
            filterChain.doFilter(request, response);  
        }  
    }  
      
  
    public boolean chek(String[] notFilter,String url){  
     
        //含有notFilter中的任何一个则不进行拦截  
        for (String s : notFilter) {  
            if (url.indexOf(s) != -1) {  
                return false;  
            }  
        }  
        return true;  
    }  

}

