<%@page import="bookshop.master.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.shopping.*,java.text.NumberFormat" %>
<%@ include file="loginCheck.jsp" %>
<%@ include file="../color.jsp"%> 
<%
   String book_kind = request.getParameter("book_kind");
   String buyer = (String)session.getAttribute("id");
%>
<html><head><title>Book Shopping Mall</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function chk(i) {
		if (parseInt(document.forms[i].buy_count.value) > 
			parseInt(document.forms[i].book_count.value)) {
			alert("재고가 부족합니다 : "+document.forms[i].book_count.value);
			return false;
		}
	}
</script>
</head>
<body bgcolor="<%=bodyback_c%>">
<div align="center">
<%
	 ArrayList<Cart> cartLists = null;  
	 Cart cart = null;
	 int count = 0;  int number = 0;  int total = 0;
     CartDao bookProcess = CartDao.getInstance();
     count = bookProcess.getListCount(buyer);
     if(count == 0){
%>
		 <h3><b>장바구니</b></h3> 
         <table border="1" width="650" cellpadding="3" cellspacing="3" align="center"> 
           <tr><td align="center" >장바구니에 담긴 물품이 없습니다.</td> </tr>
         </table>
         <input type="button" value="쇼핑계속" 
         	onclick="location.href='shopMain.jsp?pgm=list.jsp&book_kind=<%=book_kind%>'">
   <%
   	}else{
           cartLists = bookProcess.getCart(buyer);
   %>
       <h3><b>장바구니</b></h3>
       <table border="1" width="750" align="center"> 
         <tr> <th>번호</th><th>책이름</th> 
           <th>판매가격</th><th>수량</th>  <th>금액</th></tr>      
<%
      	for(int i=0;i<cartLists.size();i++){
          	 cart = (Cart)cartLists.get(i);
          	 BookDao bd = BookDao.getInstance();
          	 Book book  = bd.getBook(cart.getBook_id());
      %>   <tr> 
          <td align="center"  width="50"><%=++number %></td> 
          <td  width="300">
             <img src="../imageFile/<%=cart.getBook_image()%>" border="0" width="30" height="50" align="middle">
             <%=cart.getBook_title()%>
          </td> 

          <td align="center"  width="100">\<%=NumberFormat.getInstance().format(cart.getBuy_price())%></td>
          <td width="150" align="center">
        <form name="im" method="post" action="updateCart.jsp"
        	onsubmit="return chk('<%=i%>')">  
                <input type="text" name="buy_count" size="5" 
                	value="<%=cart.getBuy_count()%>">
                <input type="hidden" name="cart_id" 
                	value="<%=cart.getCart_id()%>">
                <input type="hidden" name="book_kind" 
               	 value="<%=book_kind%>">
               	 <input type="hidden" name="book_count" 
               	 value="<%=book.getBook_count()%>">
                <input type="submit" value="수정" >
       </form>              
          </td> 
           
          <td align="center"  width="150" align="center">
              <%total += cart.getBuy_count()*cart.getBuy_price();%>
              \<%=NumberFormat.getInstance().format(cart.getBuy_count()*cart.getBuy_price()) %>
             <input type="button" value="삭제" onclick="location.href='cartListDel.jsp?list=<%=cart.getCart_id() %>&book_kind=<%=book_kind%>'">
          </td>
       </tr>  
<%     }	%>
       <tr>
          <td colspan="5" align="right"><b>총 금액 : \<%=NumberFormat.getInstance().format(total)%></b></td>
      </tr>
       <tr>
         <td colspan="5" align="center">
     		<input type="button" value="구매하기" onclick="location.href='buyForm.jsp'">
            <input type="button" value="쇼핑계속" onclick="location.href='shopMain.jsp?pgm=list.jsp&book_kind=<%=book_kind%>'">
            <input type="button" value="장바구니비우기" onclick="location.href='cartListDel.jsp?list=all&book_kind=<%=book_kind%>'">
      </td>      
      </tr>
   </table>
<%   }  %></div>
</body>
</html>