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
	
	<style>
		body{
			background-image:url(message.jpg);
			background-size:cover;
		}
	</style>
	<body>
		<form name="mainform"   action="http://172.31.75.246/S2014150305/board/managerMesBoard.jsp">
		<label align="center" width="800" border="1">
			<tr>
				<td width="600" align="center">
					<font color="#000099" size="8" >留言信息管理:</font>
				</td>
				<td width="200" align="right">
					<a href="main.jsp">返回</a>
				<td>
			</tr>
		</label>
		</form>
		<hr size="2">
		<%
			request.setCharacterEncoding("UTF-8");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			Statement state=connection.createStatement();
			String sql2="SELECT name,time,contant,reply,replytime,id FROM message order by  time desc";
			ResultSet resultset=state.executeQuery(sql2);
			
			while(resultset.next()){
				%>
				<table align="center" width="600" border="1" rules="none">
					<tr height="30">
						<td width="40" align="left">
							<% out.print(resultset.getString("name"));%>
						</td>
						<td width="200" align="right">
							id:<% out.print(resultset.getString("id"));%>
							time:<% out.print(resultset.getString("time"));%>
						</td>
					</tr>
					<tr height="30">
						<td align="left">
						留言内容:
						</td>
						<td>
							<%out.print(resultset.getString("contant"));%>
						</td>
					</tr>
					<tr height="30">
						<td align="left">
							<a href="delete.jsp">删除</a>
						</td>
						<td align="right">
							<a href="reply.jsp">回复</a>
						</td>
					</tr>				
				
				<%		
				if(resultset.getString("reply")!=null)
				{%>
					<tr height="30">
						<td width="300" align="left">
							管理员回复:<%out.print(resultset.getString("replytime"));%>
						</td>
						<td width="300" align="right">
							<%out.print(resultset.getString("replytime"));%>
						</td>
					</tr>
					<tr height="30">
						<td width="300" colspan="2 align="left">
							<% out.print(resultset.getString("reply")); %>
						</td>
					</tr>			
				</table>
				<%	
				}
			}
			state.close();
			connection.close();
		%>
		
	</body>
	
	
</html>