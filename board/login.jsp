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
		body{
			background-image:url(2.jpg);
			background-size:cover;
			text-align:center;
		}
	</style>
		<style type="text/css">
			td {
				border:none;
			}

		</style>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>管理员登录</title>
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
				document.mainform.submit();
			}
		</script>
		
		<form name="mainform"   action="http://172.31.75.246/S2014150305/board/login.jsp">
		<BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<p align="center">
			<table width="400" align="center" valign="middle" border="0">
				<caption><font size="8">管理员登录</font></caption><br><br>
				<tr>
					<td width="150" align="right">账号: </td>
					<td width="250" align="left">
					<input name="Account" type="text"></td>
				<tr>
				<tr>
					<td width="150" align="right">密码:</td>
					<td width="250" align="left">
					<input name="PassWord" type="password"></td>
				</tr>
				<tr >
					<td width="200" colspan="2">
						权限:<input name="power" type="radio" value="usual" checked>普通
							 <input name="power" type="radio" value="super">超级
					</td>
				</tr>
				<tr>
					<td width="200" colspan="2" align="center">
						<a href="registerManager.jsp">申请管理员</a>
						<input type="reset" value="重置">
						<input type="button" onclick="validate()" value="登录">
						
						<a href="main.jsp">返回</a>							
					</td>
				</tr>
				
			</table>
		</p>
		</form>
		<font color="#FF2D2D" align="center">
		<%
			String typeAccount=request.getParameter("power");
			String account=request.getParameter("Account");
			String password=request.getParameter("PassWord");		//获取登录信息
			
			if(password!=null){
				char ch[]=password.toCharArray();	//对密码进行加密
				for(int i=0;i<ch.length;i++){
					ch[i]=(char)(ch[i]^'q');
				}
				password=new String(ch);
			}
			String superName="admire";
			String superPassword="admire";
			
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement state=connection.createStatement();
			String sql="SELECT *FROM manager";
			ResultSet rs=state.executeQuery(sql);					//查询数据库
			while(rs.next()){
				String getAccount=rs.getString("MAccount");
				String getPassword=rs.getString("MPassword");
				String getleavel=rs.getString("leavel");
				if(getAccount.equals(account) && getPassword.equals(password)){
					if(getleavel!=null && getleavel.equals(typeAccount)){
						response.sendRedirect("http://172.31.75.246/S2014150305/board/managerMesBoard.jsp");
					}else if(typeAccount.equals("super")){
						%>
						<script type="text/javascript">											
						alert("账号与权限不符!");												
						</script>
						<%
					}else if(getleavel!=null && getleavel.equals("no")){
						%>
						<script type="text/javascript">											
						alert("该账号尚不是管理员!");												
						</script>
						<%
					}				
				}else if(getAccount==null ){
					%>
						<script type="text/javascript">											
						alert("该账号尚不是管理员!");												
						</script>
						<%
				}
			}
			state.close();
			connection.close();
			if(typeAccount!=null){
				if(password!=null){
					char ch[]=password.toCharArray();	//对密码进行加密
					for(int i=0;i<ch.length;i++){
						ch[i]=(char)(ch[i]^'q');
					}
					password=new String(ch);
				}
				if(typeAccount.equals("super") && account.equals(superName) && password.equals(superPassword)){
					response.sendRedirect("http://172.31.75.246/S2014150305/board/superManager.jsp");
				}else if(typeAccount.equals("usual") && account.equals(superName) && password.equals(superPassword)){
					%>
						<script type="text/javascript">											
						alert("所选权限与账号不符!");														
						</script>
						<%
				}
			}
			
		%>
		</font>
	</body>
	
</html>
