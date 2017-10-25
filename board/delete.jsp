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
			background-image:url(message.jpg);
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
		<form name="main" action="http://172.31.75.246/S2014150305/board/delete.jsp">
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
				<td align="left">
					<a href="http://172.31.75.246/S2014150305/board/managerMesBoard.jsp">返回</a>
				</td>
			</tr>
		</table>
		</form>
		<%
			request.setCharacterEncoding("UTF-8");
			String getid=request.getParameter("id");		
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/S2014150305?useUnicode=true&characterEncoding=utf-8","S2014150305","2014150305");
			Statement stat=connection.createStatement();
			int flag=0;
			if(getid!=null){
				int ID=Integer.parseInt(getid);
				String sql="DELETE  FROM message WHERE id="+ID+"";
				int i=stat.executeUpdate(sql);
				flag++;
			}
			if(flag!=0){
				response.sendRedirect("http://172.31.75.246/S2014150305/board/managerMesBoard.jsp");
			}
			stat.close();
			connection.close();
		%>
		
	</body>
	
	
</html>