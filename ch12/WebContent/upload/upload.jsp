<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title></head><body>
<%	String real = application.getRealPath("/fileSave");
	int maxSize = 1024 * 1024 * 10;
	MultipartRequest mr = new MultipartRequest(request, real,
		maxSize, "utf-8", new DefaultFileRenamePolicy());
	String title = mr.getParameter("title");
	String name  = mr.getParameter("name");
	String fileName = mr.getFilesystemName("file");
	String origin   = mr.getOriginalFileName("file");
	File file    = mr.getFile("file");
	int fileSize = 0;
	if (file !=null) fileSize = (int)file.length();
%>
제목 : <%=title %><br>
작성자 : <%=name %><br>
파일명 : <%=fileName %><br>
원이름 : <%=origin %><br>
사이즈 : <%=fileSize %><br>
<img alt="" src="../fileSave/<%=fileName%>">
</body>
</html>