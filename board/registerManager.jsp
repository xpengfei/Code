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
				background-image:url(4.jpg);
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
		<form name="register" action="http://172.31.75.246/S2014150305/board/registerManager.jsp">
			<table width="400" border="0" align="center" valign="middle" style="margin:20% 20% 0 50%">
				
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
						<a href="login.jsp">返回</a>
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

			String newPasw="";
			if(pasw!=null){
				char ch[]=pasw.toCharArray();	//对密码进行加密
				for(int i=0;i<ch.length;i++){
					ch[i]=(char)(ch[i]^'q');
				}
				newPasw=new String(ch);
			}
			
			String currentTime;
			Date date=new Date();
			DateFormat forMat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			currentTime=forMat.format(date);
			
			
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement state=connection.createStatement();
			String sql="SELECT MAccount FROM manager";
			ResultSet rs=state.executeQuery(sql);
			int judge=-1;
			
			while(rs.next()){
				
				String checkname=rs.getString("MAccount");
				if(checkname.equals(name)){
					%>
					<script type="text/javascript">											
					alert("该用户名已被注册!");												
					</script>
					<%	
					judge++;
					break;
				}			
			}
			state.close();
			
			if(judge==-1){			//未被注册过;
				String sql2="INSERT INTO manager(MAccount,MPassword,RegisterTime)VALUES(?,?,?)";
				PreparedStatement preSta=connection.prepareStatement(sql2);
				preSta.setString(1,name);
				preSta.setString(2,newPasw);
				preSta.setString(3,currentTime);
				if(name!=null){
					preSta.executeUpdate();
				}
				preSta.close();
			}		
			
			connection.close();
		%>
		</font>
	</body>
</html>