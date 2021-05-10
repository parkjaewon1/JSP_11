<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="loginCheck.jsp" %>
<%@ page import = "bookshop.shopping.*,bookshop.master.BookDao" %>
<%@ page import = "java.util.ArrayList,java.sql.Timestamp" %>
<%
	request.setCharacterEncoding("utf-8");
    String account = request.getParameter("account");
    String deliveryName = request.getParameter("deliveryName");
    String deliveryTel = request.getParameter("deliveryTel");
    String deliveryAddess = request.getParameter("deliveryAddess");
    String buyer = (String)session.getAttribute("id");   
    CartDao cartProcess = CartDao.getInstance();
    ArrayList<Cart> cartLists = cartProcess.getCart(buyer);
      
    BuyDao buyProcess = BuyDao.getInstance();   
    buyProcess.insertBuy(cartLists,buyer,account, deliveryName, deliveryTel, deliveryAddess);
   
    response.sendRedirect("buyList.jsp");
%>