<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../color.jsp"%>  
<%@ include file="../managerSessionChk.jsp" %>
<%  
	int book_id=Integer.parseInt(request.getParameter("book_id"));
    String book_kind = request.getParameter("book_kind");
%>
<html><head><title>책삭제</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<style type="text/css"> body {text-align: center; }</style></head>
<body bgcolor="<%=bodyback_c%>"><h2>책삭제</h2>
<a href="../managerMain.jsp"> 관리자 메인으로</a> &nbsp;
<a href="bookList.jsp?book_kind=<%=book_kind%>">목록으로</a><p>
<input type="button" value="삭제" 
 onclick="location.href='bookDeletePro.jsp?book_id=<%=book_id%>&book_kind=<%=book_kind%>'">  
</body>
</html>