<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<!DOCTYPE HTML >
<html>
  <head>
<meta http-equiv="content-Type" content="text/html;charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 

<%request.setCharacterEncoding("UTF-8");%>  
<%String person=request.getParameter("person");%>
    <title>登陆<%=person%>本周的工作记录</title>  

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

<div style="text-align:center">[<a href="listEachPerson.jsp?person=<%=person%>"><%=person%>的所有登录资料</a>][<a href=default.jsp>回到主选单</a>]</div>

<form method=post action="register.jsp">
<table style="text-align:center;margin:auto" border=1>
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
String summary=" ";
String finished[]=new String[5];
String thisTask[]=new String[5];
String thisDate[]=new String[5];
String prevTask[]=new String[5];
String prevDate[]=new String[5];

int i;
//连接mysql数据库
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/weeklyreport?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String password="123456";
Connection conn=DriverManager.getConnection(url,username,password);
//定义所需的sql语句，并执行
String sql="select *from (select @rownum:=@rownum+1 as rownum, s_Generation, id, s_GUID, name, entryDate, entryTime, finished0, finished1, finished2, finished3, finished4, thisTask0, thisTask1, thisTask2, thisTask3, thisTask4, thisDate0, thisDate1, thisDate2, thisDate3, thisDate4, summary from work, (select @rownum:=0)t order by entryDate)b where rownum = '1' and name = '" + person + "' ";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();
java.util.Date date =new java.util.Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String dateString=sdf.format(date);
java.util.Date newdate=sdf.parse(dateString);

String LastEntryDate;
while(rs.next()){
	LastEntryDate=rs.getString(6);
	java.util.Date LastentryDate=sdf.parse(LastEntryDate);
	if(sameweek(newdate,LastentryDate)){
		finished[0]=rs.getString(8);
		finished[1]=rs.getString(9);
		finished[2]=rs.getString(10);
		finished[3]=rs.getString(11);
		finished[4]=rs.getString(12);
		thisTask[0]=rs.getString(13);
		thisTask[1]=rs.getString(14);
		thisTask[2]=rs.getString(15);
		thisTask[3]=rs.getString(16);
		thisTask[4]=rs.getString(17);
		thisDate[0]=rs.getString(18);
		thisDate[1]=rs.getString(19);
		thisDate[2]=rs.getString(20);
		thisDate[3]=rs.getString(21);
		thisDate[4]=rs.getString(22);
		summary=rs.getString(23);
		
		session.setAttribute("finishedKey",finished);
		session.setAttribute("thisTaskKey",thisTask);
		session.setAttribute("thisDateKey",thisDate);

		session.setAttribute("summaryKey", summary);
	}
	else{
		prevTask[0]=rs.getString(13);
		prevTask[1]=rs.getString(14);
		prevTask[2]=rs.getString(15);
		prevTask[3]=rs.getString(16);
		prevTask[4]=rs.getString(17);
		prevDate[0]=rs.getString(18);
		prevDate[1]=rs.getString(19);
		prevDate[2]=rs.getString(20);
		prevDate[3]=rs.getString(21);
		prevDate[4]=rs.getString(22);
		
		session.setAttribute("prevTaskKey",prevTask);
		session.setAttribute("prevDateKey",prevDate);

	}
	for(i=0;i<5;i++){
%>
    <tr>
    <td><%=prevTask[i]%>&nbsp;</td>
    <td><%=prevDate[i]%>&nbsp;</td>
    <td><textarea name=<%=finished[i]%> cols=20 rows=3 wrap="hard"><%=finished[i]%></textarea></td>
    <td><textarea name=<%=thisTask[i]%> cols=20 rows=3 wrap="hard"><%=thisTask[i]%></textarea></td>
    <td><textarea name=<%=thisDate[i]%> cols=20 rows=3 wrap="hard"><%=thisDate[i]%></textarea></td>
    <%
    if(i==0){%>
    <td rowspan=5><textarea name="summary" cols=20 rows=18 wrap="hard"><%=summary %></textarea>
	
<%}}}%>

</table>
<h3><font color="green"><%=person %></font>的密码: <input type=password size=10 name=password>
<input type=submit value="送出表单">
<input type=reset  value="恢复原值">
</h3>
<p align=center>
<input type=hidden name="person" value="<%=person%>">
</form>

<hr>
<div style="text-align:center">
[<a target=_blank href="listEachWeek.jsp?weekDiff=0">本周登录之全部资料</a>]
[<a target=_blank href="listAllPersonLastRecord.jsp">每位同学的最後一笔资料</a>]
</div>
</body>
</html>