<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
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
</head>
<body>
<h2>登陆<font color="green"><%=person%></font>本周的工作记录</h2>

<div style="text-align:center">[<a href="listEachPerson.jsp?person='<%=person%>'"><%=person%>的所有登录资料</a>][<a href=index.asp>回到主选单</a>]</div>

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

<%!
boolean sameweek(java.util.Date date1,java.util.Date date2){
	long weekNum1,weekNum2;
	int oneDayTime=1000*60*60*24;
	weekNum1 =date1.getTime()/oneDayTime;  
	weekNum2 =date2.getTime()/oneDayTime;  
    if((weekNum1+5)/7 == (weekNum2+5)/7){
    	return true;
    }else{
    	return false;
    }
}
%>

<%//定义参数
String finished0;
String finished1;
String finished2;
String finished3;
String finished4;
String thisTask0;
String thisTask1;
String thisTask2;
String thisTask3;
String thisTask4;
String thisDate0;
String thisDate1;
String thisDate2;
String thisDate3;
String thisDate4;
String prevTask0;
String prevTask1;
String prevTask2;
String prevTask3;
String prevTask4;
String prevDate0;
String prevDate1;
String prevDate2;
String prevDate3;
String prevDate4;
String summary;
String finished[]=new String[5];
String thisTask[]=new String[5];
String thisDate[]=new String[5];
String prevTask[]=new String[5];
String prevDate[]=new String[5];
//连接mysql数据库
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/WeeklyReport?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String password="123456";
Connection conn=DriverManager.getConnection(url,username,password);
//定义所需的sql语句，并执行
String sql="select *from (select @rownum:=@rownum+1 as rownum,s_Generation, id, s_GUID, name, entryDate, entryTime,finished0,finished1, finished2, finished3, finished4, thisTask0,thisTask1, thisTask2, thisTask3,thisTask4,thisDate0,thisDate1,thisDate2,thisDate3,thisDate4,summary from work,(select @rownum:=0)t order by entryDate)b where rownum = '1' and name='"+person+"'";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();

String LastEntryDate;
while(rs.next()){
	LastEntryDate=rs.getString(5);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date LastentryDate=sdf.parse(LastEntryDate);
	if(sameweek(new java.util.Date(),LastentryDate)){
		finished0=rs.getString(7);
		finished1=rs.getString(8);
		finished2=rs.getString(9);
		finished3=rs.getString(10);
		finished4=rs.getString(11);
		thisTask0=rs.getString(12);
		thisTask1=rs.getString(13);
		thisTask2=rs.getString(14);
		thisTask3=rs.getString(15);
		thisTask4=rs.getString(16);
		thisDate0=rs.getString(17);
		thisDate1=rs.getString(18);
		thisDate2=rs.getString(19);
		thisDate3=rs.getString(20);
		thisDate4=rs.getString(21);
		summary=rs.getString(22);
	}
	else{
		prevTask0=rs.getString(12);
		prevTask1=rs.getString(13);
		prevTask2=rs.getString(14);
		prevTask3=rs.getString(15);
		prevTask4=rs.getString(16);
		prevDate0=rs.getString(17);
		prevDate1=rs.getString(18);
		prevDate2=rs.getString(19);
		prevDate3=rs.getString(20);
		prevDate4=rs.getString(21);
	}
%>
    <tr>
    <td><%=prevTask[i]%>&nbsp;</td>
    <td><%=preDate[i]%>&nbsp;</td>
    <td><textarea name=<%=finished[i]%> cols=20 rows=3 wrap="hard"><%=finished[i]%></textarea></td>
    <td><textarea name=<%=thisTask[i]%> cols=20 rows=3 wrap="hard"><%=thisTask[i]%></textarea></td>
    <td><textarea name=<%=thisDate[i]%> cols=20 rows=3 wrap="hard"><%=thisDate[i]%></textarea></td>
<%}%>

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