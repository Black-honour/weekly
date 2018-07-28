<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE HTML >
<html>
  <head>
    <title>MTR实验室工作进度登录网页</title>
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

<h2>MTR实验室工作进度登陆网页</h2>
<h3><img src="redball.gif">填写进度</h3>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/WeeklyReport?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC";
String username="root";
String password="123456";
Connection conn=DriverManager.getConnection(url,username,password);
String sql="select chineseName from MIR where active='true' order by chineseName";
PreparedStatement pstmt=conn.prepareStatement(sql);
ResultSet rs=pstmt.executeQuery();
%>

<div style="text-align:center">
<form action="form.jsp" method="post" target=_blank>
<select name="person" onChange="this.form.submit()">
<option>=== 请选您的姓名 ===
<%while(rs.next()){
String name =rs.getString(2);%>
<option value="<%=name%>>"><%=name%></option>
<% }%>
</select>
</form>
</div>
<ol>
<li>请务必在每星期五下午五点前填写完毕。过了星期六午夜，系统自动跳到下一周，就无法再填写本周的进度了。
<li>请务必每一栏都要填写，尤其是「本周预定完成事项」，一定要填入相关的「预定完成时间」。
</ol>
<hr>

<h3><img src="redball.gif">资料列表</h3>
<ul>
<li>每周填写之资料：
	<a target=_blank href="listEachWeek.jsp?weekDiff=0">本周</a>、
	<a target=_blank href="listEachWeek.jsp?weekDiff=-1">前一周</a>、
	<a target=_blank href="listEachWeek.jsp?weekDiff=-2">前两周</a>、
	<a target=_blank href="listEachWeek.jsp?weekDiff=-3">前三周</a>、
	<a target=_blank href="listEachWeek.jsp?weekDiff=-4">前四周</a>
<li>每个人的历史资料：
<%ResultSet res=pstmt.executeQuery();
while(res.next()){
String name=res.getString(2);%>
<a target=_blank href="listEachPerson.jsp?person='<%=name%>'"><%=name%></a>
<%}%>
<li><a target=_blank href="listAllPersonLastRecord.jsp">每个人的最後一笔资料</a>
</ul>
<hr>

<h3><img src="redball.gif">
有关本系统</h3>
<ul>
<li>本系统特点：超级简单易用，适合忙碌的管理者
<li>想要把整套系统移植到自己的实验室使用吗？没问题，请直接和本系统发展者<a href="http://www.cs.nthu.edu.tw/~jang">张智星</a>接洽。
</ul>

<hr>
<div style=text-float:right>
<p><font size=-1>By <a href="http://www.cs.nthu.edu.tw/~jang">Roger Jang</a></font></p></div>

</body>
</html>