<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<html>
	
	<head>
		<style>
			body{
				background-image:url(welcome.gif);
				background-size:cover;
			}
		</style>
		<style type="text/css">
			td {
				border:none;
			}

		</style>
	</head>
	<title>Welcome</title>
	<body>
		<table align="center">
			<tr>
				<td align="center">
					<font color="#FF0000" size="6" align="center">用户:
					<%
						ArrayList Uname=(ArrayList)session.getAttribute("Uname");
						for(int i=0;i<Uname.size();i++){
							String act=(String)Uname.get(i);
							out.println(act);
						}
						
					%>
					已登录!<BR>
					</font>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href="registerLogin.jsp">返回登录界面</a>
				</td>
			</tr>
		</table>
		<form name="mainform"   action="http://172.31.75.246/S2014150305/welcome.jsp">
		
		
		</form>
		
	</body>
	
</html>
