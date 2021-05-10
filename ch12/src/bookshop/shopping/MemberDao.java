package bookshop.shopping;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.sql.*;
import javax.naming.*;
public class MemberDao {
	private static MemberDao instance; // = new MemberDao();
	private MemberDao() {	}
	public static MemberDao getInstance() {
		if (instance == null) instance = new MemberDao();
		return instance;
	}
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)
				ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch(Exception e) {
			System.out.println("연결에러 : "+e.getMessage());
		}
		return conn;
	}
	public int confirm(String id) {
		int result = 1;	Connection conn = null;
		PreparedStatement pstmt = null; ResultSet rs = null;
		String sql = "select id from member2 where id=?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs    = pstmt.executeQuery();
			if (rs.next()) result = 1;
			else result = 0;
		}catch(Exception e) { System.out.println(e.getMessage());			
		}finally {
			try{if (rs    != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn  != null) conn.close();
			}catch(Exception e) {}
		}
		return result;
	}
	public int insert(Member member) {
		int result = 0;	Connection conn = null;
		PreparedStatement pstmt = null; 
		String sql=
			"insert into member2 values (?,?,?,?,?,sysdate,'n')";
		try {conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getTel());
			result    = pstmt.executeUpdate();
		}catch(Exception e) { System.out.println(e.getMessage());			
		}finally {
			try{
				if (pstmt != null) pstmt.close();
				if (conn  != null) conn.close();
			}catch(Exception e) {}
		}
		return result;
	}
	public int loginChk(String id, String passwd) {
		int result = 0;	Connection conn = null;
		PreparedStatement pstmt = null; ResultSet rs = null;
		String sql = 
			"select passwd from member2 where id=? and del!='y'";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs    = pstmt.executeQuery();
			if (rs.next()) {
				// String dbPass = rs.getString("passwd");
				String dbPass = rs.getString(1);
				if (dbPass.equals(passwd)) result = 1;
				else result = 0;
			} else result   = -1;
		}catch(Exception e) { System.out.println(e.getMessage());			
		}finally {
			try{if (rs    != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn  != null) conn.close();
			}catch(Exception e) {}
		}
		return result;
	}
	public Member select(String id) {
		Member mem = new Member();	Connection conn = null;
		PreparedStatement pstmt = null; ResultSet rs = null;
		String sql="select * from member2 where id=? and del='n'";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs    = pstmt.executeQuery();
			if (rs.next()) {
				mem.setId(rs.getString("id"));
				mem.setPasswd(rs.getString("passwd"));
				mem.setName(rs.getString("name"));
				mem.setAddress(rs.getString("address"));
				mem.setTel(rs.getString("tel"));
			} 
		}catch(Exception e) { System.out.println(e.getMessage());			
		}finally {
			try{if (rs    != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn  != null) conn.close();
			}catch(Exception e) {}
		}
		return mem;
	}
	public int update(Member member) {
		int result = 0;	Connection conn = null;
		PreparedStatement pstmt = null; 
		String sql="update member2 set passwd=?,name=?,"+
				"address=?,tel=? where id=?";
		try {conn  = getConnection();
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getAddress());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getId());
			result    = pstmt.executeUpdate();
		}catch(Exception e) { System.out.println(e.getMessage());			
		}finally {
			try{
				if (pstmt != null) pstmt.close();
				if (conn  != null) conn.close();
			}catch(Exception e) {}
		}
		return result;
	}
	public int delete(String id) {
		int result = 0;	Connection conn = null;
		PreparedStatement pstmt = null; 
		// String sql="delete from member2 where id=?";
		String sql="update member2 set del='y' where id=?";
		try {conn  = getConnection();
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, id);
			result    = pstmt.executeUpdate();
		}catch(Exception e) { System.out.println(e.getMessage());			
		}finally {
			try{
				if (pstmt != null) pstmt.close();
				if (conn  != null) conn.close();
			}catch(Exception e) {}
		}
		return result;
	}
//	public List<Member> list() {
	public List<Member> list(int startRoow, int endRow) {
		List<Member> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		// String sql = "select * from member2 where del !='y'";
	//	String sql="select * from member2 order by reg_date desc";
		String sql = "select * from (select a.*, rownum rn "
			+ "from (select * from member2 order by "
			+ "reg_date desc ) a) where rn between ? and ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRoow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();	
			while(rs.next()) { 
				Member mem = new Member();
				mem.setId(rs.getString("id"));
				mem.setPasswd(rs.getString("passwd"));
				mem.setName(rs.getString("name"));
				mem.setAddress(rs.getString("address"));
				mem.setTel(rs.getString("tel"));
				mem.setReg_date(rs.getDate("reg_date"));
				mem.setDel(rs.getString("del"));
				list.add(mem);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) { }
		}
		return list;
	}
	public int getTotal() {
		int result = 0;   Connection conn = null;
		PreparedStatement pstmt = null;	ResultSet rs =null;
		String sql="select count(*) from member2";
		try {conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();	
			while(rs.next()) { 
				result = rs.getInt(1);
			}
		} catch(Exception e){System.out.println(e.getMessage());			
		} finally {
			try {if (rs != null) rs.close();
				 if (pstmt != null) pstmt.close();
				 if (conn != null) conn.close();
			} catch (Exception e) { }
		}
		return result;
	}
}