<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../managerSessionChk.jsp" %>
<%@ page import = "bookshop.shopping.Buy" %> 
<%@ page import = "bookshop.shopping.BuyDao" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ include file="../../color.jsp"%> 
<html><head><title>Book Shopping Mall</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">	body, td { text-align: center; }</style>
</head><body bgcolor="<%=bodyback_c%>">
<%
	ArrayList<Buy> buyLists = null;
	Buy buy = null;
	BuyDao buyProcess = BuyDao.getInstance();
	int count = buyProcess.getListCount();

if(count == 0){
%>
      <h3><b>주문목록</b></h3>
        <table border="1" width="650" cellpadding="3" cellspacing="3" align="center"> 
        <tr><td align="center" >구매목록이 없습니다.</td> </tr>
      </table>
      <a href="../managerMain.jsp"> 관리자 메인으로</a> 
    <%
     	}else{ 	buyLists = buyProcess.getBuyList();
     %>
    <h3><b>주문목록</b></h3>
	<a href="../managerMain.jsp"> 관리자 메인으로</a> 
    <table border="1" align="center"> 
      <tr><th>주문번호</th>  <th>주문자</th>     <th>책이름</th>
          <th>주문가격</th>  <th>주문수량</th>   <th>주문일</th>
          <th>결제계좌</th>  <th>배송명</th>     <th>배송지전화</th>
          <th>배송지주소</th> <th>배송지상황</th> </tr>
 <%
 	for(int i = 0; i < buyLists.size(); i++) {
     	 buy = (Buy)buyLists.get(i);
 %>
   <tr> <td><%=i+1 %></td> 
        <td><%=buy.getBuyer() %></td> 
        <td><%=buy.getBook_title() %></td>
        <td><%=buy.getBuy_price() %></td> 
        <td><%=buy.getBuy_count()%></td>
        <td><%=buy.getBuy_date().toString() %></td>
        <td><%=buy.getAccount() %></td>
        <td><%=buy.getDeliveryName() %></td>
        <td><%=buy.getDeliveryTel() %></td>
        <td><%=buy.getDeliveryAddress() %></td>
        <td><%=buy.getSanction() %></td>      </tr>
<%     }  %>
    </table>
<%  }%>
</body></html>