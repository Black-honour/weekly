<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MTR 实验室工作进度登陆网页</title>
<style>
        h2 {text-align:center;}
		td {font-family: "标楷体", "helvetica,arial", "Tahoma"}
		A:link {text-decoration: none}
		A:hover {text-decoration: underline}
	</style>
 <style type="text/css">
            .div1{  width: 100px; height: 100px; border: 1px solid #000000;} 
            .div2{ width:40px ; height: 40px; background-color: green;}
        </style>
</head>

<body>
<h2>MTR 实验室工作进度登陆网页</h2>
<hr/>

<h3><img src="redball.gif">填写进度</h3>

<div class=div1>
<form name=form1 action="form.asp" method=post target=_blank>
<select name="person" onChange="this.form.submit()">
<option>=== 请选您的姓名 ===</option>
<option value="小明">小明</option>
<option value="小华">小华</option>
<option value="川普">川普</option>
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
<a target=_blank href=listEachPerson.jsp?person=小明>小明</a>
<a target=_blank href=listEachPerson.jsp?person=小华>小华</a>
<a target=_blank href=listEachPerson.jsp?person=川普>川普</a>
<li><a target=_blank href="listAllPersonLastRecord.jsp">每个人的最後一笔资料</a>
</ul>
<hr>

<h3><img src="redball.gif">有关本系统</h3>
<ul>
<li>本系统特点：超级简单易用，适合忙碌的管理者
<li>想要把整套系统移植到自己的实验室使用吗？没问题，请直接和本系统发展者<a href="http://www.cs.nthu.edu.tw/~jang">张智星</a>接洽。
</ul>
<hr>
<p align=right><font size=-1>By <a href="http://www.cs.nthu.edu.tw/~jang">Roger Jang</a></font>

</body>
</html>