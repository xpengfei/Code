<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,java.util.ArrayList" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	
	<head>
		<style>
			body{
				background-image:url(11.jpg);
				background-size:cover;
			}
		</style>
	</head>
	<title>个人用户</title>
	<body>
		<script type="text/javascript">
				function validate(){
					pid=document.privatemain.query.value;
					if(pid==""){
						alert("请输入公众号id!");
						document.privatemain.query.focus();
						return;
					}
					document.privatemain.submit();
				}
		</script>
		<form name="privatemain"   action="http://172.31.75.246/S2014150305/weChat/private.jsp">
			
			<table align="right" border="0" >
				<tr>
				</tr>
				<tr>	
					<td align="left">
						<a href="weChat.jsp">注销</a>
					</td>
					<td bgcolor="FFFF93">
						<a href="recommed.jsp">公众号推荐</a>
					</td>
				</tr>
			</table>
			<table align="center" border="0" rules="none" cellspacing="0">
				<tr>
					<td align="center">
						<font color="#FF0000" size="6" align="center">普通用户:
						<%
							ArrayList Uname=(ArrayList)session.getAttribute("Uname");
							if(Uname.size()>0){
								for(int i=0;i<Uname.size();i++){
									String act=(String)Uname.get(i);
									out.println(act);
								}
							}
							
						%>
						</font>
					</td>
				</tr>
			</table>
			<hr>
			<table align="left" border="0" rules="none" cellspacing="0">
				<tr>
					<td>
						已订阅的公众号信息:
					</td>
					
				</tr>
			</table>

			<table align="right" border="0" rules="none" cellspacing="0">
				<tr>
					<td align="right">
					  公众号ID:
				    </td>
					<td align="left">
						<input name="query"  type="text">
					</td>
					<td>
						<input type="button" onclick="validate()" value="查阅">
					</td>
				</tr>
			</table>		
		</form>
		<%
			String account="";				//获取当前用户名;
			ArrayList<String>ID=new ArrayList<String>();		//存储订阅的公众号的ID;
			for(int i=0;i<Uname.size();i++){
				account=(String)Uname.get(i);
			}
			
			request.setCharacterEncoding("UTF-8");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			
			Statement state=connection.createStatement();				//获取订阅的公众号ID信息;
			String sql="SELECT 用户名,订阅 FROM weChatPrivate";
			ResultSet resultset=state.executeQuery(sql);      //查询
			while(resultset.next()){
				String name=resultset.getString("用户名");
				if(name.equals(account)){				
					String orderNum=resultset.getString("订阅");
					char array[]=orderNum.toCharArray();
					if(orderNum.length()>0){
						int j=0;
						String flag="";
						for(int i=0;i<array.length;i++){
							
							if(array[i]=='-'){
								ID.add(flag);
								flag="";
								
							}else{
								flag+=array[i];				
							}
						}
					}
					
				}
			}
			state.close();
			Statement state1=connection.createStatement();				//获取已经订阅的公众号的基本信息;
			String sql2="SELECT id,用户名 FROM weChatPublic";
			%>
			<br>
			<br>
			<table align="center" border="1" width="600" rules="none" cellspacing="0">
				<tr>
					<td width="300">
						公众号ID		
					</td> 
					<td width="300">
						公众号名称	
					</td>
				</tr>
			</table>	
			<%
			
			for(int i=0;i<ID.size();i++){
				ResultSet resultset1=state1.executeQuery(sql2);      //查询
				while(resultset1.next()){					
					String publicId=resultset1.getString("id");
					if(publicId.equals(ID.get(i))){		//在公众号中查找已经订阅的,并将其输出,---------待测试
		%>
					<table align="center" border="1" width="600" rules="none" cellspacing="0">
						<tr>
							<td width="300">
								<%
								out.print(resultset1.getString("id"));
								%>
							</td>
							<td width="300">
								<%
								out.print(resultset1.getString("用户名"));
								%>
							</td>
						</tr>
					</table>	
		<%
					}
				}
			}
			state1.close();
			
			String query=request.getParameter("query");							//获取要查询的公众号ID;
			int Result=0;		
			Statement statequery=connection.createStatement();
			String querysql="SELECT 账号 FROM publicContent order by 发布时间 desc";
			ResultSet queryRs=statequery.executeQuery(querysql);
			while(queryRs.next()){
				String QAccount=queryRs.getString("账号");
				if(QAccount.equals(query)){
					response.sendRedirect("http://172.31.75.246/S2014150305/weChat/detail.jsp?QACCOUNT="+QAccount);
					Result++;
					break;
				}
			}
			if(Result==0){
				%>		
				<script type="text/javascript">											
					alert("该公众号未发布文章或不存在!");												
				</script>						
				<%
			}
			connection.close();
		%>
	</body>
	
</html>
