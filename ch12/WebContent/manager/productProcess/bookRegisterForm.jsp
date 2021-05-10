<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import = "java.sql.Timestamp" %>
<%@ include file="../managerSessionChk.jsp" %>
<%@ include file="../../color.jsp"%> 
<!DOCTYPE html><html><head><title>상품등록</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="checkScript.js"></script>
</head><body bgcolor="<%=bodyback_c%>">  
<div align="center"><h2>책 등록</h2>
<form method="post" name="writeform" action="bookRegisterPro.jsp"  
	enctype="multipart/form-data">
<table width="500" border="1">
   <tr><td align="right" colspan="2" bgcolor="<%=value_c%>">
	    <a href="../managerMain.jsp"> 관리자 메인으로</a></td>
   </tr>    <tr><td>분류 선택</td><td>
       <select name="book_kind">
           <option value="100">문학</option>
           <option value="200">외국어</option>
           <option value="300">컴퓨터</option>
       </select>
  </td> </tr>  <tr><td>제 목</td><td>
     <input type="text" size="50" maxlength="50" 
     	name="book_title"></td>  </tr>  
  <tr><td>가 격</td><td>
      <input type="text" size="10" maxlength="9" 
        name="book_price">원</td>  </tr>  
  <tr><td>수량</td><td>
       <input type="text" size="10" maxlength="5" 
       		name="book_count">권</td>  </tr>  
  <tr><td>저자</td><td>
        <input type="text" size="20" maxlength="30" name="author"></td>
  </tr>  <tr><td>출판사</td><td>
        <input type="text" size="20" maxlength="30" name="publishing_com"></td>
  </tr>
  <tr> <td>출판일</td><td>
  		<input type="date" name="publishing_date">
        <%-- <select name="publishing_year">
        <%
        Timestamp nowTime  = new Timestamp(System.currentTimeMillis());
        int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
           for(int i=lastYear;i>=1970;i--){
        %>
             <option value="<%=i %>"><%=i %></option>
        <%} %>        
        </select>년        
        <select name="publishing_month">
        <%     for(int i=1;i<=12;i++){       %>
             <option value="<%=i %>"><%=i %></option>
        <%} %>        
        </select>월        
        <select name="publishing_day">
        <%     for(int i=1;i<=31;i++){      %>
             <option value="<%=i %>"><%=i %></option>
        <%} %>        
        </select>일 --%>
     </td></tr>
  <tr>
    <td>이미지</td><td><input type="file" name="book_image"></td>
  </tr>
  <tr><td>내 용</td><td>
     <textarea name="book_content" rows="13" cols="40"></textarea> </td>
  </tr>
 <tr><td>할인율</td><td>
       <input type="text" size="5" maxlength="2" name="discount_rate"
        value="0">%</td>
  </tr>
<tr>      
 <td colspan=2 bgcolor="<%=value_c%>" align="center"> 
  <input type="button" value="책등록" onclick="checkForm(this.form)">  
  <input type="reset" value="다시작성">
</td></tr></table></form></div> 
</body></html>