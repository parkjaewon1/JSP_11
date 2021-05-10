<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.shopping.CartDao" %>
<%@ include file="loginCheck.jsp" %>
<%@ include file="../color.jsp"%> 
<%
 	String list = request.getParameter("list");
    String buyer = (String)session.getAttribute("id");
    String book_kind = request.getParameter("book_kind");
    int result = 0;
    CartDao bookProcess = CartDao.getInstance();	   
 	   if(list.equals("all")){
 	       result = bookProcess.deleteAll(buyer);
 	       if (result == 0) {
 %>
			<script>
				alert("에러 발생 콘솔 메세지를 보세요");
				history.go(-1);
			</script>    	   
<%	       }
	   } else {
	 	  result = bookProcess.deleteList(Integer.parseInt(list));
	 	  if (result == 0) { %>
			<script>
				alert("에러 발생 콘솔 메세지를 보세요");
				history.go(-1);
			</script>    	   
<%	      }	
	   }
	   response.sendRedirect("shopMain.jsp?pgm=cartList.jsp&book_kind="+book_kind);
%>