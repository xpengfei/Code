<%@ page contentType="text/html; charset=utf-8" language="java"
 import="java.sql.*,
		 java.text.DateFormat,
         java.text.SimpleDateFormat,
         java.util.Date,
		 java.sql.Connection,
		 java.sql.Statement,
		 java.sql.ResultSet"
 errorPage="" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
		<%
			request.setCharacterEncoding("UTF-8");
			for(int i=0;i<Uname.size();i++){
				account=(String)Uname.get(i);
				Uname.remove(account);
			}						
			if(Uname.size()==0){
				response.sendRedirect("http://172.31.75.246/S2014150305/weChat/weChat.jsp");
			}
		%>
		
	</body>
	
	
</html>