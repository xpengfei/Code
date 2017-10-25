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
		<title>留言筛选</title>	
		
		<script type="text/javascript">
			function validate(){
				id=document.main.adapt.value;				
				if(id==""){
					alert("Id不能为空!");
					document.mainform.Name.focus();
					return;
				}
				document.main.submit();
			}
		</script>
		<form name="main" action="http://172.31.75.246/S2014150305/weChat/showComment.jsp?textId="+request.getParameter("textId"))>
			<table align="left" border="0" width="800" >					
				<tr>
					<td align="left" >
						<font size="8">评论信息:</font>
					</td>

				</tr>
			</table>
		
			<table align="right" border="0">					
				<tr>
					<td align="right">
					 评论Id:<input name="adapt" type="text">
							<input type="button" onclick="validate()" value="显示">
					  <a href="commentManage.jsp">返回</a>
					</td>

				</tr>
			</table>	
		</form>
		
		<%
			request.setCharacterEncoding("UTF-8");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			
			String getTextID=request.getParameter("textId");
			Statement state=connection.createStatement();
			String sql="SELECT textID,userName,commentTime,reply,replyTime,comment,id FROM comment";
			ResultSet rsMs=state.executeQuery(sql);
			while(rsMs.next()){
				String textID=rsMs.getString("textID");
				if(textID.equals(getTextID)){
					%>
					<table width="800" align="center" border="1" rules="none" cellspacing="0">
						<tr bgcolor="FF9224">
							<td >
							<%out.print(rsMs.getString("userName"));  %>
							</td>
							<td align="right">
							ID:<% out.print(rsMs.getString("id")); %>
			
							Time:<% out.print(rsMs.getString("commentTime")); %>
							</td>
						</tr>
						<tr bgcolor="FF9224">
							<td colspan="2">
							评论内容:<% out.print(rsMs.getString("comment")); %>
							</td>
						</tr>
						<tr bgcolor="FF9224">
							<td align="left">
								<a href="deletecomment.jsp">删除</a>
							</td>
							<td align="right">
								<a href="commentreply.jsp">回复</a>
							</td>
						</tr>
						<%
							if(rsMs.getString("reply")!=null){
								%>
						<tr bgcolor="9AFF02">
							<td>
							作者回复:
							</td>
							<td align="right">
							回复时间:<% out.print(rsMs.getString("replyTime") );%>
							</td>
						</tr>
						<tr bgcolor="9AFF02">
							<td colspan="2">
							<% out.print(rsMs.getString("reply")); %>
							</td>
						</tr>
								<%
							}
						%>
						
					</table>
					<%
				}				
			}
			state.close();
			
			Statement state1=connection.createStatement();
			String sqll="SELECT textID,id,xianshi FROM comment";
			ResultSet rsMs1=state1.executeQuery(sqll);
			int flag=0;
			String flagID="";
			while(rsMs1.next()){
				String adapt=request.getParameter("adapt");
				String line=rsMs1.getString("id");
				flagID=rsMs1.getString("textID");
				if(adapt!=null){
					if(adapt.equals(line)){
						int num=Integer.parseInt(line);					
						String Sql="UPDATE comment SET xianshi='"+adapt+"' WHERE id="+num+"";//更新
						int i=state1.executeUpdate(Sql);
						flag++;
						break;
					}
				}									
			}
			if(flag!=0){
				response.sendRedirect("http://172.31.75.246/S2014150305/weChat/showComment.jsp?textId="+flagID);				
			}
			state1.close();
		connection.close();
		
		%>
	</body>
</html>
