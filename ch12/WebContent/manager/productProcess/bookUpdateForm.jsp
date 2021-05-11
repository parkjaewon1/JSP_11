<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import = "java.sql.Timestamp" %>
<%@ page import="bookshop.master.BookDao,bookshop.master.Book" %>
<%@ include file="../../color.jsp"%> 
<%@ include file="../managerSessionChk.jsp" %>
<%
	int book_id = Integer.parseInt(request.getParameter("book_id"));
    String book_kind = request.getParameter("book_kind");
    BookDao bookProcess = BookDao.getInstance();
    Book book =  bookProcess.getBook(book_id);
%>
<!DOCTYPE html><html><head><title>상품수정</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<style type="text/css"> body { text-align: center; }</style>
<script type="text/javascript" src="checkScript.js"></script>
</head><body bgcolor="<%=bodyback_c%>">  
<div align="center"><h2>책 수정</h2>
<form method="post" name="writeform" action="bookUpdatePro.jsp"  enctype="multipart/form-data">
<table width="500" border="1"  bgcolor="<%=bodyback_c%>">
   <tr>
    <td align="right" colspan="2" bgcolor="<%=value_c%>">
	    <a href="../managerMain.jsp"> 관리자 메인으로</a> &nbsp;
	    <a href="bookList.jsp?book_kind=<%=book_kind%>">목록으로</a>
   </td>
   </tr>
   <tr> <td>분류 선택</td>    <td>
       <select name="book_kind">
           <option value="100" <%if (book.getBook_kind().equals("100")) {%>selected<%} %>>문학</option>
           <option value="200" <%if (book.getBook_kind().equals("200")) {%>selected<%} %>>외국어</option>
           <option value="300" <%if (book.getBook_kind().equals("300")) {%>selected<%} %>>컴퓨터</option>
       </select>
    </td>
  </tr>
  <tr><td>제 목</td><td>
        <input type="text" size="50" maxlength="50" name="book_title" 
       		value="<%=book.getBook_title() %>">
        <input type="hidden" name="book_id" value="<%=book_id%>"></td>
  </tr>
  <tr> <td>가 격</td>  <td>
        <input type="text" size="10" maxlength="9" name="book_price" 
        value="<%=book.getBook_price() %>">원</td>
  </tr>
  <tr> <td>수량</td><td>
        <input type="text" size="10" maxlength="5" name="book_count" 
        value="<%=book.getBook_count() %>">권</td>
  </tr>
   <tr><td>저자</td><td>
        <input type="text" size="10" maxlength="5" name="author" value="<%=book.getAuthor()%>"></td>
  </tr>
  <tr><td>출판사</td><td>
        <input type="text" size="20" maxlength="30" name="publishing_com" value="<%=book.getPublishing_com() %>"></td>
  </tr>
  <tr><td>출판일</td><td>
  	<input type="date" name="publishing_date" value="<%=book.getPublishing_date()%>">
        <%-- <select name="publishing_year">
        <%
        Timestamp nowTime  = new Timestamp(System.currentTimeMillis());
        int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
           for(int i=lastYear;i>=1950;i--){
        %>
             <option value="<%=i %>"  <%if (Integer.parseInt(book.getPublishing_date().substring(0,4))==i) {%>selected<%} %>><%=i %></option>
        <%} %>
        </select>년        
        <select name="publishing_month">
        <%
           for(int i=1;i<=12;i++){
        %>
             <option value="<%=i %>" <%if (Integer.parseInt(book.getPublishing_date().substring(5,7))==i) {%>selected<%} %>><%=i %></option>
        <%} %>
        </select>월        
        <select name="publishing_day">
        <%    for(int i=1;i<=31;i++){      %>
             <option value="<%=i %>" <%if (Integer.parseInt(book.getPublishing_date().substring(8))==i) {%>selected<%} %>><%=i %></option>
        <%} %>
        </select>일 --%>
     </td>
  </tr>
<!--  이미지와 textarea는 value로 저장된 값을 보여주기가 안된다 -->
<!--  이미지는 다시 선택하거나 null로 보내야 한다 -->
  <tr> <td>이미지</td> <td>
        <input type="file" name="book_image" value="<%=book.getBook_image() %>"><%=book.getBook_image() %></td>
  </tr>
  <tr><td>내 용</td> <td>
<!--   textarea는 <textarea><</textarea>사이에 갑을 보여주면 변경 가능하다 -->
     <textarea name="book_content" rows="13" cols="40"><%=book.getBook_content() %></textarea> </td>
  </tr>
 <tr><td>할인율</td> <td>
        <input type="text" size="5" maxlength="2" name="discount_rate" value="<%=book.getDiscount_rate() %>">%</td>
  </tr>
<tr>      
 <td colspan=2 bgcolor="<%=value_c%>" align="center"> 
  <input type="button" value="책수정" onclick="updateCheckForm(this.form)">  
  <input type="reset" value="다시작성">
</td></tr></table> </form> </div></body>
</html>