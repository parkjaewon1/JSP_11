<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "bookshop.master.*" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ include file="../color.jsp"%> 
<html><head><title>Book Shopping Mall</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">	h3 { text-align: center; }</style></head>
<body bgcolor="<%=bodyback_c%>"><h3>신간소개</h3>
<%
  Book bookLists[] = null;
  int number =0;
  String book_kindName="";
  
  BookDao bookProcess = BookDao.getInstance();
  for(int i = 1; i <= 3; i++){
	  bookLists = bookProcess.getBooks(i+"00", 3);
      if (bookLists==null) continue;
	  if(bookLists[0].getBook_kind().equals("100")){
	      book_kindName="문학";
     }else if(bookLists[0].getBook_kind().equals("200")){
	      book_kindName="외국어";  
     }else if(bookLists[0].getBook_kind().equals("300")){
	      book_kindName="컴퓨터";
     }
%>
 <br><font size="+1"><b><%=book_kindName%> 분류의 신간목록: 
   <a href="list.jsp?book_kind=<%=bookLists[0].getBook_kind()%>">더보기</a></b></font>
<%             
     for(int j=0;j<bookLists.length;j++){
        if (bookLists[j] ==null) continue;%>
     <table border="0" width="600" align="center"> 
       <tr height="30"> 
         <td rowspan="4"  width="100" align="center" valign="middle">
             <a href="shopMain.jsp?pgm=bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
             <img src="../imageFile/<%=bookLists[j].getBook_image()%>" border="0" width="60" height="90"></a></td> 
         <td width="350"><font size="+1"><b>
             <a href="shopMain.jsp?pgm=bookContent.jsp?book_id=<%=bookLists[j].getBook_id()%>&book_kind=<%=bookLists[0].getBook_kind()%>">
              <%=bookLists[j].getBook_title() %></a></b></font></td> 
         <td rowspan="4" width="100"  align="center"  valign="middle">
             <%if(bookLists[j].getBook_count()==0){ %>
                     <b>일시품절</b>
             <%}else{ %>      &nbsp;      <%} %>
         </td>
       </tr>        
       <tr height="30"> 
         <td width="350">출판사 : <%=bookLists[j].getPublishing_com()%></td> 
       </tr>
       <tr height="30"> 
         <td width="350">저자 : <%=bookLists[j].getAuthor()%></td>
       </tr>
       <tr height="30"> 
         <td width="350">정가 : <s><%=NumberFormat.getInstance().format(bookLists[j].getBook_price())%></s>원<br>
            판매가 : <b><%=NumberFormat.getInstance().format((int)
            (bookLists[j].getBook_price()*((double)(100-bookLists[j].getDiscount_rate())/100)))%></b>원</td> 
       </tr> 
     </table>
<% 
     }
  }
%>
</body></html>