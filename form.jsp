<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE HTML >
<html>
  <head>
  <%String person=request.getParameter("person");%>
    <title>登陆<%=person%>本周的工作记录</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    

<style>
        h2 {text-align:center;}
        h3 {text-align:center;}
		td {font-family: "标楷体", "helvetica,arial", "Tahoma"}
		A:link {text-decoration: none}
		A:hover {text-decoration: underline}
	</style>
 <style type="text/css">
            .div1{  width: 400px;
             height: 20px;
             margin:0 auto;}
        </style>
        
</head>
<body>
<h2>登陆<font color="green"><%=person%></font>本周的工作记录</h2>

<div class=div1>[<a href=listEachPerson.jsp?person=<%=person%>><%=person%>的所有登录资料</a>][<a href=index.asp>回到主选单</a>]</div>

<form method=post action="register.jsp">
<table border=1 align=center>
<tr>
<th align=center colspan=2>上周预定完成事项
<th align=center rowspan=2>本周完成事项
<th align=center colspan=2>下周预定完成事项
<th align=center rowspan=2>综合说明
<tr>
<th align=center>工作描述<th align=center>预定完成日期
<th align=center>工作描述<th align=center>预定完成日期

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
    String username="root";
    String password="123456";
Connection conn=DriverManager.getConnection(url,username,password);
String sql="select *from te";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();
String prevTask[]=new String[5];
String preDate[]=new String[5];
String finished[]=new String[5];
String thisTask[]=new String[5];
String thisDate[]=new String[5];
for(int i=0;i<5;i++){
while(rs.next()){
	prevTask[i]=rs.getString(1);
	preDate[i]=rs.getString(2);
	finished[i]=rs.getString(3);
	thisTask[i]=rs.getString(4);
	thisDate[i]=rs.getString(5);
%>
    <tr>
    <td><%=prevTask[i]%>&nbsp;</td>
    <td><%=preDate[i]%>&nbsp;</td>
    <td><textarea name=<%=finished[i]%> cols=20 rows=3 wrap="hard"><%=finished[i]%></textarea></td>
    <td><textarea name=<%=thisTask[i]%> cols=20 rows=3 wrap="hard"><%=thisTask[i]%></textarea></td>
    <td><textarea name=<%=thisDate[i]%> cols=20 rows=3 wrap="hard"><%=thisDate[i]%></textarea></td>
<%}}%>

</table>
<h3><font color="green"><%=person %></font>的密码: <input type=password size=10 name=password>
<input type=submit value="送出表单">
<input type=reset  value="恢复原值">
</h3>
<p align=center>
<input type=hidden name="person" value="<%=person%>">
</form>

<hr>
<div class=div1>
[<a target=_blank href="listEachWeek.jsp?weekDiff=0">本周登录之全部资料</a>]
[<a target=_blank href="listLastRecord.jsp">每位同学的最後一笔资料</a>]
</div>
</body>
</html>