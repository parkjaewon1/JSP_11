<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.shopping.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ include file="loginCheck.jsp" %>
<%@ include file="../color.jsp"%> 
<% 
   String book_kind = request.getParameter("book_kind");
   String buyer = (String)session.getAttribute("id");
%>
<html><head><title>Book Shopping Mall</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<%
	ArrayList<Cart> cartLists = null;
	ArrayList<String> accountLists = null;
	Cart cartList = null;
	Member member= null;
	int number = 0;
	int total = 0;

	CartDao bookProcess = CartDao.getInstance();
    cartLists = bookProcess.getCart(buyer);
    
    MemberDao memberProcess = MemberDao.getInstance();
    member = memberProcess.select(buyer);
    
    BuyDao buyProcess = BuyDao.getInstance();
    accountLists = buyProcess.getAccount();
%>
	<div align="center"><b>구매 목록</b></div>
    <form name="inform" method="post" action="updateCart.jsp">
    <table border="1" width="750" align="center"> 
      <tr>  <th>번호</th> <th>책이름</th> <th>판매가격</th>
            <th>수량</th> <th>금액</th>   </tr>      
<%
      	for(int i=0;i<cartLists.size();i++){
          	 cartList = (Cart)cartLists.get(i);
      %>     
       <tr> 
          <td align="center"  width="50"><%=++number %></td> 
          <td  width="300">
             <img src="../imageFile/<%=cartList.getBook_image()%>" border="0" width="30" height="50" align="middle">
             <%=cartList.getBook_title()%>
          </td> 
          <td align="center"  width="100">\<%=NumberFormat.getInstance().format(cartList.getBuy_price())%></td>
          <td width="150" align="center"><%=cartList.getBuy_count()%></td> 
          <td align="center"  width="150" align="center">
              <%total += cartList.getBuy_count()*cartList.getBuy_price();%>
              \<%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getBuy_price()) %>
          </td>
       </tr>
<%
     }
%>
       <tr>
          <td colspan="5" align="right"><b>총 구매금액 : \<%=NumberFormat.getInstance().format(total)%></b></td>
      </tr>
   </table>
   </form>
   <br>
   <form method="post" action="buyPro.jsp" name="buyinput">
   <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
      <tr > 
       <td  colspan="2" align="center"><font size="+1" ><b>주문자 정보</b></font></td>
     </tr>
     <tr> 
       <td  width="200">성명</td>
       <td  width="400"><%=member.getName()%></td>
     </tr>
     <tr><td>전화번호</td><td><%=member.getTel()%></td>
     </tr>
     <tr><td>주소</td><td><%=member.getAddress()%></td>
     </tr>
     <tr><td>결제계좌</td>
       <td>
         <select name="account">
          <%
              for(int i=0;i<accountLists.size();i++){
            	  String accountList = (String)accountLists.get(i);
          %>
                  <option value="<%=accountList %>"><%=accountList %></option>
         <%}%>
         </select>
       </td>
    </tr>
  </table>
  <br>
   
   <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
      <tr > 
       <td  colspan="2" align="center"><font size="+1" ><b>배송지 정보</b></font></td>
     </tr>
     <tr> 
       <td  width="200">성명</td>
       <td  width="400">
          <input type="text" name="deliveryName" value="<%=member.getName()%>">
       </td>
     </tr>
     <tr> 
       <td>전화번호</td><td>
         <input type="text" name="deliveryTel" value="<%=member.getTel()%>">
       </td>
     </tr>
     <tr><td>주소</td><td>
         <input type="text" name="deliveryAddess" value="<%=member.getAddress()%>">
       </td>
     </tr>
     <tr> 
       <td colspan="2" align="center" bgcolor="<%=value_c%>">
         <input type="submit" value="확인" >
         <input type="button" value="취소" onclick="javascript:window.location='shopMain.jsp'">      
       </td>
    </tr>
  </table>
  </form>
</body>
</html>