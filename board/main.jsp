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
		html,body{text-align:center}
		</style>
	</head>
	<title>留言</title>
	<style>
		body{
			background-image:url(main.jpg);
			background-size:cover;
		}
	</style>
	
	<body>
	<script type="text/javascript">
			function validate(){
				jaccount=document.mainform.Name.value;
				jemail=document.mainform.Email.value;
				jmessage=document.mainform.Message.value;
				if(jaccount=="" && jemail==""){
					alert("姓名不能为空!");
					document.mainform.Name.focus();
					return;
				}
				else if(jaccount!="" && jemail==""){
					alert("邮箱不能为空!");
					document.mainform.Email.focus();
					return;
				}else if(jaccount!="" && jemail!="" && jmessage==""){
					alert("留言内容不能为空!");
					document.mainform.Message.focus();
					return;
				}
				document.mainform.submit();
			}
		</script>
		<form name="mainform"   action="http://172.31.75.246/S2014150305/board/main.jsp">
			<table width="400" align="center" border="0" >
				<tr>
					<td width="60"  align="right">姓名:</td> 
					<td width="340" align="left">
						<input name="Name" type="text">
					</td>
				</tr>
					<td width="60"  align="right">邮箱:</td>
					<td width="340" align="left">
					<input name="Email" type="text" maxlength="40">
					</td>
				</tr>
				<tr>
					<td width="60"  align="right" style="vertical-align:top">内容:</td>
					<td width="340" align="left">
						<textarea name="Message" rows="5" cols="30" ></textarea>
					</td>
				</tr>
				<tr>
				
				<td width="200" colspan="2" align="center">
				
					<input type="reset" value="清空">
					<input type="button" onclick="validate()" value="提交">
					<a href="login.jsp">管理员登录</a>
				</td>
				</tr>
			</table>
		</form>
	
		
		<%
			request.setCharacterEncoding("UTF-8");
			String passName=request.getParameter("Name");
			String passEmail=request.getParameter("Email");
			String passMessage=request.getParameter("Message");
			if(passMessage!=null){
				passMessage = passMessage.replaceAll("&", "&amp;");
				passMessage =passMessage.replaceAll("<", "&lt;");
				passMessage = passMessage.replaceAll(">", "&gt;");
				passMessage = passMessage.replaceAll(" ", "&nbsp;");
				passMessage = passMessage.replaceAll("'", "&#39;");
				passMessage = passMessage.replaceAll("\"", "&quot;");
				passMessage = passMessage.replaceAll("\n", "<br>");
			}
			String currentTime;
			Date date=new Date();
			DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			currentTime=format.format(date);
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement statejudge=connection.createStatement();
			String sqljudge="SELECT name,email,contant FROM message Order By time desc";
			ResultSet rsjudge=statejudge.executeQuery(sqljudge);
			int updatejudge=0;
			while(rsjudge.next()){
				String getname=rsjudge.getString("name");
				String getemail=rsjudge.getString("email");
				String getcontant=rsjudge.getString("contant");
				if(getname.equals(passName) && getemail.equals(passEmail) && getcontant.equals(passMessage)){
					updatejudge++;
					%>
					<script type="text/javascript">
					alert("留言内容不能重复!");
					</script>
					<%
				}
			}
			
			if(updatejudge==0){
			
				String sql="INSERT INTO message(name,email,contant,time) VALUES(?,?,?,?)";			
				PreparedStatement preSta=connection.prepareStatement(sql);
				
				preSta.setString(1,passName);
				preSta.setString(2,passEmail);
				preSta.setString(3,passMessage);
				preSta.setString(4,currentTime);
				
				if(passName!=null){
					preSta.executeUpdate();
				}
				preSta.close();
			}
			
			Statement state=connection.createStatement();
			String sql2="SELECT name,time,contant,reply,replytime FROM message Order By time desc";
			ResultSet resultset=state.executeQuery(sql2);
			
			while(resultset.next()){
				
				out.print("<div align=\"center\">");
				out.print("<table width=\"600\" border=\"1\" rules=\"none\">");
				out.print("<tr height=\"30\">");
				out.print("<td width=\"40\" align=\"left\">"+resultset.getString("name")+"</td>");
				out.print("<td width=\"200\" align=\"right\">"+resultset.getString("time")+"</td></tr>");
				out.print("<tr height=\"30\"><td align=\"left\">留言内容："+"</td>"+"<td>"+resultset.getString("contant")+"</td></tr>");
				
				if(resultset.getString("reply")!=null)
				{
					out.print("<tr height=\"30\">");
					out.print("<td width=\"300\" align=\"left\">管理员回复: "+resultset.getString("replytime")+"</td></tr>");
					out.print("<tr height=\"30\">");
					out.print("<td width=\"300\" colspan=\"2\" align=\"left\">"+resultset.getString("reply")+"</td></tr>");
				}
				out.print("</table></div>");
				
				
			}
			state.close();
			connection.close();
		%>
		

	</body>
	
</html>