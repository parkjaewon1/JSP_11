<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="bookshop.shopping.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title></head><body>
<%	String id = request.getParameter("id");
	String password = request.getParameter("password");
	MemberDao md = MemberDao.getInstance();
	int result   = md.loginChk(id, password); 
	if (result > 0) {
		session.setAttribute("id", id);
		response.sendRedirect("main.jsp");
    } else if (result == 0) { %>
<script type="text/javascript">
	alert("암호가 다르네 간첩이지");  history.go(-1);
</script>
<%  } else { %>
<script type="text/javascript">
	alert("넌 누구냐 15년동안 만두만 주고"); history.go(-1);
</script>
<%  } %>
</body>
</html>