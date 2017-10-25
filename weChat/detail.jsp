<%@ page contentType="text/html; charset=utf-8" language="java"
 import="java.sql.*,
		 java.text.DateFormat,
         java.text.SimpleDateFormat,
         java.util.Date,
		 java.sql.Connection,
		 java.sql.Statement,
		 java.sql.ResultSet"
 errorPage="" %>
<html>
	<head>
		<style>
			body{
				background-image:url(9.jpg);
				background-size:cover;
			}
		</style>
	</head>
	<body>
		<title>推送</title>
		<script type="text/javascript">
				function validate(){
					pid=document.main.query.value;
					if(pid==""){
						alert("请输入文章id!");
						document.main.query.focus();
						return;
					}
					document.main.submit();
				}
		</script>
		
		<form name="main" action="http://172.31.75.246/S2014150305/weChat/detail.jsp">
			<table align="left" border="0" width="800">
					<tr>
						<td align="left">
						  <font size="8">发布文章信息:</font>
						</td>
					</tr>
			</table>	
			<table align="right" border="0">
					<tr>
						<td align="right">
						  文章ID:
						</td>
						<td align="left">
							<input name="query"  type="text">
						</td>
						<td>
							<input type="button" onclick="validate()" value="查看文章">
						</td>
					</tr>
					<tr>
						<td  colspan="3" align="right">
						  <a href="private.jsp">返回</a>
						</td>
					</tr>
					
			</table>		
		
		</form>
		
		<table align="center" border="1" width="800" rules="none" cellspacing="0">
				<tr>
					<td width="300">
						文章标题	
					</td>
					<td width="200">
						文章ID	
					</td>
					<td width="300">
						发布时间	
					</td>
				</tr>
		</table>
		<%
			String passid=request.getParameter("QACCOUNT");
			request.setCharacterEncoding("UTF-8");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			Statement state=connection.createStatement();
			String sql="SELECT 账号,标题,发布时间,id FROM publicContent";
			ResultSet rsMs=state.executeQuery(sql);
			while(rsMs.next()){
				String accountid=rsMs.getString("账号");
				if(accountid.equals(passid)){
					%>
					
					<table align="center" border="1" width="800" rules="none" cellspacing="0">
						<tr>
							<td width="300">								
								<% out.print(rsMs.getString("标题")); %>							
							</td>
							<td width="200">								
								<% out.print(rsMs.getString("id")); %>							
							</td>
							<td width="300">
								<% out.print(rsMs.getString("发布时间")); %>
							</td>
						</tr>
					</table>
					<%
					
				}
				
			}
			state.close();
			
			
			Statement state1=connection.createStatement();
			String sql2="SELECT 账号,标题,发布时间,id FROM publicContent";
			ResultSet rsMs1=state1.executeQuery(sql2);
			String messageId=request.getParameter("query");
			while(rsMs1.next()){
				String textId=rsMs1.getString("id");
				if(textId.equals(messageId)){
					response.sendRedirect("http://172.31.75.246/S2014150305/weChat/display.jsp?textId="+textId);
				}
			}
			state1.close();
			
			connection.close();
		
		%>
	</body>
</html>
