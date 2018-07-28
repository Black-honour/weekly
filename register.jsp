<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<!DOCTYPE HTML >
<html>
  <head>
  <% String person=request.getParameter("person"); %>
  <% String password=request.getParameter("password");%>
  <title><%=person%>工作进度登录表</title>
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
<%  
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String passwordDatabase="123456";
Connection conn=DriverManager.getConnection(url,username,passwordDatabase);
String SQL="select * from MIR where (active=yes and ChineseName='" +person+"' and Birthday='" +password;
PreparedStatement pstmt=conn.prepareStatement(SQL);
ResultSet rs=pstmt.executeQuery();
if(rs.next()){
}
else{%>
	<p align=center>亲爱的 <font color="green"><%=person%></font>，您的认证资料错误，请回<a href="javascript:history.go(-1)">前页</a>修改。</p>
<%}%>

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

<%
//检查资料，确认是修改或是新增
int insertNewData=1;
int recordId=-1;
String sql_new="select *from work where entryDate =(select max(entryDate) from work)and name='"+person+"'";
PreparedStatement pstmt_new=conn.prepareStatement(sql_new);
ResultSet rs_first=pstmt_new.executeQuery();
if (rs.next()){	// 找到最後一笔资料
	String Lastentry=rs.getString(6);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date LastentryDate=sdf.parse(Lastentry);
	if(sameweek(new java.util.Date(), LastentryDate)){		//若和目前时间在同一个星期
		insertNewData=0;
		recordId=rs.getInt(2);
	}
}
%>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
String urlWork="jdbc:mysql://localhost:3306/work?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String userName="root";
String passwordWork="123456";
Connection connWork=DriverManager.getConnection(urlWork,userName,passwordWork);
String sql;
if(insertNewData==1){
	sql="insert into work (name, entryDate, entryTime, summary, ";
	sql = sql +"finished0, finished1, finished2, finished3, finished4, ";
	sql = sql + "thisTask0, thisTask1, thisTask2, thisTask3, thisTask4, ";
	sql = sql +"thisDate0, thisDate1, thisDate2, thisDate3, thisDate4) values ('";
	sql = sql + Request("person") + "', '";
	sql = sql +new java.util.Date().toString() + "', '";
	sql = sql + time + "', '";
	sql = sql + Request("summary") + "', '";
	sql = sql + Request("finished0") + "', '" & Request("finished1")+ "', '" + Request("finished2") + "', '" + Request("finished3") + "', '" + Request("finished4") + "', '";
	sql = sql + Request("thisTask0") + "', '" & Request("thisTask1") + "', '" +Request("thisTask2") + "', '" + Request("thisTask3") + "', '" + Request("thisTask4") + "', '";
    sql = sql + Request("thisDate0") + "', '" & Request("thisDate1") + "', '" + Request("thisDate2") + "', '" + Request("thisDate3") + "', '" + Request("thisDate4") + "')";			
}
else{
	sql="update work set";
	sql= sql + " finished0='" + Request.Form("finished0") + "',";
	sql= sql + " finished1='" + Request.Form("finished1") + "',";
	sql = sql + " finished2='" + Request.Form("finished2") + "',";
	sql = sql + " finished3='" + Request.Form("finished3") + "',";
	sql = sql + " finished4='" + Request.Form("finished4") + "',";
	sql = sql + " thisTask0='" + Request.Form("thisTask0") + "',";
	sql = sql + " thisTask1='" + Request.Form("thisTask1") + "',";
	sql = sql + " thisTask2='" + Request.Form("thisTask2") + "',";
	sql = sql + " thisTask3='" + Request.Form("thisTask3") + "',";
	sql = sql + " thisTask4='" + Request.Form("thisTask4") + "',";
	sql = sql + " thisDate0='" + Request.Form("thisDate0") + "',";
	sql = sql + " thisDate1='" + Request.Form("thisDate1") + "',";
	sql = sql + " thisDate2='" + Request.Form("thisDate2") + "',";
	sql = sql + " thisDate3='" + Request.Form("thisDate3") + "',";
	sql = sql + " thisDate4='" + Request.Form("thisDate4") + "',";
	sql = sql + " summary='" + Request.Form("summary") + "',";
	sql = sql + " entryDate='" + date + "',";
	sql = sql + " entryTime='" + time + "'";
	sql = sql + " where id=" + recordId;
}
PreparedStatement pstmtUpdate=connWork.prepareStatement(sql);

String sqln = "select * from work where name='" + Request("person") + "' order by entryDate desc";
PreparedStatement pstmtn=conn.prepareStatement(sqln);
ResultSet rsn=pstmtn.executeQuery();
%>
<p align=center>
亲爱的 <font color=green><%=RS("name")%></font>，您输入的资料如下。若有错误，可回<a href="javascript:history.go(-1)">前页</a>修改。

<p>
<table align=center border=1>
<tr>
	<th align=center>上周预定完成事项：<br>【<font color=red>预定完成日期</font>】工作描述
	<th align=center>本周完成事项
	<th align=center>下周预定完成事项：<br>【<font color=red>预定完成日期</font>】工作描述
	<th align=center>综合说明
	<th align=center>登录日期
<tr>
	<td valign=top><% PrintSession "prevDate", "prevTask" %> &nbsp; </td>
	<td valign=top><% PrintField RS, "finished", 0 %> &nbsp;</td>
	<td valign=top><% PrintDateTask RS, "thisDate", "thisTask" %> &nbsp; </td>
	<td valign=top><%=RS("summary")%> &nbsp;</td>
	<td><%=RS("entryDate")%><br><%=RS("entryTime")%> &nbsp; </td>
</table>
<hr>
<div style="text-align:cernter">
[<a style="display:block;text-align:center" target=_blank href="listEachWeek.asp?weekDiff=0">本周登录之全部资料</a>]
[<a style="display:block;text-align:center" target=_blank href="listLastRecord.asp">每位同学的最後一笔资料</a>]
</div>
</body>
</html>


