<%@ page contentType="text/html; charset=utf-8" language="java"
 import="java.sql.*,
		 java.text.DateFormat,
         java.text.SimpleDateFormat,
         java.util.Date,
		 java.sql.Connection,
		 java.sql.Statement,
		 java.sql.ResultSet,
		 java.util.ArrayList"
 errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<html>
	
	<head>
		<style>
			body{
				background-image:url(13.jpg);
				background-size:cover;
			}
		</style>
	</head>
	<title>公众号用户</title>
	<body>
		<table align="center" rules="none" cellspacing="0">
			<tr>
				<td align="center">
					<font color="#FF0000" size="6" align="center">公众号用户:
					<%
						ArrayList Uname=(ArrayList)session.getAttribute("Uname");
						if(Uname.size()>0){
							for(int i=0;i<Uname.size();i++){
								String act=(String)Uname.get(i);
								out.println(act);
							}		
						}
										
					%>
					<BR>
					</font>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href="weChat.jsp">注销</a>
				</td>
			</tr>
		<hr>
		</table>
		<hr>
		
		<script type="text/javascript">
			function validate(){
				title=document.mainform.Name.value;
				content=document.mainform.Message.value;
				if(title==""){
					alert("标题不能为空!");
					document.mainform.Name.focus();
					return;
				}else{
					if(content==""){
						alert("文章内容不能为空!");
						document.mainform.Message.focus();
						return;
					}
				}
				document.mainform.submit();
			}
		</script>
		
		<form name="mainform"   action="http://172.31.75.246/S2014150305/weChat/public.jsp">
			<table width="800" align="center" border="1" rules="none" cellspacing="0">
				<tr>
					
					<td width="400" colspan="2" align="center">
						标题:
						<input name="Name" type="text">
						正文字体大小
						<select name="textType">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="60"  align="right" style="vertical-align:top">内容:</td>
					<td width="740" align="left">
						<textarea name="Message" rows="30" cols="80" ></textarea>
					</td>
				</tr>
				<tr>
					<td width="400" colspan="2" align="center">
					
						<input type="reset" value="清空">
						<input type="button" onclick="validate()" value="群发">
						<a href="commentManage.jsp">评论管理</a>
					</td>
				</tr>
			</table>
		</form>
		<%
			request.setCharacterEncoding("UTF-8");
			String title=request.getParameter("Name");		//标题
			String text=request.getParameter("Message");	//文章内容
			String textSize=request.getParameter("textType");
			String account="";
			if(text!=null){
				text = text.replaceAll("&", "&amp;");
				text = text.replaceAll("<", "&lt;");
				text = text.replaceAll(">", "&gt;");
				text = text.replaceAll(" ", "&nbsp;");
				text = text.replaceAll("'", "&#39;");
				text = text.replaceAll("\"", "&quot;");
				text = text.replaceAll("\n", "<br>");
			}
			

			String currentTime;
			Date date=new Date();
			DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			currentTime=format.format(date);
			
			//ArrayList Uname=(ArrayList)session.getAttribute("Uname");
			for(int i=0;i<Uname.size();i++){
				account=(String)Uname.get(i);
			}						
					
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement state=connection.createStatement();
			
			Statement queryid=connection.createStatement();
			String queryIdsql="SELECT id,用户名 FROM weChatPublic";
			ResultSet queryID=queryid.executeQuery(queryIdsql);
			while(queryID.next()){
				String qname=queryID.getString("用户名");
				if(qname.equals(account)){
					String QID=queryID.getString("id");
					account=QID;
					break;
				}
			}
			queryid.close();
			String sql2="SELECT 账号,标题,内容 FROM publicContent Order By 发布时间 desc";
		
			ResultSet resultset=state.executeQuery(sql2);
			int flag=0;
			/*
				添加判断文章标题以及内容时候存储过,
			*/
			while(resultset.next()){
				String s=resultset.getString("账号");
				String s1=resultset.getString("标题");
				String s2=resultset.getString("内容");
				if(s.equals(account) && s1.equals(title) && s2.equals(text)){
					out.print("该文章已经发布过!");
					flag++;
				}
				if(flag!=0)
					break;
			}
			state.close();
			if(flag==0){
				String sql="INSERT INTO publicContent(账号,标题,内容,发布时间,字体大小) VALUES(?,?,?,?,?)";
				PreparedStatement preSta=connection.prepareStatement(sql);
				preSta.setString(1,account);
				preSta.setString(2,title);
				preSta.setString(3,text);
				preSta.setString(4,currentTime);
				preSta.setString(5,textSize);
				if(title!=null){
					preSta.executeUpdate();
				}
				
				preSta.close();
			}			
			
			connection.close();
		%>
	</body>
	
</html>
