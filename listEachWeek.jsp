<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%@ page import="org.apache.commons.lang.time.DateUtils" %>
<!DOCTYPE HTML >
<html>
  <head>
	<%int weekDiff = Integer.parseInt(request.getParameter("weekDiff"));	//和目前日期差几周，-1 代表前一周，-2 代表前两周，等等
    if (weekDiff==0){%>
	<title>MIR 实验室本周登录之工作进度></title>
    <%}else{%>
	<title>MIR 实验室前<%=-weekDiff%> 周登录之工作进度</title>
    <%}%>
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

<%//从今天倒推前一周的日期
Date dt=new Date();
Date newdt=new Date();
int oneDayTime=1000*60*60*24;
int dtTime=dt.getTime();
Calendar cal =Calendar.getInstance();
cal.setTime(dt);
cal.add(Calendar.DATE,(-7*weekDiff));//日期加减，负数代表减几天，正数为加
newdt=cal.getTime();
int dtday=dtTime/oneDayTime;
int xingQiJi=(dtday+2)%7; //星期几，1=星期天，7=星期六
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
String startDate=sdf.format(DateUtils.addDays(newdt,1-xingQiJi));//开始日期
String endDate=sdf.formt(DateUtils.addDays(newdt,7-xingQiJi));//结束日期
%>

<p>
<table border=1 align=center>
<tr>
<th align=center>姓名</th>
<th align=center>本周完成事项</th>
<th align=center>下周预定完成事项：<br>【<font color=red>预定完成日期</font>】工作描述</th>
<th align=center>综合说明</th>
<th align=center> 登录日期</th>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String password="123456";
Connection conn=DriverManager.getConnection(url,username,password);
String sql="select name from stu";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();
String name;
while(rs.next()){
	name=rs.getString(1);
	String sql_new="select * from work where name = '" + name + "' and entryDate Between" + startDate + "and" + endDate ;
	PreparedStatement pstmt_new=conn.prepareStatement(sql_new);
    ResultSet rs_new=pstmt.executeQuery();
	if(rs_new.next()){%>
		<tr>
		<td bgcolor=<%=color(j)%> align=center><a target=_blank href="listEachPerson.jsp?person=<%=name%>"><%=name%></a> </td>
		<td bgcolor=<%=color(j)%> valign=top><% PrintField RS, "finished", 0 %> &nbsp;</td>
		<td bgcolor=<%=color(j)%> valign=top><% PrintDateTask RS, "thisDate", "thisTask" %> &nbsp; </td>
		<td bgcolor=<%=color(j)%> valign=top><%=RS("summary")%> &nbsp;</td>
		<td bgcolor=<%=color(j)%> valign=top><%=RS("entryDate")%><br><%=RS("entryTime")%> &nbsp;</td>	
	<%}else{%>
	<tr>
		<td bgcolor=<%=color(j)%> align=center><a target=_blank href="listEachPerson.jsp?person=<%=name%>"><%=person%></a> </td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td></tr>
	<%}}%>
</table>
</body>
</html>	