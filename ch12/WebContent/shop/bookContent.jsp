<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.master.*,java.text.NumberFormat" %>
<%@ include file="../color.jsp"%>  
<%
  	String book_kind = request.getParameter("book_kind");
    String book_id = request.getParameter("book_id");
    String id = "";
    int buy_price=0;
    if (session.getAttribute("id") == null){
       id = "not";
    } else {  id = (String)session.getAttribute("id");    }
  %>
<html><head><title>Book Shopping Mall</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function chk() {
		if (parseInt(inform.buy_count.value) > parseInt(inform.book_count.value)) {
			alert("뗏끼놈! 조그만 사 : " + inform.book_count.value);
			inform.buy_count.focus();	
			return false;
		}
		return true;
	}
</script>
</head>
<body bgcolor="<%=bodyback_c%>">
<%
	 String book_kindName="";  
     BookDao bookProcess = BookDao.getInstance(); 
     Book book = bookProcess.getBook(Integer.parseInt(book_id));
     
     if(book_kind.equals("100")){
	      book_kindName="문학";
      }else if(book_kind.equals("200")){
	      book_kindName="외국어";  
      }else if(book_kind.equals("300")){
	      book_kindName="컴퓨터";
      }
%>
     <form name="inform" method="post" action="cartInsert.jsp" onsubmit="return chk()">
     <table border="0" width="650" cellpadding="5" cellspacing="5" align="center"> 
       <tr height="30"> 
         <td rowspan="6"  width="150" align="center" valign="middle">
             <img src="../imageFile/<%=book.getBook_image()%>" border="0" width="150" height="200"></td> 
         <td width="500"><font size="+1"><b><%=book.getBook_title() %></b></font></td>
       </tr> 
       <tr><td>저자 : <%=book.getAuthor()%></td></tr>
       <tr><td>출판사 : <%=book.getPublishing_com()%></td></tr> 
       <tr><td>출판일 : <%=book.getPublishing_date()%></td></tr>
       <tr><td>정가 : <s><%=NumberFormat.getInstance().format(book.getBook_price())%>원</s><br>
            <%buy_price = (int)(book.getBook_price()*((double)(100-book.getDiscount_rate())/100)) ;%>
            판매가 : <b><%=NumberFormat.getInstance().format((int)(buy_price))%>원</b></td> 
       <tr><td>수량 : <input type="text" size="5" name="buy_count" value="1"> 개
              <%
                 if(id.equals("not")){
                	 if(book.getBook_count()==0){
              %>
                		 <b>일시품절</b>
              <%    }    %>                
             <%}else{  if(book.getBook_count()<=0){  %>
                         <b>일시품절</b>                           
             <%      }else{    %>	 
                        <input type="hidden" name="book_id" value="<%=book_id %>">
                        <input type="hidden" name="book_image" value="<%=book.getBook_image()%>">
                        <input type="hidden" name="book_title" value="<%=book.getBook_title() %>">
                        <input type="hidden" name="buy_price" value="<%=buy_price %>">
                        <input type="hidden" name="book_kind" value="<%=book_kind %>">              
            	        <input type="hidden" name="book_count" value="<%=book.getBook_count()%>">
            	        <input type="submit" value="장바구니에 담기">
    <%      }
              }  %>
            <input type="button" value="목록으로" onclick="location.href='list.jsp?book_kind=<%=book_kind%>'">
            <input type="button" value="메인으로" onclick="location.href='shopMain.jsp'">
            </td>
       </tr>         
       <tr>
          <td colspan="2"><br><%=book.getBook_content()%></td>
       </tr>       
     </table></form></body></html>