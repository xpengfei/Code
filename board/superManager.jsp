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
	<style>
		body{
			background-image:url(11.jpg);
			background-size:cover;
			text-align:center;
		}
	</style>
	<body>
		<title>添加管理员</title>	
		<script type="text/javascript">
			function validate(){
				aid=document.main.apply.value;
				if(aid==""){
					alert("输入不能为空!");
					document.main.apply.focus();
					return;
				}
				document.main.submit();
			}
		</script>
		<form name="main" action="http://172.31.75.246/S2014150305/board/superManager.jsp">
			<font size="8">
			申请者信息:
			</font>
			<table align="right" border="0">
				<tr>
					<td colspan="2">
					 id:<input name="apply" type="text">
						<input name="yn" type="radio" value="usual" checked>审核通过
						<input name="yn" type="radio" value="no">撤销身份
						 <input type="button" value="确定" onclick="validate()">
					</td>
				</tr>
				<tr>
					<td align="right" colspan="3">
					  <a href="login.jsp">返回</a>
					</td>
				</tr>
			</table>	
		</form>
			<hr size="2">
			<table align="center" border="1" width="800" rules="none" cellspacing="0" bgcolor="FF9224">
				<tr align="center">	
					<td width="200">
						<% out.println("用户名"); %>
					</td>
					<td width="200">
						<% out.println("申请时间"); %>
					</td>
					<td width="200">
						<% out.println("当前身份"); %>
					</td>
					<td width="200">
						<% out.println("ID"); %>
					</td>
							
							
				</tr>
			</table>				
		
		<%
			
			request.setCharacterEncoding("UTF-8");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			Statement state=connection.createStatement();			
			String sql="SELECT MAccount,RegisterTime,leavel,id FROM manager";
			ResultSet rs=state.executeQuery(sql);
			while(rs.next()){
				String Aleavel=rs.getString("leavel");			//等级
				
				if(Aleavel==null || Aleavel.equals("") || Aleavel.equals("no")){
					%>					
					<table align="center" border="1" width="800" rules="none" cellspacing="0" bgcolor="FF9224">
						<tr align="center">
							<td width="200">
								<% out.println(rs.getString("MAccount")); %>
							</td>
							<td width="200">
								<% out.print(rs.getString("RegisterTime")); %>
							</td>
							<td width="200">
								<% 
								out.print("申请者");
								%>
							</td>
							<td width="200">
								<% 
								out.print(rs.getString("id"));
								%>
							</td>
							
							
						</tr>
					</table>																		
					<%					
				}else if(Aleavel.equals("usual")){
					%>					
					<table align="center" border="1" width="800" rules="none" cellspacing="0" bgcolor="9AFF02">
						<tr align="center">
							<td width="200">
								<% out.println(rs.getString("MAccount")); %>
							</td>
							<td width="200">
								<% out.print(rs.getString("RegisterTime")); %>
							</td>
							<td width="200">
								<% 
								out.print("管理员");
								%>
							</td>
							<td width="200">
								<% out.print(rs.getString("id")); %>
							</td>
						</tr>
					</table>																		
					<%	
				}		
			}		
			state.close();	
			String Apply=request.getParameter("apply");		//申请者id
			String YN=request.getParameter("yn");			//结果usual/no

			String admit="usual";
			String deny="no";
			Statement state2=connection.createStatement();			
			String sql2="SELECT MAccount,RegisterTime,leavel,id FROM manager";
			ResultSet rs2=state2.executeQuery(sql2);
			int flag=0;
			while(rs2.next()){
				String changeID=rs2.getString("id");			//表中id
				String leavelType=rs2.getString("leavel");		//身份信息
				Statement state3=connection.createStatement();
				if(!"".equals(Apply)){
					if(changeID.equals(Apply)){
						if(leavelType==null || leavelType.equals("") || leavelType.equals(deny)){
							int num=Integer.parseInt(changeID);
							String sql3="UPDATE manager SET leavel='"+YN+"'WHERE id="+num+"";
							int i=state3.executeUpdate(sql3);
							state3.close();
							flag++;
							break;
						}else if(!leavelType.equals("") && leavelType.equals(admit)){		//数据库中leavel存储为usual;撤销身份
							int num=Integer.parseInt(changeID);
							String sql3="UPDATE manager SET leavel='"+YN+"'WHERE id="+num+"";
							int i=state3.executeUpdate(sql3);
							state3.close();
							flag++;
							break;
						}					
					}						
				}			
				
			}
			if(flag!=0){
				response.sendRedirect("http://172.31.75.246/S2014150305/board/superManager.jsp");	
			}
					
			state2.close();
		connection.close();
		%>
	</body>
</html>
