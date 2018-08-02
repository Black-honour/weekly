<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
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
  
  <% String person=request.getParameter("person"); %>
  <% String password=request.getParameter("password");%>
  <title><%=person%>工作进度登录表</title>
    

<style>
        h2 {text-align:center;}
        h3 {text-align:center;}
		td {font-family: "标楷体", "helvetica,arial", "Tahoma"}
		A:link {text-decoration: none}
		A:hover {text-decoration: underline}
	</style>
</head>
<body>

<h2><%=person%>工作进度登录表</h2><hr>

<% //连接数据库 
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/weeklyreport?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String passwordDataBase="123456";
Connection conn=DriverManager.getConnection(url,username,passwordDataBase);

String SQL="select * from MIR where active = 'true' and ChineseName = '" +person+"' and Birthday= '" + password + "' ";
PreparedStatement pstmt=conn.prepareStatement(SQL);
ResultSet rs=pstmt.executeQuery();
if(rs.next()){
}else{%>
	<p align=center>亲爱的 <font color="green"><%=person%></font>，您的认证资料错误，请回<a href="javascript:history.go(-1)">前页</a>修改。</p>
<%}%>

<%!
public boolean sameweek(java.util.Date date1,java.util.Date date2){
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

<%
//检查资料，确认是修改或是新增
int insertNewData=1;
int recordId=-1;
String Lastentry= "";
String time="";

String sql_new="select *from (select @rownum:=@rownum+1 as rownum, s_Generation, id, s_GUID, name, entryDate, entryTime, finished0, finished1, finished2, finished3, finished4, thisTask0, thisTask1, thisTask2, thisTask3, thisTask4, thisDate0, thisDate1, thisDate2, thisDate3, thisDate4, summary from work, (select @rownum:=0)t where name = '" + person + "' order by entryDate desc)b where rownum = '1'";
PreparedStatement pstmt_new=conn.prepareStatement(sql_new);
ResultSet rs_first=pstmt_new.executeQuery();

java.util.Date dt =new java.util.Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdftime = new SimpleDateFormat("HH-mm-ss");
String dateString=sdf.format(dt);
String timeString = sdftime.format(dt);
java.util.Date newdate=sdf.parse(dateString);

if (rs.next()){	// 找到最後一笔资料
	Lastentry=rs.getString(6);
    time=rs.getString(7);
	java.util.Date LastentryDate=sdf.parse(Lastentry);
	if(sameweek(dt, LastentryDate)){		//若和目前时间在同一个星期
		insertNewData=0;
		recordId=rs.getInt(2);
	}
}
%>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
String urlWork="jdbc:mysql://localhost:3306/weeklyreport?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String userName="root";
String passwordWork="123456";
Connection connWork=DriverManager.getConnection(urlWork,userName,passwordWork);

String sql;

if(insertNewData==1){//增加新的数据
	sql = "insert into work (name, entryDate, entryTime, summary, ";
	sql = sql +"finished0, finished1, finished2, finished3, finished4, ";
	sql = sql + "thisTask0, thisTask1, thisTask2, thisTask3, thisTask4, ";
	sql = sql +"thisDate0, thisDate1, thisDate2, thisDate3, thisDate4) values ('";
	sql = sql + person + "', '";
	sql = sql + dateString+"', '";
	sql = sql + timeString + "', '";
	sql = sql + request.getParameter("summary") + "', '";
	sql = sql + request.getParameter("finished[0]") + "', '" + request.getParameter("finished[1]") + "', '" + request.getParameter("finished[2]") + "', '" + request.getParameter("finished[3]") + "', '" + request.getParameter("finished[4]") + "', '";
	sql = sql + request.getParameter("thisTask[0]") + "', '" + request.getParameter("thisTask[1]") + "', '" + request.getParameter("thisTask[2]") + "', '" + request.getParameter("thisTask[3]") + "', '" + request.getParameter("thisTask[4]") + "', '";
    sql = sql + request.getParameter("thisDate[0]") + "', '" + request.getParameter("thisDate[1]") + "', '" + request.getParameter("thisDate[2]") + "', '" + request.getParameter("thisDate[3]") + "', '" + request.getParameter("thisDate[4]") + "')";			
}
else{//更新数据
	sql = "update work set";
	sql = sql + " finished0='" + request.getParameter("finished[0]") + "',";
	sql = sql + " finished1='" + request.getParameter("finished[1]") + "',";
	sql = sql + " finished2='" + request.getParameter("finished[2]") + "',";
	sql = sql + " finished3='" + request.getParameter("finished[3]") + "',";
	sql = sql + " finished4='" + request.getParameter("finished[4]") + "',";
	sql = sql + " thisTask0='" + request.getParameter("thisTask[0]") + "',";
	sql = sql + " thisTask1='" + request.getParameter("thisTask[1]") + "',";
	sql = sql + " thisTask2='" + request.getParameter("thisTask[2]") + "',";
	sql = sql + " thisTask3='" + request.getParameter("thisTask[3]") + "',";
	sql = sql + " thisTask4='" + request.getParameter("thisTask[4]") + "',";
	sql = sql + " thisDate0='" + request.getParameter("thisDate[0]") + "',";
	sql = sql + " thisDate1='" + request.getParameter("thisDate[1]") + "',";
	sql = sql + " thisDate2='" + request.getParameter("thisDate[2]") + "',";
	sql = sql + " thisDate3='" + request.getParameter("thisDate[3]") + "',";
	sql = sql + " thisDate4='" + request.getParameter("thisDate[4]") + "',";
	sql = sql + " summary='" + request.getParameter("summary") + "',";
	sql = sql + " entryDate='" + Lastentry + "',";
	sql = sql + " entryTime='" + time + "'";
	sql = sql + " where id=" + recordId;
}
PreparedStatement pstmtUpdate=connWork.prepareStatement(sql);

String sqln = "select * from work where name = '" + person + "' order by entryDate desc";
PreparedStatement pstmtn=conn.prepareStatement(sqln);
ResultSet rsn=pstmtn.executeQuery();

String []ufinished=(String[])session.getAttribute("finishedKey");
String []uthisDate=(String[])session.getAttribute("thisDateKey");
String []uthisTask=(String[])session.getAttribute("thisTaskKey");

%>
<p align=center>
亲爱的 <font color=green><%=person%></font>，您输入的资料如下。若有错误，可回<a href="javascript:history.go(-1)">前页</a>修改。</p>

<table style="text-align:center;margin:auto" border=1>
<tr>
	<th align=center>上周预定完成事项：<br>【<font color=red>预定完成日期</font>】工作描述</th>
	<th align=center>本周完成事项</th>
	<th align=center>下周预定完成事项：<br>【<font color=red>预定完成日期</font>】工作描述</th>
	<th align=center>综合说明</th>
	<th align=center>登录日期</th>

<%while(rsn.next()){%><tr>

	<td valign=top><ol>
	<%for(int i=0;i<=4;i++){%>
	<%="<li>【<font color='red'>" + uthisDate[i] + "</font>】" + uthisTask[i] + "</li>"%> 
	<%}%></ol>&nbsp;</td>
	<td valign=top><ol>
	<%for(int i=0;i<=4;i++){%>
	<%="<li>"+rsn.getString(7+i)+"</li>"%>
	<%}%></ol>&nbsp;</td>
	<td valign=top><ol>
	<%for(int i=0;i<=4;i++){%>
	<%="<li>【<font color='red'>" + rsn.getString(17+i) + "</font>】" + rsn.getString(12+i)%> 
	<%}%></ol>&nbsp;</td>
	<td valign=top><%=rsn.getString(22)%> &nbsp;</td>
	<td><%=rsn.getString(5)%><br><%=rsn.getString(6)%> &nbsp; </td>
	<%}%></tr>
</table>
<hr>
<div style="text-align:center">
[<a target=_blank href="listEachWeek.jsp?weekDiff=0">本周登录之全部资料</a>]
[<a target=_blank href="listAllPersonLastRecord.jsp">每位同学的最後一笔资料</a>]
</div>
</body>
</html>