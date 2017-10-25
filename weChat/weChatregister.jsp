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
	<head>
		<style>
		html,body{text-align:center}
		</style>
	</head>
		<style>
			body{
				background-image:url(register.jpg);
				background-size:cover;
			}
		</style>
		<title>注册</title>
	<body>
		<script type="text/javascript">
			function validate(){
				reAccount=document.register.Account.value;
				rePassword=document.register.Password.value;
				checkPsw=document.register.RePassword.value;
				if(reAccount=="" && rePassword=="" && checkPsw==""){
					alert("账号不能为空!");
					document.register.reAccount.focus();
					return;
				}
				else if(reAccount!="" && rePassword=="" && checkPsw==""){
					alert("密码不能为空!");
					document.register.rePassword.focus();
					return;
				}
				else if(reAccount!="" && rePassword!=""){
					if(checkPsw=="")
					{
						alert("请输入确认密码!");
						document.register.checkPsw.focus();
						return;
					}
					else{
						if(rePassword!=checkPsw){
							alert("两次密码输入不一致!");
							document.register.checkPsw.focus();
							return;
						}
					}
				}
				document.register.submit();
			}
		</script>
		<form name="register" action="http://172.31.75.246/S2014150305/weChat/weChatregister.jsp">
			<table width="400" border="0" align="center" valign="middle">
				<tr>
					<td width="100" align="right"><font color="FF0000">*</font>类别: </td>
					<td width="300" align="left">
						<select name="accountType">
							<option value="普通用户">普通用户</option>
							<option value="公众号用户">公众号用户</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="100" align="right">
						<font color="FF0000">*</font>
						用户名:
					</td>
					<td width="300" align="left">
						<input placeholder="字母或数字组成" name="Account" type="text">
					</td>
				</tr>
				<tr height="15"></tr>
				<tr>
					<td width="100" align="right">
						<font color="FF0000">*</font>
						设置密码:
					</td>
					<td width="300" align="left">
						<input name="Password" type="password">
					</td>
				</tr>
				<tr height="15"></tr>
				<tr>
					<td width="100" align="right">
						<font color="FF0000">*</font>
						确认密码:
					</td>
					<td width="300" align="left">
						<input name="RePassword" type="password">
					</td>
				</tr>
				<tr height="15"></tr>
				<tr >
					<td width="200" align="center" colspan="2">
						<input type="reset" value="重置">
						<input type="button" value="提交" onclick="validate()">
						<a href="weChat.jsp">返回</a>
					</td>
				</tr>
			</table>

		</form>
		<br>
		<font Size="4" color="#FF0000">
		<%
			request.setCharacterEncoding("UTF-8");
			String name=request.getParameter("Account");
			String pasw=request.getParameter("Password");
			String usertype=request.getParameter("accountType");
			
			String newPasw="";
			if(pasw!=null){
				char ch[]=pasw.toCharArray();	//对密码进行加密
				for(int i=0;i<ch.length;i++){
					ch[i]=(char)(ch[i]^'q');
				}
				newPasw=new String(ch);
			}
			
			
			int flag=-1;
			String currentTime;
			Date date=new Date();
			DateFormat forMat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			currentTime=forMat.format(date);
			
			
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement state=connection.createStatement();
			
			String sql2;
			if("普通用户".equals(usertype)){
				sql2="SELECT 用户名 FROM weChatPrivate Order By 注册时间 desc";
			}else if("公众号用户".equals(usertype)){
				sql2="SELECT 用户名 FROM weChatPublic Order By 注册时间 desc";
			}else{
				sql2="";
			}
			
			
			if(!sql2.equals("")){
				ResultSet resultset=state.executeQuery(sql2);
				while(resultset.next()){
					String s=resultset.getString("用户名");
					if(s.equals(name)){
						out.print("该用户名已被注册!");
						flag++;
						break;
					}
					out.println(""+name);
				}
			}
				
			
			state.close();
			if(flag==-1){
				Class.forName("com.mysql.jdbc.Driver");
				String sql;
				if("普通用户".equals(usertype)){
					sql="INSERT INTO weChatPrivate(用户名,密码,注册时间) VALUES(?,?,?)";
				}else if("公众号用户".equals(usertype)){
					sql="INSERT INTO weChatPublic(用户名,密码,注册时间) VALUES(?,?,?)";
				}else{
					sql="";
				}
				if(!sql.equals("")){
					PreparedStatement preSta=connection.prepareStatement(sql);
					preSta.setString(1,name);
					preSta.setString(2,newPasw);
					preSta.setString(3,currentTime);
					if(name!=null){
						preSta.executeUpdate();
					}
					preSta.close();
				
				}
				
				
			}
			connection.close();
	
		%>
		</font>
	</body>
</html>