<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bookshop.shopping.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title></head><body>
<%	request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="bookshop.shopping.Member"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%	MemberDao md = MemberDao.getInstance();
	int result   = md.insert(member);
	if (result >0) {
%>
<script type="text/javascript">
	alert("입력 성공 ㅋㅋ"); 
	location.href="main.jsp";
</script>
<%  } else { %>
<script type="text/javascript">
	alert("똑바로 해 쟈사"); 
	history.go(-1);
</script>
<%  } %>
</body>
</html>