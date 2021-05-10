<%@ page contentType = "text/html; charset=utf-8" %>
<%@ include file="../color.jsp"%> <html><head>
   <link href="style.css" rel="stylesheet" type="text/css"> 
   <style type="text/css"> body { text-align: center; }</style> 
   <script type="text/javascript">
    	function focusIt() { inform.id.focus(); }
   </script> 
<% String path = request.getContextPath();
   if(session.getAttribute("id") == null){
%>   
</head><body onLoad="focusIt()" bgcolor="<%=bodyback_c%>">
     <a href="shopMain.jsp?pgm=list.jsp?book_kind=all">전체목록보기</a>&nbsp;
     <br>      
     <form name="inform" method="post" action="loginPro.jsp">
         아이디:  <input type="text" name="id" size="15" maxlength="12">
         패스워드: <input type="password" name="passwd" size="15" maxlength="12">
         <input type="submit" name="Submit" value="로그인">
     </form><br>
     <a href="../member/main.jsp">회원관리</a><br>
     <font color="red">* 반드시 로그인을 하셔야 쇼핑을 하실 수 있습니다.*</font>
 <%}else{%>
          <a href="shopMain.jsp?pgm=list.jsp?book_kind=all">전체목록보기</a>&nbsp;
          <a href="shopMain.jsp?pgm=cartList.jsp?book_kind=all">장바구니보기</a>&nbsp;
          <a href="shopMain.jsp?pgm=buyList.jsp">구매목록보기</a>&nbsp;
      <br><br> 
      <b><%=session.getAttribute("id")%></b> 님 , 즐거운 쇼핑시간이 되세요.
        <input type="button"  value="로그아웃" onclick="location.href='logout.jsp'">
<%  }  %>      
  </body></html>