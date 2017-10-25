<%@ page contentType="text/html; charset=utf-8" language="java"
 import="java.sql.*,
		 java.text.DateFormat,
         java.text.SimpleDateFormat,
         java.util.Date,
		 java.sql.Connection,
		 java.sql.Statement,
		 java.util.ArrayList,
		 java.sql.ResultSet"
 errorPage="" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	
	<style>
		body{
			background-image:url(9.jpg);
			background-size:cover;
		}
	</style>
	<title>评论管理</title>
	<body>
		<script type="text/javascript">
			function Search(){
				tID=document.mainform.textId.value;
				if(tID==""){
					alert("输入不能为空!");
					document.mainform.textId.focus();
					return;
				}
				document.mainform.submit();
			}
		</script>
		<form name="mainform"   action="http://172.31.75.246/S2014150305/weChat/commentManage.jsp">
		<table align="center" width="1200" border="0">
			<tr>
				<td width="600" align="left">
					<font color="#000099" size="8" >评论信息管理:</font>
				</td>
				<td  width="200" align="right">
					<font color="#000099" size="4" >请输入文章ID:</font>
				</td>
				<td width="300">
					<input name="textId" type="text">
					<input type="button" onclick="Search()" value="查看评论">
				</td>
				<td width="100" align="right">
					<a href="public.jsp">返回</a>
				</td>
			</tr>
		</table>
		</form>
		<hr size="2">
		<%
			String account="";
			String Accountid="";		//公众号ID
			ArrayList Uname=(ArrayList)session.getAttribute("Uname");
			if(Uname.size()>0){
				for(int i=0;i<Uname.size();i++){
					account=(String)Uname.get(i);
				}	
			}else if(Uname==null){
				%>
				<script type="text/javascript">
					alert("你已掉线,请重新登录!");
				</script>
				<%
				response.sendRedirect("http://172.31.75.246/S2014150305/weChat/weChat.jsp");
			}
			
			
			request.setCharacterEncoding("UTF-8");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			
			Statement Astate=connection.createStatement();
			String Asql="SELECT 用户名,id FROM weChatPublic";
			ResultSet ArsMs=Astate.executeQuery(Asql);
			while(ArsMs.next()){
				String AAccount=ArsMs.getString("用户名");
				if(AAccount.equals(account)){
					Accountid=ArsMs.getString("id");
				}
			}
			Astate.close();
			
			Statement state=connection.createStatement();
			String sql="SELECT 账号,标题,发布时间,id FROM publicContent";
			ResultSet rsMs=state.executeQuery(sql);
			%>
				<table align="center" border="1" width="800" rules="none">
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
			String pTextID="";
			while(rsMs.next()){
				String accountid=rsMs.getString("账号");
				if(accountid.equals(Accountid)){
					%>
					
					<table align="center" border="1" width="800" rules="none">
						<tr>
							<td width="300">								
								<% out.print(rsMs.getString("标题")); %>							
							</td>
							<td width="200">								
								<% 
								pTextID=rsMs.getString("id");
								out.print(pTextID);

								%>							
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
			String sql2="SELECT textID,comment,id FROM comment";
			ResultSet rsMs1=state1.executeQuery(sql2);
			String messageId=request.getParameter("textId");
			if(messageId!=null){
				int commentFlag=0;
				while(rsMs1.next()){
					String textId=rsMs1.getString("textID");
					if(textId.equals(messageId)){
						response.sendRedirect("http://172.31.75.246/S2014150305/weChat/showComment.jsp?textId="+textId);
						commentFlag++;
						break;
					}
				}
				if(commentFlag==0){
					%>
					<script type="text/javascript">
					alert("ID为"+<%out.print(messageId);%>+"的文章不存在或暂无评论!");
					</script>
					<%
				}
			}
			state1.close();
			
			connection.close();
		
		%>
		
	</body>
	
	
</html>