<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.shopping.CartDao" %>
<%@ include file="loginCheck.jsp" %>
<%@ include file="../color.jsp"%> 
<%
 	int result = 0;
    String cart_id = request.getParameter("cart_id");
    String buy_count = request.getParameter("buy_count");
    String book_kind = request.getParameter("book_kind");

 	CartDao bookProcess = CartDao.getInstance();
    result = bookProcess.updateCount(Integer.parseInt(cart_id),Integer.parseInt(buy_count));
    if (result > 0) {
        response.sendRedirect("shopMain.jsp?pgm=cartList.jsp&book_kind="+book_kind);
    } else {
 %>
       	<script type="text/javascript">
			alert("에러발생 콘솔메세지를 확인하세요");
			history.go(-1);
       	</script>    	   
<%  }	%>