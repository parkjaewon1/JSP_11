<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> 
<%@ page import = "bookshop.master.*,java.sql.Timestamp" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import = "java.util.*,java.io.*"%>
<%@ include file="../managerSessionChk.jsp" %>
<%
   request.setCharacterEncoding("utf-8");
   String realFolder = "";
   String filename   ="";
   MultipartRequest imageUp = null;

   String saveFolder = "/imageFile"; 
   String encType    = "utf-8"; 
   int maxSize = 5*1024*1024; 
   ServletContext context = getServletContext();
   realFolder = context.getRealPath(saveFolder);  
   imageUp = new MultipartRequest(request,realFolder,maxSize,
		  encType,new DefaultFileRenamePolicy());
   //전송한 파일 정보를 가져와 출력한다
   Enumeration files = imageUp.getFileNames();   
   //파일 정보가 있다면
   while(files.hasMoreElements()){
    //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
      String name = (String)files.nextElement();   
   //서버에 저장된 파일 이름
      filename = imageUp.getFilesystemName(name);
   }

  Book book = new Book();
  int book_id= Integer.parseInt( imageUp.getParameter("book_id"));
  String book_kind  = imageUp.getParameter("book_kind");
  String book_title = imageUp.getParameter("book_title");
  String book_price = imageUp.getParameter("book_price");
  String book_count = imageUp.getParameter("book_count");
  String author         = imageUp.getParameter("author");
  String publishing_com = imageUp.getParameter("publishing_com");
  String book_content   = imageUp.getParameter("book_content");
  String discount_rate  = imageUp.getParameter("discount_rate");
  String publishing_date = imageUp.getParameter("publishing_date"); 
 /*  String year = imageUp.getParameter("publishing_year");
  String month=(imageUp.getParameter("publishing_month").length()==1)?"0"+ imageUp.getParameter("publishing_month"): imageUp.getParameter("publishing_month");
  String day = (imageUp.getParameter("publishing_day").length()==1)?"0"+ imageUp.getParameter("publishing_day"): imageUp.getParameter("publishing_day");
 */
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
  int result = bookProcess.updateBook(book, book_id); 
  if (result > 0 ) {
  	response.sendRedirect("bookList.jsp?book_kind="+book_kind);
  } else {
%>
	<script type="text/javascript">
		alert("수정중에 에러 발생, 콘솔 메세지를 확인하세요");
		history.go(-1);
	</script>
<%  }  %>