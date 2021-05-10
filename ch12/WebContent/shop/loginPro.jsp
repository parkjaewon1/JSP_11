<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="bookshop.shopping.MemberDao"%>
<%
	request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");	
	MemberDao manager = MemberDao.getInstance();
    int check= manager.loginChk(id, passwd);
	if (check == 1){
		session.setAttribute("id",id);
		response.sendRedirect("shopMain.jsp");
	} else if(check == 0){
%>
    <script> 
	  alert("비밀번호가 맞지 않습니다.");  history.go(-1);
	</script>
<%}else{ %>
	<script>
	  alert("아이디가 맞지 않습니다..");	  history.go(-1);
	</script>
<%}%>