<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
	
	<head>
		<style>
			body{
				background-image:url(6.jpg);
				background-size:cover;
			}
		</style>
	</head>
	<title>公众号推荐</title>
	<body>
		<script type="text/javascript">
				function validate(){
					pid=document.recommedMain.subscribe.value;
					if(pid==""){
						alert("订阅号ID不能为空!");
						document.recommedMain.subscribe.focus();
						return;
					}
					document.recommedMain.submit();
				}
		</script>
		<form name="recommedMain"   action="http://172.31.75.246/S2014150305/weChat/recommed.jsp">
			<label align="center" width="600" border="1">
				<tr>
					<td width="600" align="center">
						<font color="#000099" size="8" >公众号信息如下:</font>
					</td>
				</tr>
			</label>
			<table align="right" border="0">
				<tr>
					<td align="right">
					  公众号ID:
				    </td>
					<td align="left">
						<input name="subscribe"  type="text">
					</td>
					<td>
						<input type="button" onclick="validate()" value="订阅">
					</td>
				</tr>
				<tr align="right">
					<td   colspan="3" align="right">
						<a href="private.jsp">返回</a>
					<td>
				</tr>
			</table>
			<hr size="2">
		</form>
		<%
			request.setCharacterEncoding("UTF-8");
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");		
			Statement state=connection.createStatement();
			
			String sql="SELECT id,用户名 FROM weChatPublic";
			ResultSet resultset=state.executeQuery(sql);      //查询
			%>
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
			while(resultset.next()){
		%>
				<table align="center" border="1" width="600" rules="none" cellspacing="0">
					<tr>
						<td width="300">
							<%
							out.print(resultset.getString("id"));
							%>
						</td>
						<td width="300">
							<%
							out.print(resultset.getString("用户名"));
							%>
						</td>
					</tr>
				</table>	
		<%
			}
			state.close();
			Statement state1=connection.createStatement();
			String subscribeID=request.getParameter("subscribe");
			String userName="";
			ArrayList Uname=(ArrayList)session.getAttribute("Uname");
			if(Uname.size()>0){					//获取当前登录的账户名称;
				for(int i=0;i<Uname.size();i++){
					userName=(String)Uname.get(i);
				}
			}
			String userID="";
			String sql2="SELECT id FROM weChatPublic order by 注册时间 desc";
			ResultSet rs=state1.executeQuery(sql2);//查询
			while(rs.next()){						//查询是否存在与输入的id对应的公众号;
				String publicID=rs.getString("id");
				if(publicID.equals(subscribeID)){			//如果输入的订阅id存在,则将该公众号id存储
					String sql3="SELECT id,用户名,订阅 FROM weChatPrivate order by 注册时间 desc";
					
					Statement state2=connection.createStatement();
					ResultSet rs2=state2.executeQuery(sql3);//查询
					while(rs2.next()){						//找到当前用户,将公众号id存储到该用户的订阅中
						String Name=rs2.getString("用户名");
						String uid=rs2.getString("id");
						if(Name.equals(userName)){
							userID=uid;
							String ordered=rs2.getString("订阅");		//获取已订阅的信息;
							int fjudge=0;
							if("".equals(ordered)){			//如尚未订阅任何公众号,则直接进行存储;
								subscribeID+="-";
								
							}else{							//否则,判断是否订阅过,然后决定是否存储;
								char judge[]=ordered.toCharArray();
								String ch="";
								for(int i=0;i<judge.length;i++){
									if(judge[i]=='-'){
										if(ch.equals(subscribeID)){
											fjudge++;
										}
										ch="";
									}else{
										ch+=judge[i];
									}
								}
								if(fjudge==0){			//fjudge=0,则说明当前ID尚未被订阅;
									subscribeID+="-";
									subscribeID+=ordered;
								}else{
									userID="";		//已经订阅过,是数据库无法更新;
									%>
									<script type="text/javascript">											
										alert("你已订阅过该公众号!");												
									</script>
									<%
								}								
							}
							
						}
						
					}
					if(!"".equals(userID)){
						int id=Integer.parseInt(userID);
						String Sql="UPDATE weChatPrivate SET 订阅='"+subscribeID+"' WHERE id="+id+"";//更新	
						int i=state2.executeUpdate(Sql);
					}
					state2.close();
				}
			}
			state1.close();
		%>
		<%
			connection.close();
		%>
	</body>
</html>
