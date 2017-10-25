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
	
	<body>
		<title>评论</title>
		<script type="text/javascript">
			function validate(){
				jcontant=document.mainform.RMessage.value;
				jID=document.mainform.ID.value;
				if(jID==""){
					alert("请输入文章ID!");
					document.mainform.ID.focus();
					return;
				}
				if(jcontant==""){
					alert("评论不能为空!");
					document.mainform.RMessage.focus();
					return;
				}
				
				document.mainform.submit();
			}
		</script>
		
		<form name="mainform"   action="http://172.31.75.246/S2014150305/weChat/comment.jsp">
			<br><br><br><br><br><br><br>
			<table width="800" align="center" border="0" >
				<tr>
					<td width="100"align="right" >文章id:</td>
					<td width="700" align="left">
						<input name="ID" type="text">
					</td>
				</tr>
				<tr>
					<td width="100"  align="right" style="vertical-align:top">评论内容:</td>
					<td width="700" align="left">
						<textarea name="RMessage" rows="5" cols="80" ></textarea>
					</td>
				</tr>
				<tr>
				<td width="400" colspan="2" align="center">
					<input type="reset" value="清空">
					<input type="button" onclick="validate()" value="确定">
					<a href="private.jsp">返回</a>
				</td>
				</tr>
			</table>
		</form>
	
		<%
			request.setCharacterEncoding("UTF-8");			
			String passRMS=request.getParameter("RMessage");		//评论内容
			String reId=request.getParameter("ID");					//文章ID		
			if(passRMS!=null){
				passRMS =passRMS.replaceAll("&", "&amp;");
				passRMS = passRMS.replaceAll("<", "&lt;");
				passRMS = passRMS.replaceAll(">", "&gt;");
				passRMS = passRMS.replaceAll(" ", "&nbsp;");
				passRMS = passRMS.replaceAll("'", "&#39;");
				passRMS = passRMS.replaceAll("\"", "&quot;");
				passRMS = passRMS.replaceAll("\n", "<br>");

			}
			
			String name="";
			ArrayList Uname=(ArrayList)session.getAttribute("Uname");
			if(Uname.size()>0){
				for(int i=0;i<Uname.size();i++){
					name=(String)Uname.get(i);				
				}
			}
							
			String commentTime;
			Date date=new Date();
			DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			commentTime=format.format(date);
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			
			String sql="INSERT INTO comment(textID,userName,comment,commentTime) VALUES(?,?,?,?)";		
			PreparedStatement preSta=connection.prepareStatement(sql);
			preSta.setString(1,reId);
			preSta.setString(2,name);
			preSta.setString(3,passRMS);
			preSta.setString(4,commentTime);
			if(reId!=null){
				preSta.executeUpdate();
			}
			preSta.close();
			connection.close();
		%>
		
	</body>
	
	
</html>