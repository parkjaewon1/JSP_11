<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.master.*,java.util.*,java.text.NumberFormat" %>
<%@ include file="../color.jsp"%> 
<%
   String book_kind = request.getParameter("book_kind");
%>
<html><head><title>Book Shopping Mall</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css"> body { text-align: center; }</style></head>
<body>     
<% 	String path = request.getContextPath();
    ArrayList<Book> bookLists = null;
    Book bookList = null;
    String book_kindName="";
                    
    BookDao bookProcess = BookDao.getInstance(); 
    bookLists = bookProcess.getBooks(book_kind);
    if(book_kind.equals("100")){   book_kindName="문학";
    }else if(book_kind.equals("200")){ book_kindName="외국어";  
    }else if(book_kind.equals("300")){ book_kindName="컴퓨터";
    }else if(book_kind.equals("all")){ book_kindName="전체";   }
%>
    <h3><%=book_kindName%> 분류의 목록</h3>
    <a href="<%=path%>/shop/shopMain.jsp">메인으로</a>
<%
	for(int i=0;i<bookLists.size();i++){
    	 bookList = (Book)bookLists.get(i);
%>
     <table width="600" align="center"> 
       <tr height="30" bgcolor="<%=value_c%>"> 
         <td rowspan="4"  width="100" align="center" valign="middle">
             <a href="shopMain.jsp?pgm=bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>">
             <img src="<%=path %>/imageFile/<%=bookList.getBook_image()%>" border="0" width="60" height="90"></a></td> 
         <td width="350"><font size="+1"><b>
             <a href="shopMain.jsp?pgm=bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>">
              <%=bookList.getBook_title() %></a></b></font></td> 
         <td rowspan="4" width="100"  align="center"  valign="middle">
             <%if(bookList.getBook_count()==0){ %>
                     <b>일시품절</b>
             <%}else{ %>      &nbsp;    <%} %>
         </td>
       </tr>        
       <tr height="30" bgcolor="<%=value_c%>"> 
         <td>출판사 : <%=bookList.getPublishing_com()%></td> 
       </tr>
       <tr height="30" bgcolor="<%=value_c%>"> 
         <td>저자 : <%=bookList.getAuthor()%></td>
       </tr>
       <tr height="30" bgcolor="<%=value_c%>"> 
         <td width="350">정가 : <s><%=NumberFormat.getInstance().format(bookList.getBook_price())%></s><br>
            판매가 : <b><%=NumberFormat.getInstance().format((int)(bookList.getBook_price()*((double)(100-bookList.getDiscount_rate())/100)))%></b></td> 
       </tr>        
     </table> 
<%     }   %>
</body></html>