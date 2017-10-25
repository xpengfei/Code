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
		
	<body>
		<script type="text/javascript">
			function validate(){
				jID=document.main.id.value;
				
				if(jID==""){
					alert("输入不能为空!");
					document.main.id.focus();
					return;
				}
				document.main.submit();
			}
		</script>
		<form name="main" action="http://172.31.75.246/S2014150305/weChat/deletecomment.jsp">
		<table align="center" style="margin:20% 20% 20% 30%">
			<tr>
				<td align="right">
					id:
				</td>
				<td align="left">
					<input type="text" name="id">
				</td>
				<td align="left">
					<input type="button" onclick="validate()" value="删除">
				</td>
			</tr>
		</table>
		</form>
		<%
			request.setCharacterEncoding("UTF-8");
			String getid=request.getParameter("id");		
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement stat2=connection.createStatement();
			int flag=0;
			int TEXTID=0;
			String Sqlcomment="SELECT textID,id FROM comment";
			ResultSet rs=stat2.executeQuery(Sqlcomment);
			while(rs.next()){
				String getTextID=rs.getString("textID");
				String commentID=rs.getString("id");
				if(commentID.equals(getid)){
						TEXTID=Integer.parseInt(getTextID);
				}
			}
			Statement stat=connection.createStatement();
			if(getid!=null){
				int ID=Integer.parseInt(getid);
				String sql="DELETE  FROM comment WHERE id="+ID+"";
				int i=stat.executeUpdate(sql);
				flag++;
			}
			if(flag!=0){
				response.sendRedirect("http://172.31.75.246/S2014150305/weChat/showComment.jsp?textId="+TEXTID);
			}
			stat.close();
			connection.close();
		%>
		
	</body>
	
	
</html>