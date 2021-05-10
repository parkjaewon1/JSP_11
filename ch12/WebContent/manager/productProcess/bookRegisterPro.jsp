<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="bookshop.master.*" %>
<%@ page import="java.sql.Timestamp,com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*,java.io.*"%> 
<% 	request.setCharacterEncoding("utf-8"); %>
<%
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename ="";
	MultipartRequest imageUp = null;
	String saveFolder = "/imageFile";//파일이 업로드되는 폴더를 지정한다.
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb
	realFolder = application.getRealPath(saveFolder);  

	imageUp = new MultipartRequest(request,realFolder,
		   maxSize,encType,new DefaultFileRenamePolicy());   
    filename = imageUp.getFilesystemName("book_image");

	Book book = new Book();
	String book_kind = imageUp.getParameter("book_kind");
 	String book_title = imageUp.getParameter("book_title");
 	String book_price = imageUp.getParameter("book_price");
 	String book_count = imageUp.getParameter("book_count");
	String author = imageUp.getParameter("author");
 	String publishing_com = imageUp.getParameter("publishing_com");
 	String book_content = imageUp.getParameter("book_content");
 	String discount_rate = imageUp.getParameter("discount_rate");

	/* String year = imageUp.getParameter("publishing_year");
	String month = (imageUp.getParameter("publishing_month").length()==1)?"0"+ imageUp.getParameter("publishing_month"): imageUp.getParameter("publishing_month");
	String day =  (imageUp.getParameter("publishing_day").length()==1)?"0"+ imageUp.getParameter("publishing_day"): imageUp.getParameter("publishing_day"); */
	String publishing_date = imageUp.getParameter("publishing_date");
	book.setBook_kind(book_kind);
	book.setBook_title(book_title);
	book.setBook_price(Integer.parseInt(book_price));
	book.setBook_count(Integer.parseInt(book_count));
	book.setAuthor(author);
	book.setPublishing_com(publishing_com);
	// book.setPublishing_date(year+"-"+month+"-"+day);
	book.setPublishing_date(publishing_date);
	book.setBook_image(filename);
	book.setBook_content(book_content);
	book.setDiscount_rate(Integer.parseInt(discount_rate));
	book.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	BookDao bookProcess = BookDao.getInstance();
	int result = bookProcess.insertBook(book);
	
	if (result > 0) {	
		response.sendRedirect("bookList.jsp?book_kind="+book_kind);
	} else {
%>
		 <script type="text/javascript">
			alert("데이터 입력중에 에러가 발생했습니다. 메세지 확인하세요");
			history.go(-1);
			//	location.href = 'bookRegisterForm.jsp';
		</script>
<%  }  %>