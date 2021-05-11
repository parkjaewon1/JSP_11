package bookshop.shopping;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
public class BuyDao {
	private static BuyDao instance = new BuyDao();	
	public static BuyDao getInstance() {
    	return instance;
    }   
    private BuyDao() {}   
    private Connection getConnection() throws Exception {
      	Connection conn=null; 	 
      	Context init = new InitialContext();
     		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
     		conn = ds.getConnection();
         return conn;
    }    
    // bank테이블에 있는 전체 레코드를 얻어내는 메소드
    public ArrayList<String> getAccount(){
    	Connection conn = null; PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<String> accountList = null;
        String sql = "select * from bank";
        try {conn = getConnection();                        
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();            
            accountList = new ArrayList<String>();            
            while (rs.next()) {
            	String account = new String(rs.getString("account")
            	   +" "+ rs.getString("bank")+" "+rs.getString("name"));
           	 	accountList.add(account);
			 }
        }catch(Exception e) {System.out.println(e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return accountList;
    }
    
    //구매 테이블인 buy에 구매목록 등록
    public void insertBuy(ArrayList<Cart> lists,String id, String account, String deliveryName, String deliveryTel,String deliveryAddress) 
    throws Exception {
    	Connection conn = null;  PreparedStatement pstmt = null;
        ResultSet rs = null;     Timestamp reg_date = null;
        String sql = "";         String todayDate = "";
        String compareDate = ""; int buyId = 0;       
        int nowCount ;
        try {
            conn = getConnection();
            reg_date = new Timestamp(System.currentTimeMillis());
            todayDate = reg_date.toString();
            compareDate = todayDate.substring(0, 4) + todayDate.substring(5, 7) + todayDate.substring(8, 10);
            // 구매번호 생성 또는 sequence
            sql = "select nvl(max(buy_id),0) from buy";
            pstmt = conn.prepareStatement(sql);            
            rs = pstmt.executeQuery();
            if (rs.next()) buyId =  rs.getInt(1) + 1;
            // 테이블 여러개를 수정/삭제/입력
            conn.setAutoCommit(false);
            for(int i=0; i<lists.size();i++){
            	//해당 아이디에 대한 cart테이블 레코드를을 가져온후 buy테이블에 추가
            	Cart cart = (Cart)lists.get(i);
            	
            	sql = "insert into buy (buy_id,buyer,book_id,book_title,buy_price,buy_count,";
                sql += "book_image,buy_date,account,deliveryName,deliveryTel,deliveryAddress)";
                sql += " values (?,?,?,?,?,?,?,?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, buyId);
                pstmt.setString(2, id);
                pstmt.setInt(3, cart.getBook_id());
                pstmt.setString(4, cart.getBook_title());
                pstmt.setInt(5, cart.getBuy_price());
                pstmt.setInt(6, cart.getBuy_count());
                pstmt.setString(7, cart.getBook_image());
                pstmt.setTimestamp(8, reg_date);
                pstmt.setString(9, account);
                pstmt.setString(10, deliveryName);
                pstmt.setString(11, deliveryTel);
                pstmt.setString(12, deliveryAddress);

                pstmt.executeUpdate();
                
                //상품이 구매되었으므로 book테이블의 상품수량을 재조정함
                pstmt.close();
                pstmt = conn.prepareStatement("select book_count from book where book_id=?");
                pstmt.setInt(1, cart.getBook_id());
                rs = pstmt.executeQuery();
                rs.next();                
                nowCount = rs.getInt(1) - cart.getBuy_count();
                
                sql = "update book set book_count=? where book_id=?";
                pstmt = conn.prepareStatement(sql);
            
                pstmt.setInt(1, nowCount);
    			pstmt.setInt(2, cart.getBook_id());
                
                pstmt.executeUpdate(); 
                buyId++;
            }
            // 장바구니 데이터 삭제
            sql = "delete from cart where buyer=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
          
            pstmt.executeUpdate();
            conn.commit();
            conn.setAutoCommit(true);
         }catch(Exception e) {System.out.println(e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    //id에 해당하는 buy테이블의 레코드수를 얻어내는 메소드
    public int getListCount(String id) {
        Connection conn = null;  PreparedStatement pstmt = null;
        ResultSet rs = null;     int count = 0;
        try { conn = getConnection();
            String sql = "select count(*) from buy where buyer=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
               count = rs.getInt(1);
			}
        } catch(Exception e) { System.out.println(e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return count ;
    }
    
    //buy테이블의 전체 레코드수를 얻어내는 메소드
    public int getListCount()
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select count(*) from buy");
            rs = pstmt.executeQuery();

            if (rs.next()) {
               x= rs.getInt(1);
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
    
    //id에 해당하는 buy테이블의 구매목록을 얻어내는 메소드
    public ArrayList<Buy> getBuyList(String id)  {
   	    Connection conn = null;  PreparedStatement pstmt = null;
        ResultSet rs = null;     Buy buy=null;
        String sql = "";         
        ArrayList<Buy> lists = null;        
        try { conn = getConnection();       	 
       	 sql = "select * from buy where buyer = ? order by buy_id";
            pstmt = conn.prepareStatement(sql);            
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();            
            lists = new ArrayList<Buy>(); 
            while (rs.next()) {
            	 buy = new Buy();
           	 
           	     buy.setBuy_id(rs.getLong("buy_id"));
           	     buy.setBook_id(rs.getInt("book_id"));
           	     buy.setBook_title(rs.getString("book_title"));
           	     buy.setBuy_price(rs.getInt("buy_price"));
           	     buy.setBuy_count(rs.getInt("buy_count")); 
           	     buy.setBook_image(rs.getString("book_image"));
           	     buy.setSanction(rs.getString("sanction"));
           	 
           	     lists.add(buy);
			 }
        }catch(Exception e) {System.out.println(e.getMessage());
        }finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		 return lists;
    }
    
    //buy테이블의 전체 목록을 얻어내는 메소드
    public ArrayList<Buy> getBuyList()    {
   	    Connection conn = null;  PreparedStatement pstmt = null;
        ResultSet rs = null;     Buy buy=null;
        String sql = "select * from buy order by buy_id desc";
        ArrayList<Buy> lists = null;        
        try { conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();            
            lists = new ArrayList<Buy>();
            while (rs.next()) {
            	 buy = new Buy();
            	 
           	     buy.setBuy_id(rs.getLong("buy_id"));
           	     buy.setBuyer(rs.getString("buyer"));
           	     buy.setBook_id(rs.getInt("book_id"));
           	     buy.setBook_title(rs.getString("book_title"));
           	     buy.setBuy_price(rs.getInt("buy_price"));
           	     buy.setBuy_count(rs.getInt("buy_count")); 
           	     buy.setBook_image(rs.getString("book_image"));
           	     buy.setBuy_date(rs.getTimestamp("buy_date"));
           	     buy.setAccount(rs.getString("account"));
           	     buy.setDeliveryName(rs.getString("deliveryName"));
           	     buy.setDeliveryTel(rs.getString("deliveryTel"));
           	     buy.setDeliveryAddress(rs.getString("deliveryAddress"));
           	     buy.setSanction(rs.getString("sanction"));
           	 
           	     lists.add(buy);
			 }
        }catch(Exception e) {System.out.println(e.getMessage());
        }finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		 return lists;
    }
}