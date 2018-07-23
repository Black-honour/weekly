<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! int fontSize=0; %> 
<!DOCTYPE html>
<%String v=request.getParameter("value");%>
<html>
<head>
<meta charset="utf-8">
<title>登录 <%= request.getParameter("value")%>的本周工作进度</title>
<style>
        h2 {text-align:center;}
        h3 {text-align:center;}
		td {font-family: "标楷体", "helvetica,arial", "Tahoma"}
		A:link {text-decoration: none}
		A:hover {text-decoration: underline}
	</style>
<style type="text/css">
            .div1{  width: 300px;
             height: 100px;
             margin:0 auto;}
     </style>
</head>

<body>
<h2>登录<font color="green">v</font>的本周工作进度</h2>
<hr>

<div class=div1>[<a href=listEachPerson.jsp?person=v>v的所有登录资料</a>][<a href=index.jsp>回到主选单</a>]</div>



<form method=post action="register.jsp">
<div style="text-align:center">
<table border="1" style="width: 60%;margin:auto">
<tr>
<th align=center colspan=2>上周预定完成事项</th>
<th align=center rowspan=2>本周完成事项</th>
<th align=center colspan=2>下周预定完成事项</th>
<th align=center rowspan=2>综合说明</th>
<tr>
<th align=center>工作描述<th align=center>预定完成日期</th>
<th align=center>工作描述<th align=center>预定完成日期</th>

<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><textarea name=finished0 cols=20 rows=3 wrap=virtual></textarea>
	<td><textarea name=thisTask0 cols=20 rows=3 wrap=virtual></textarea>
	<td><textarea name=thisDate0 cols=15 rows=3 wrap=virtual></textarea>
	
	<td rowspan=5><textarea name="summary" cols=20 rows=18 wrap=virtual></textarea></td>
	
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><textarea name=finished1 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisTask1 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisDate1 cols=15 rows=3 wrap=virtual></textarea></td>
	
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><textarea name=finished2 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisTask2 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisDate2 cols=15 rows=3 wrap=virtual></textarea></td>
	
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><textarea name=finished3 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisTask3 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisDate3 cols=15 rows=3 wrap=virtual></textarea></td>
	
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td><textarea name=finished4 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisTask4 cols=20 rows=3 wrap=virtual></textarea></td>
	<td><textarea name=thisDate4 cols=15 rows=3 wrap=virtual></textarea></td>
	
</table></div>
<h3><font color=green>v</font>的密码: <input type="password" size=10 name="password">
<input type="submit" value="送出表单">
<input type="reset"  value="恢复原值">
</h3>
<p align=center>
<input type=hidden name="person" value=v></p>
</form>



<hr>
<div class=div1>
[<a target=_blank href="listEachWeek.asp?weekDiff=0">本周登录之全部资料</a>]
[<a target=_blank href="listLastRecord.asp">每位同学的最後一笔资料</a>]
</div>


</body>
</html>