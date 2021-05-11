package bookshop.master;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
public class BookDao {
    private static BookDao instance;
    public static BookDao getInstance() {
    	if (instance==null) {	instance = new BookDao();  	}
        return instance;
    }    
    private BookDao() {}    
    private Connection getConnection() throws Exception {
        Connection conn=null; 	 
      	Context init = new InitialContext();
     		DataSource ds = 
     			(DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
     		conn = ds.getConnection();
         return conn;
    }    
    //  관리자 인증 메소드
    public int managerCheck(String id, String passwd) {
		Connection conn = null;   PreparedStatement pstmt = null;
		ResultSet rs= null;       String dbpasswd="";		int x=-1;        
		try { conn = getConnection();            
            pstmt = conn.prepareStatement(
            	"select managerPasswd from manager where managerId=?");
            pstmt.setString(1, id);            
            rs= pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("managerPasswd"); 
				if(dbpasswd.equals(passwd))		x= 1; //인증 성공
				else			x= 0; //비밀번호 틀림
			}else				x= -1;//해당 아이디 없음			
        } catch(Exception e) {System.out.println(e.getMessage());
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
	}
    
    //책 등록 메소드
    public int insertBook(Book book) {
        Connection conn = null;     int result = 0;
        PreparedStatement pstmt = null;      
        try {  conn = getConnection();
            String str ="insert into book values ("
            	+ "book_seq.nextval,?,?,?,?,?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(str);
         //   pstmt.setInt(1,book.getBook_id());
            pstmt.setString(1, book.getBook_kind());
            pstmt.setString(2, book.getBook_title());
            pstmt.setInt(3, book.getBook_price());
            pstmt.setInt(4, book.getBook_count());
            pstmt.setString(5, book.getAuthor());
            pstmt.setString(6, book.getPublishing_com());
			pstmt.setString(7, book.getPublishing_date());
			pstmt.setString(8, book.getBook_image());
			pstmt.setString(9, book.getBook_content());
			pstmt.setInt(10,book.getDiscount_rate());
			pstmt.setTimestamp(11, book.getReg_date());
			
            result = pstmt.executeUpdate();
            
        } catch(Exception e) { System.out.println(e.getMessage());
           
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return result;
    }
    
    //이미등록된 책을 검증
	public int registedBookconfirm(String kind, String bookName, String author) 
	throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
		int x=-1;
        
		try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select book_name from book where book_kind = ? and book_name = ? and author = ?");
            pstmt.setString(1, kind);
            pstmt.setString(2, bookName);
            pstmt.setString(3, author);
            
            rs= pstmt.executeQuery();

			if(rs.next())
				x= 1; //해당 책이 이미 등록되어 있음
			else
				x= -1;//해당 책이 이미 등록되어 있지 않음	
			
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
	}
    
	// 전체등록된 책의 수를 얻어내는 메소드
	public int getBookCount()   {
        Connection conn = null; PreparedStatement pstmt = null;
        ResultSet rs = null;    int x=0;
        try { conn = getConnection();            
            pstmt = conn.prepareStatement("select count(*) from book");
            rs = pstmt.executeQuery();
            if (rs.next()) {   x = rs.getInt(1);}
        } catch(Exception e) { System.out.println(e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
	
	// 분류별또는 전체등록된 책의 정보를 얻어내는 메소드
	public ArrayList<Book> getBooks(String book_kind) {
        Connection conn = null;     PreparedStatement pstmt = null;
        ResultSet rs = null;        
        ArrayList<Book> bookList=null;  
        String sql1="select * from book order by reg_date desc";
        String sql2 = "select * from book where " +
        		"book_kind = ? order by reg_date desc";
        try { conn = getConnection();           
            if(book_kind.equals("all")){
            	 pstmt = conn.prepareStatement(sql1);
            }else{
                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, book_kind);
            }
        	rs = pstmt.executeQuery();
            bookList = new ArrayList<Book>();
            while(rs.next()){
                Book book= new Book();
                book.setBook_id(rs.getInt("book_id"));
                book.setBook_kind(rs.getString("book_kind"));
                book.setBook_title(rs.getString("book_title"));
                book.setBook_price(rs.getInt("book_price"));
                book.setBook_count(rs.getInt("book_count"));
                book.setAuthor(rs.getString("author"));
                book.setPublishing_com(rs.getString("publishing_com"));
                book.setPublishing_date(rs.getString("publishing_date"));
                book.setBook_image(rs.getString("book_image"));
                book.setDiscount_rate(rs.getInt("discount_rate"));
                book.setReg_date(rs.getTimestamp("reg_date"));
                   
                bookList.add(book);
			}
        } catch(Exception e) {System.out.println(e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return bookList;
    }
	
	// 쇼핑몰 메인에 표시하기 위해서 사용하는 분류별 신간책목록을 얻어내는 메소드
	public Book[] getBooks(String book_kind,int count) {
        Connection conn = null;  PreparedStatement pstmt = null;
        ResultSet rs = null;
        Book bookList[]=null;       int i = 0;        
        try { conn = getConnection();           
            pstmt = conn.prepareStatement(
               "select * from (select * from book where book_kind" +
            	" = ? order by reg_date desc) where rownum <= ?");
            pstmt.setString(1, book_kind);
            pstmt.setInt(2, count);          
        	rs = pstmt.executeQuery();
            if (rs.next()) {
                bookList = new Book[count];
                do{  Book book= new Book();
                     book.setBook_id(rs.getInt("book_id"));
                     book.setBook_kind(rs.getString("book_kind"));
                     book.setBook_title(rs.getString("book_title"));
                     book.setBook_price(rs.getInt("book_price"));
                     book.setBook_count(rs.getInt("book_count"));
                     book.setAuthor(rs.getString("author"));
                     book.setPublishing_com(rs.getString("publishing_com"));
                     book.setPublishing_date(rs.getString("publishing_date"));
                     book.setBook_image(rs.getString("book_image"));
                     book.setDiscount_rate(rs.getInt("discount_rate"));
                     book.setReg_date(rs.getTimestamp("reg_date"));
                     bookList[i]=book;
                     i++;
			    }while(rs.next());
			}
        } catch(Exception e) { System.out.println(e.getMessage());  } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return bookList;
    }
	
	// bookId에 해당하는 책의 정보를 얻어내는 메소드로 ,등록된 책을 수정하기 위해 수정폼으로 읽어들기이기 위한 메소드
	public Book getBook(int bookId) {
        Connection conn = null;     PreparedStatement pstmt = null;
        ResultSet rs = null;        Book book=null; 
        String sql = "select * from book where book_id = ?";
        try { conn = getConnection();            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookId); rs = pstmt.executeQuery();
            if (rs.next()) {
                book = new Book();                
                book.setBook_kind(rs.getString("book_kind"));
                book.setBook_title(rs.getString("book_title"));
                book.setBook_price(rs.getInt("book_price"));
                book.setBook_count(rs.getInt("book_count"));
                book.setAuthor(rs.getString("author"));
                book.setPublishing_com(rs.getString("publishing_com"));
                book.setPublishing_date(rs.getString("publishing_date"));
                book.setBook_image(rs.getString("book_image"));
                book.setBook_content(rs.getString("book_content"));
                book.setDiscount_rate(rs.getInt("discount_rate"));
			}
        } catch(Exception e) { System.out.println(e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return book;
    }
    
    // 등록된 책의 정보를 수정시 사용하는 메소드
    public int updateBook(Book book, int bookId) {
        Connection conn = null;    PreparedStatement pstmt = null;
        String sql, sql1;                int result = 0;        
        try { conn = getConnection();  
        // image가 있는 경우
            sql = "update book set book_kind=?,book_title=?,book_price=?,book_count=?,author=? ";
            sql += ",publishing_com=?,publishing_date=?,book_content=?,discount_rate=?,book_image=?";
            sql += " where book_id=?";  
        // 이미지가 없는 경우    수정하지 않으면 먼저 이미지를 가지고 있는다
            sql1 = "update book set book_kind=?,book_title=?,book_price=?,book_count=?,author=? ";
            sql1 += ",publishing_com=?,publishing_date=?,book_content=?,discount_rate=?";
            sql1 += " where book_id=?"; 
            if (book.getBook_image()==null) {
            	pstmt = conn.prepareStatement(sql1);
    			pstmt.setInt(10, bookId);
            } else {
            	pstmt = conn.prepareStatement(sql);
            	pstmt.setString(10, book.getBook_image());
    			pstmt.setInt(11, bookId);
            }            
            pstmt.setString(1, book.getBook_kind());
            pstmt.setString(2, book.getBook_title());
            pstmt.setInt(3, book.getBook_price());
            pstmt.setInt(4, book.getBook_count());
            pstmt.setString(5, book.getAuthor());
            pstmt.setString(6, book.getPublishing_com());
			pstmt.setString(7, book.getPublishing_date());	
			pstmt.setString(8, book.getBook_content());
			pstmt.setInt(9, book.getDiscount_rate());
            
            result = pstmt.executeUpdate();
            
        } catch(Exception e) {System.out.println(e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return result;
    }
     
    // bookId에 해당하는 책의 정보를 삭제시 사용하는 메소드
    public int deleteBook(int bookId)   {
        Connection conn = null;  PreparedStatement pstmt = null;
        int result = 0;  
        String sql = "delete from book where book_id=?";
        try { 
        	conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookId);            
            result = pstmt.executeUpdate();            
        } catch(Exception e) {System.out.println(e.getMessage()); 
        } finally {           
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn  != null) try { conn.close();  } catch(SQLException ex) {}
        }
        return result;
    }
}