<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ page import="bookshop.master.BookDao,bookshop.master.Book" %>
<%@ page import="java.util.List,java.text.SimpleDateFormat" %>
<%@ include file="../../color.jsp"%> 
<%@ include file="../managerSessionChk.jsp" %>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");	 
	List <Book> bookList = null; int number = 0;
    String book_kind = request.getParameter("book_kind");
 
    BookDao bookProcess = BookDao.getInstance();
    int count = bookProcess.getBookCount();
    
    if (count > 0) {
    	bookList = bookProcess.getBooks(book_kind);
    }
%>
<html><head><title>책등록상황</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css"> body { text-align: center;}</style>
</head><body bgcolor=<%=bodyback_c %>>
<%
	String book_kindName="";
   if(book_kind.equals("100")){   book_kindName="문학";
   }else if(book_kind.equals("200")){  book_kindName="외국어";  
   }else if(book_kind.equals("300")){  book_kindName="컴퓨터";
   }else if(book_kind.equals("all")){  book_kindName="전체";  }
%>
<a href="../managerMain.jsp"> 관리자 메인으로</a> &nbsp;
<b><%=book_kindName%> 분류의 목록: 
<%
	if(book_kind.equals("all")){
%>     <%=count%>개
<%
     	}else{
     %>    <%=bookList.size()%>개
<%
    	}
    %>
</b>
<table width="100%" align="center">
<tr><td align="right" bgcolor="<%=value_c%>">
       <a href="bookRegisterForm.jsp">책 등록</a> 
 </td></tr></table>
<%
	if (count == 0) {
%>
	<table width="100%" border="1" align="center">
		<tr><td align="center">등록된 책이 없습니다</td></tr></table>
<%
	} else {
%>
<table border="1" width="100%" align="center"> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <th>번호</th>  <th>책분류</th> <th>제목</th>
      <th>가격</th>  <th>수량</th>  <th>저자</th>
      <th>출판사</th><th>출판일</th> <th>책이미지</th>
      <th>할인율</th><th>등록일</th> <th>수정</th>
      <th>삭제</th>         
    </tr>
<%
	for (int i = 0 ; i <bookList.size() ; i++) {
      	Book book = (Book)bookList.get(i);
%>
   <tr height="30">
      <td><%=++number%></td> 
      <td><%=book.getBook_kind()%></td> 
      <td><%=book.getBook_title()%></td>
      <td><%=book.getBook_price()%></td> 
      <td align="right">
         <% if(book.getBook_count()<=0) {%>
         <font color="red"><%="일시품절"%></font>
         <% }else{ %> <%=book.getBook_count()%>
         <%} %>
      </td> 
      <td><%=book.getAuthor()%></td>
      <td><%=book.getPublishing_com()%></td>
      <td><%=book.getPublishing_date()%></td>
      <td><%=book.getBook_image()%></td>
      <td><%=book.getDiscount_rate()%></td>
      <td><%=sdf.format(book.getReg_date())%></td>
      <td>
         <a href="bookUpdateForm.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>">수정</a></td>
      <td width="50">
         <a href="bookDeleteForm.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>">삭제</a></td>    
  </tr>
     <% } %>
</table>
<% } %>
<br><a href="../managerMain.jsp"> 관리자 메인으로</a> 
</body></html>