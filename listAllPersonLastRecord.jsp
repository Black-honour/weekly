<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<!DOCTYPE HTML >
<html>
  <head>
	<title>MTR实验室工作进度，每个人的最后一笔资料</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    

<style>
        h2 {text-align:center;}
		td {font-family: "标楷体", "helvetica,arial", "Tahoma"}
		A:link {text-decoration: none}
		A:hover {text-decoration: underline}
	</style>    
</head>
<body>

<h2>MTR实验室工作进度，每个人的最后一笔资料</h2>
<hr>

<div style="text-align:center">[<a href=default.jsp>回到主选单</a>]</div>

<% String color[]=new String[9];
color[0] = "#ffffdd";
color[1] = "#ffeeee";
color[2] = "#eeffee";
color[3] = "#e0e0f9";
color[4] = "#eeeeff";
color[5] = "#ffe9d0";
color[6] = "#ffffdd";
color[7] = "#eeeeff";
color[8] = "#e0e0f9";
%>

<p>
<table border=1 style="text-align:center;margin:auto">
<tr>
<th align=center>姓名</th>
<th align=center>本周完成事项</th>
<th align=center>下周预定完成事项：<br>【<font color=red>预定完成日期</font>】工作描述</th>
<th align=center>综合说明</th>
<th align=center> 登录日期</th></tr>

<%//连接数据库
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/weeklyreport?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String password="123456";
Connection conn=DriverManager.getConnection(url,username,password);

String []ufinished=(String[])session.getAttribute("finishedKey");
String []uthisDate=(String[])session.getAttribute("thisDateKey");
String []uthisTask=(String[])session.getAttribute("thisTaskKey");
//定义sql语句并执行
String sql="select chineseName from MIR where( active = 'true' ) order by chinesename";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();
String name;
int j=0;
while(rs.next()){
	name=rs.getString(1);
	String sql_new="select * from work where name = '" +name +"' order by entryDate desc";
	PreparedStatement pstmt_new=conn.prepareStatement(sql_new);
    ResultSet rs_new=pstmt_new.executeQuery();
	if(rs_new.next()){%>
		<tr>
		<td bgcolor=<%=color[j]%> align=center><a target=_blank href="listEachPerson.jsp?person=<%=name%>"><%=name%></a> </td>
		<td bgcolor=<%=color[j]%> valign=top><ol>
	    <%for(int i=0;i<=4;i++){ %>
        <%="<li>"+rs_new.getString(7+i)+"</li>"%>
        <%}%></ol> &nbsp; </td>
		<td bgcolor=<%=color[j]%> valign=top><ol>
		<%for(int i=0;i<=4;i++){%>
	    <%="<li>【<font color='red'>" + rs_new.getString(17+i) + "</font>】" + rs_new.getString(12+i)+"</li>"%> 
	    <%}%></ol>&nbsp; </td>
		<td bgcolor=<%=color[j]%> valign=top><%=rs_new.getString(22)%> &nbsp;</td>
		<td bgcolor=<%=color[j]%> valign=top><%=rs_new.getString(5)%><br><%=rs_new.getString(6)%> &nbsp;</td></tr>
	<%}else{%>
	    <tr>
		<td bgcolor=<%=color[j]%> align=center><a target=_blank href="listEachPerson.jsp?person=<%=name%>"><%=name%></a> </td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td></tr>
	<%}}%>
</table>
</body>
</html>	