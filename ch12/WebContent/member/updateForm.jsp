<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bookshop.shopping.*"%>
<%@ include file="sessionCheck.jsp" %>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="common.css">
<script type="text/javascript">
	function chk() {
		if (frm.passwd.value != frm.passwd2.value) {
			alert("암호가 암호확인과 맞지 않습니다");
			frm.passwd.focus(); return false; 	}
	}
</script></head>
<%
	MemberDao md = MemberDao.getInstance();
	Member mem   = md.select(id);
%>
<body><form action="update.jsp" method="post" name="frm"
		onsubmit="return chk()">
	<input type="hidden" name="id" value="<%=id%>">
<table><caption>회원정보 수정</caption>
	<tr><th>아이디</th><td><%=id%></td></tr>
	<tr><th>암호</th><td><input type="password" name="passwd" 
		required="required"></td></tr>
	<tr><th>암호확인</th><td><input type="password" name="passwd2" 
		required="required"></td></tr>
	<tr><th>이름</th><td><input type="text" name="name" 
		required="required" value="<%=mem.getName()%>"></td></tr>
	<tr><th>주소</th><td><input type="text" name="address" 
		required="required" value="<%=mem.getAddress()%>"></td></tr>
	<tr><th>전화번호</th><td><input type="tel" name="tel" 
		required="required" pattern="\d{3}-\d{3,4}-\d{4}"
		title="전화번호 형식 3-3,4-4" placeholder="010-1111-1111"
		value="<%=mem.getTel()%>"></td></tr>
	<tr><th colspan="2"><input type="submit" value="확인"></th></tr>
</table></form></body></html>