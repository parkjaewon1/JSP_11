<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessionCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="common.css">
<script type="text/javascript">
	function del() {
		var chk = confirm("정말로 탈퇴겠습니까?");
		if (chk)  location.href="delete.jsp";
	}
	function chk() {
		var id = "<%=id%>";
		if (id != 'master') {
			alert("리스트를 볼 수 없습니다");
			return;
		}
		location.href="list.jsp";
	}
</script>
</head><body>
<table><caption>회원관리</caption>
	<tr><th><button onclick="location.href='updateForm.jsp'">
		회원정보 수정</button></th></tr>
	<tr><th><button onclick="del()">
		회원 탈퇴</button></th></tr>
	<tr><th><button onclick="chk()">
		회원목록</button></th></tr>
	<tr><th><button onclick="location.href='logout.jsp'">
		로그아웃</button></th></tr>
	<tr><th><button onclick="location.href='../indexShopMain.jsp'">
		북쇼핑</button></th></tr>
</table>
</body>
</html>