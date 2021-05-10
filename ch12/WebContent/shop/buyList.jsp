<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="bookshop.shopping.Buy"%>
<%@ page import="bookshop.shopping.BuyDao"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ include file="../color.jsp"%>
<%@ include file="loginCheck.jsp"%>
<%
	String buyer = (String) session.getAttribute("id");
%>
<html>
<head>
<title>Book Shopping Mall</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
	<%
		ArrayList<Buy> buyLists = null;
		Buy buy = null;
		int count = 0;
		int number = 0;
		int total = 0;
		long compareId = 0;
		long preId = 0;

		BuyDao buyProcess = BuyDao.getInstance();
		count = buyProcess.getListCount(buyer);

		if (count == 0) {
	%>
	<table border="1" width="650" cellpadding="3" cellspacing="3"
		align="center">
		<caption>
			<h3>
				<b>구매목록</b>
			</h3>
		</caption>
		<tr>
			<td align="center">구매목록이 없습니다.</td>
		</tr>
	</table>
	<input type="button" value="메인으로"
		onclick="location.href='../shopMain.jsp'">
	<%
		} else {
			buyLists = buyProcess.getBuyList(buyer);
	%>
	<table border="1" width="750" cellpadding="0" cellspacing="0"
		align="center">
		<caption>
			<h3>
				<b>구매목록</b>
			</h3>
		</caption>
		<tr>
			<th>번호</th>
			<th>책이름</th>
			<th>판매가격</th>
			<th>수량</th>
			<th>금액</th>
		</tr>
		<%
			for (int i = 0; i < buyLists.size(); i++) {
					buy = (Buy) buyLists.get(i);
		%>
		<tr>
			<td align="center" width="50"><%=i + 1%></td>
			<td width="300"><img src="../imageFile/<%=buy.getBook_image()%>"
				border="0" width="30" height="50" align="middle"> <%=buy.getBook_title()%>
			</td>
			<td align="center" width="100">\<%=NumberFormat.getInstance().format(
							buy.getBuy_price())%></td>
			<td width="50" align="center"><%=buy.getBuy_count()%></td>
			<td align="center" width="150">
				<%
					total += buy.getBuy_count() * buy.getBuy_price();
				%> \<%=NumberFormat.getInstance().format(
							buy.getBuy_count() * buy.getBuy_price())%>
			</td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="5" align="right"><b>총 금액 : \<%=NumberFormat.getInstance().format(total)%></b></td>
		</tr>
	</table>
	<br>
	<%
		}
	%>
	<center>
		<input type="button" value="메인으로"
			onclick="location.href='shopMain.jsp'">
</body>
</html>