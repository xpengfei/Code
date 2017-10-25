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
			background-image:url(13.jpg);
			background-size:cover;
		}
	</style>
	<title>回复</title>
	<body>
		<script type="text/javascript">
			function validate(){
				jcontant=document.mainform.RMessage.value;
				jID=document.mainform.ID.value;
				if(jID==""){
					alert("请输入ID!");
					document.mainform.ID.focus();
					return;
				}
				if(jcontant==""){
					alert("回复内容不能为空!");
					document.mainform.RMessage.focus();
					return;
				}
				
				document.mainform.submit();
			}
		</script>
		
		<form name="mainform"   action="http://172.31.75.246/S2014150305/weChat/commentreply.jsp">
			<br><br><br><br><br><br><br>
			<table width="800" align="center" border="0" >
				<tr>
					<td width="100"align="right" >评论id:</td>
					<td width="700" align="left">
						<input name="ID" type="text">
					</td>
				</tr>
				<tr>
					<td width="100"  align="right" style="vertical-align:top">回复内容:</td>
					<td width="700" align="left">
						<textarea name="RMessage" rows="5" cols="80" ></textarea>
					</td>
				</tr>
				<tr>
				<td width="400" colspan="2" align="center">
					<input type="reset" value="清空">
					<input type="button" onclick="validate()" value="确定">
					
				</td>
				</tr>
			</table>
		</form>
	
		<%
			request.setCharacterEncoding("UTF-8");
			
			String passRMS=request.getParameter("RMessage");
			String reId=request.getParameter("ID");
			if(reId==null)
			{
				reId="0";
			}
			int num=Integer.parseInt(reId);
			
			String replyTime;
			Date date=new Date();
			DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			replyTime=format.format(date);
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement stat=connection.createStatement();
			
			String sql="SELECT textID,id,userName,comment,reply,commenttime,replytime FROM comment order by commenttime desc";
			
			ResultSet rs=stat.executeQuery(sql);//查询
			String Sql="UPDATE comment SET reply='"+passRMS+"',replyTime='"+replyTime+"' WHERE id="+num+"";//更新
			int i=stat.executeUpdate(Sql);
			rs.close();
			
			Statement stat2=connection.createStatement();			
			String sql2="SELECT textID,id,userName,comment,reply,commenttime,replytime FROM comment order by commenttime desc";
			ResultSet rs2=stat.executeQuery(sql2);//查询
			while(rs2.next()){
				String TID=rs2.getString("textID");
				String Id=rs2.getString("id");
				if(Id.equals(reId)){
					response.sendRedirect("http://172.31.75.246/S2014150305/weChat/showComment.jsp?textId="+TID);
					break;
				}
			}
			stat2.close();
			connection.close();
		%>
		
	</body>
	
	
</html>