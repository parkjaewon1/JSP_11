<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.shopping.*" %>
<%@ include file="loginCheck.jsp" %>
<%  request.setCharacterEncoding("utf-8"); 
	String book_kind = request.getParameter("book_kind");
	String buyer = (String)session.getAttribute("id"); 
%>
	<jsp:useBean id="cart" class="bookshop.shopping.Cart"></jsp:useBean>
	<jsp:setProperty property="*" name="cart"/>
<%	
	cart.setBuyer(buyer);
    CartDao bookProcess = CartDao.getInstance();
    int result = bookProcess.insertCart(cart);
    if (result > 0 ) {
       response.sendRedirect("shopMain.jsp?pgm=cartList.jsp&book_kind="+book_kind);
    } else {
%>
	 <script>
	 	alert("에러가 발생됐으니 콘솔 메세지를 확인하세요");
	 	history.go(-1);
	 </script>
<% } %>