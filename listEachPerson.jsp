<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%@ page import="org.apache.commons.lang3.time.DateUtils"%>
<!DOCTYPE HTML >
<html>
  <head>
	<%String name=request.getParameter("name");%>
	<title>实验室工作进度<%=name%>的全部登录资料</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    

<style>
        h2 {text-align:center;}
		td {font-family: "标楷体", "helvetica,arial", "Tahoma"}
		A:link {text-decoration: none}
		A:hover {text-decoration: underline}
	</style>
 <style type="text/css">
            .div1{  width: 300px;
             height: 20px;
             margin:0 auto;}
        </style>
        
</head>
<body>

<div style="text-align:cernter"><a href=default.jsp>回到主选单</a>]</div>

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
<table border=1 align=center>
<tr>
<th align=center>姓名
<th align=center>本周完成事项
<th align=center>下周预定完成事项：<br>【<font color="red">预定完成日期</font>】工作描述
<th align=center>综合说明
<th align=center> 登录日期

<%
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String password="123456";
Connection conn=DriverManager.getConnection(url,username,password);
String sql="select * from work where name = '" +name+"' order by entryDate desc";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();
while(rs.next()){
%>
<tr>
	<td bgcolor=<%=color(j)%> align=center><font color=green><b><%=person%></b></font> </td>
	<td bgcolor=<%=color(j)%> valign=top><% PrintField RS, "finished", 0 %> &nbsp; </td>
	<td bgcolor=<%=color(j)%> valign=top><% PrintDateTask RS, "thisDate", "thisTask" %> &nbsp; </td>
	<td bgcolor=<%=color(j)%> valign=top><%=RS("summary")%> &nbsp;</td>
	<td bgcolor=<%=color(j)%> valign=top><%=RS("entryDate")%><br><%=RS("entryTime")%> &nbsp; </td>
	<%}%></tr>
	</table>
	</body>
	</html>
	