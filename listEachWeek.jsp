<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<!DOCTYPE HTML >
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">   
  <%request.setCharacterEncoding("UTF-8");%> 
  
	<%int weekDiff = Integer.parseInt(request.getParameter("weekDiff"));	//和目前日期差几周，-1 代表前一周，-2 代表前两周，等等
    if (weekDiff==0){%>
	<title>MIR 实验室本周登录之工作进度></title>
    <%}else{%>
	<title>MIR 实验室前<%=-weekDiff%> 周登录之工作进度</title>
    <%}%>

<style>
        h2 {text-align:center;}
		td {font-family: "标楷体", "helvetica,arial", "Tahoma"}
		A:link {text-decoration: none}
		A:hover {text-decoration: underline}
	</style>
</head>
<body>

<%if (weekDiff==0){%>
<h2>MIR 实验室本周登录之工作进度></h2>
<%}else{%>
<h2>MIR 实验室前<%=-weekDiff%> 周登录之工作进度</h2>
<%}%>
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

<%//从今天倒推前一周的日期
java.util.Date dt=new java.util.Date();
java.util.Date newdt=new java.util.Date();
java.util.Date startnewdt=new java.util.Date();
java.util.Date endnewdt=new java.util.Date();
int oneDayTime=1000*60*60*24;
long dtTime=dt.getTime();
Calendar cal =Calendar.getInstance();
cal.setTime(dt);
cal.add(Calendar.DATE,(7*weekDiff));//日期加减，负数代表减几天，正数为加
newdt=cal.getTime();
long newdtTime=newdt.getTime();
double newdtday=Math.ceil(newdtTime/oneDayTime);
int xingQiJi=(int)((newdtday+6)%7); //星期几，1=星期天，7=星期六

Calendar start =Calendar.getInstance();
start.setTime(newdt);
Calendar end =Calendar.getInstance();
end.setTime(newdt);

start.add(Calendar.DATE,1-xingQiJi);//日期加减，负数代表减几天，正数为加
startnewdt=start.getTime();
end.add(Calendar.DATE,7-xingQiJi);//日期加减，负数代表减几天，正数为加,between不包括右边界
endnewdt=end.getTime();

SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd");

String startnewdtString=sdf.format(startnewdt);
String endnewdtString=sdf.format(endnewdt);
%>

<p>
<table border=1 style="test-align:center;margin:auto">
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

String sql="select chineseName from MIR where (active = 'true') order by chinesename";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();
String name;
int j=0;
while(rs.next()){
	name=rs.getString(1);
	String sql_new="select * from work where name = '" + name  +"' and entryDate <= '" + endnewdtString + "' and entryDate >= '" + startnewdtString +"' ";
	PreparedStatement pstmt_new=conn.prepareStatement(sql_new);
    ResultSet rs_new=pstmt_new.executeQuery();
	if(rs_new.next()){%>
		<tr>
		<td bgcolor=<%=color[j]%> align=center><a target=_blank href="listEachPerson.jsp?person=<%=name%>"><%=name%></a> </td>
		<td bgcolor=<%=color[j]%> valign=top><ol>
		<%for(int i=0;i<=4;i++){%>
		<%="<li>"+rs_new.getString(7+i)+"</li>"%>
		<%}%></ol>&nbsp;</td>
		<td bgcolor=<%=color[j]%> valign=top><ol>
	    <%for(int i=0;i<=4;i++){%>
	    <%="<li>【<font color='red'>" + rs_new.getString(17+i) + "</font>】" + rs_new.getString(12+i)%> 
	    <%}%></ol> &nbsp; </td>
		<td bgcolor=<%=color[j]%> valign=top><%=rs_new.getString(22)%> &nbsp;</td>
		<td bgcolor=<%=color[j]%> valign=top><%=rs_new.getString(5)%><br><%=rs_new.getString(6)%>&nbsp;</td></tr>	
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