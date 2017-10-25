<%@ page contentType="text/html; charset=utf-8" language="java"
 import="java.sql.*,
		 java.sql.Connection,
		 java.sql.Statement,
		 java.sql.ResultSet,
		 java.util.ArrayList"
 errorPage="" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<html>
	
	<head>
	<style>
		body{
			background-image:url(login.jpg);
			background-size:cover;
			text-align:center;
			
		}
	</style>
		<style type="text/css">
			td {
				border:none;
			}
			#lay{
				position:fixed;
				bottom:300px;
				right:300px;
			}

		</style>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>登录</title>
	</head>
	<body>
		<script type="text/javascript">
			function validate(){
				jaccount=document.mainform.Account.value;
				jpassword=document.mainform.PassWord.value;
				if(jaccount=="" && jpassword==""){
					alert("账号不能为空!");
					document.mainform.Account.focus();
					return;
				}
				else if(jaccount!="" && jpassword==""){
					alert("密码不能为空!");
					document.mainform.PassWord.focus();
					return;
				}
				else if(jaccount=="" && jpassword!=""){
					alert("账号不能为空!");
					document.mainform.Account.focus();
					return;
				}
				document.mainform.submit();
			}
		</script>
		
		<form name="mainform"   action="http://172.31.75.246/S2014150305/weChat/weChat.jsp">
		
		<p align="center">
		<div id="lay">
			<table width="400" align="center" valign="middle" border="0">
				<tr>
					<td width="100" align="right">类别: </td>
					<td width="300" align="left">
						<select name="accountType">
							<option value="普通用户">普通用户</option>
							<option value="公众号用户">公众号用户</option>
						</select>
					</td>
				<tr>
				<tr>
					<td width="100" align="right">账号: </td>
					<td width="300" align="left">
					<input placeholder="字母或数字组成" name="Account" type="text"></td>
				<tr>
				<tr>
					<td width="100" align="right">密码:</td>
					<td width="300" align="left">
					<input name="PassWord" type="password"></td>
				</tr>
				<tr>
					<td width="200" align="center" colspan="2">
					<input type="reset" value="重置">
					<input type="button" onclick="validate()" value="登录">
					<a href="weChatregister.jsp">注册</a>
					</td>
				</tr>
				
			</table>
		
		</p>
		</form>
		<font color="#FF2D2D" align="center">
			<%
			request.setCharacterEncoding("UTF-8");
			String account=request.getParameter("Account");
			String Apassword=request.getParameter("PassWord");
			String usertype=request.getParameter("accountType");
			ArrayList Uname=new ArrayList();
			session.setAttribute("Uname",Uname);

			
			String newPasw="";
			if(Apassword!=null){
				char ch[]=Apassword.toCharArray();	//对密码进行加密
				for(int i=0;i<ch.length;i++){
					ch[i]=(char)(ch[i]^'q');
				}
				newPasw=new String(ch);
			}
			
			int flag=0;
			int num=0;
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement state=connection.createStatement();
			String sql3="";
			if("普通用户".equals(usertype)){
				 sql3="SELECT 用户名,密码 FROM weChatPrivate Order By 注册时间 desc";
				 ResultSet resultset=state.executeQuery(sql3);
				while(resultset.next()){
					String s=resultset.getString("用户名");
					String ps=resultset.getString("密码");
					if(s.equals(account) && ps.equals(newPasw)){		//成功登录
						response.sendRedirect("http://172.31.75.246/S2014150305/weChat/private.jsp");
						account=new String(account.getBytes("ISO-8859-1"), "UTF-8");
						Uname.add(account);
						
					}
					else if((s.equals(account) && !ps.equals(newPasw)) || (!s.equals(account) && ps.equals(newPasw))){
						out.println("用户名或密码错误!");
						flag=0;
						break;						
					}				
					if(!s.equals(account)){
						num++;
					}				
					flag++;	
				}
			}
			else if("公众号用户".equals(usertype)){
				sql3="SELECT 用户名,密码 FROM weChatPublic Order By 注册时间 desc";
				ResultSet resultset=state.executeQuery(sql3);
				while(resultset.next()){
					String s=resultset.getString("用户名");
					String ps=resultset.getString("密码");
					if(s.equals(account) && ps.equals(newPasw)){		//成功登录
						response.sendRedirect("http://172.31.75.246/S2014150305/weChat/public.jsp");			
						account=new String(account.getBytes("ISO-8859-1"), "UTF-8");
						Uname.add(account);	
					}
					else if((s.equals(account) && !ps.equals(newPasw)) || (!s.equals(account) && ps.equals(newPasw))){
						out.println("用户名或密码错误!");
						flag=0;
						break;
						
					}				
					if(!s.equals(account)){
						num++;
					}				
					flag++;	
				}	
			}
			if(flag==num && account!=null){
				out.println("该用户不存在!");
			}			
			state.close();
			connection.close();		
		%>
		</font>
		</div>
	</body>
	
</html>
