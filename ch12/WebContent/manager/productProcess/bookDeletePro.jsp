<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../managerSessionChk.jsp" %>
<%@ page import = "bookshop.master.BookDao" %>
<%
	request.setCharacterEncoding("utf-8");
    int book_id = Integer.parseInt(request.getParameter("book_id"));
    String book_kind = request.getParameter("book_kind");
 
    BookDao bookProcess = BookDao.getInstance();
    int result = bookProcess.deleteBook(book_id);
    if (result > 0 ){ 
	    response.sendRedirect("bookList.jsp?book_kind="+book_kind);
    } else {
%>
	  <script type="text/javascript">
		  alert("삭제 실패!! 콘솔 메세지를 보세요");
		  history.go(-1);
	  </script>
<%  }   %>