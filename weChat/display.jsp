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
		<title>文章</title>	
		
			<table align="right" border="0">					
				<tr>
					
					<td align="right">
					  <a href="private.jsp">返回</a>
					</td>
				</tr>
			</table>		
		
		<%
			String textID=request.getParameter("textId");
			request.setCharacterEncoding("UTF-8");
			String passid=request.getParameter("textId");  //文章ID
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			Statement state=connection.createStatement();
			String sql="SELECT 账号,标题,内容,发布时间,字体大小,id FROM publicContent";
			ResultSet textMs=state.executeQuery(sql);
			while(textMs.next()){
				String accountid=textMs.getString("id");			//文章ID
				if(accountid.equals(passid)){
					%>
					
					<table align="center" border="0" width="800">
						<tr align="center">
							<td>
								<% out.println(textMs.getString("标题")); %>
							</td>
						</tr>
					</table>					
					<font size="<% out.print(textMs.getString("字体大小")); %>">
					
								<% out.print(textMs.getString("内容")); %>
					
					</font>
					<%
					
				}			
			}		
			state.close();
		%>
		<br>	
		<table align="right" border="0" width="800">
			<tr align="right">
				<td>
					文章ID:<% out.print(passid);%>      <a href="comment.jsp">评论</a>
				</td>
			</tr>
		</table>	
		<%
			
		Statement state2=connection.createStatement();
		String sql2="SELECT textID,userName,comment,reply,commentTime,replyTime,xianshi,id FROM comment";
		ResultSet txt=state2.executeQuery(sql2);
		while(txt.next()){
			String judge=txt.getString("xianshi");		//是否显示
			String txtID=txt.getString("textID");		//文章ID
			if(txtID.equals(passid)){
				if(judge!=null){
					%>
					<table width="800" align="center" border="1" rules="none" cellspacing="0">
					
						<tr >
							<td >
							<%out.print(txt.getString("userName"));  %>
							</td>
							<td align="right">									
							<% out.print(txt.getString("commentTime")); %>
							</td>
						</tr>
						<tr >
							<td >
							评论:<% out.print(txt.getString("comment")); %>
							</td>
						</tr>
					
						<%
							if(txt.getString("reply")!=null){
								%>
				
						<tr >
							<td>
							作者回复:
							</td>
							<td align="right">
							<% out.print(txt.getString("replyTime") );%>
							</td>
						</tr>
						<tr >
							<td colspan="2">
							<% out.print(txt.getString("reply")); %>
							</td>
						</tr>
					
								<%
							}
						%>
						
					</table>
					<%
				}
			}
			
		}
		connection.close();
		%>
	</body>
</html>
