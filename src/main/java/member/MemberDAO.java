package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.JdbcUtil;

public class MemberDAO {
	
	// 아이디 중복 확인 메소드
	// => 파라미터 : 아이디(id) 	리턴타입 : boolean(isDuplicate)
	public boolean checkId(String id) {
		
		boolean isDuplicate = false;
		
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 1,2단계
			Connection con = JdbcUtil.getConnection();
			
			// SELECT 구문을 사용하여 아이디가 일치하는 레코드 검색
			// => 아이디가 일치하는 레코드가 있을 경우 isDuplicate 변수값을 true로 변경
			
			try {
				String sql = "SELECT * FROM member WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					isDuplicate = true;
				} else {
					isDuplicate = false;
				}
			} catch (SQLException e) {
				
				System.out.println("SQL 구문 오류! - checkId()");
				e.printStackTrace();
				
			}	finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
		
			
			return isDuplicate;
			
		}
	
//-------------------------------------------------------------------------------------	
	// 회원가입 작업 - insertMember()
	// => 파라미터 : MemberDTO 객체(member)		리턴타입 : int(insertCount)
	// member보드에 회원가입정보 입력하는 메서드
	public int insertMember(MemberDTO member) {
		
		int insertCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		con = JdbcUtil.getConnection();
		
		try {
			
			String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getMobile());
			pstmt.setString(5, member.getEmail1());
			pstmt.setString(6, member.getEmail2());
			pstmt.setString(7, member.getEmailw());
			pstmt.setString(8, member.getCamera());
			pstmt.setString(9, member.getPost_code());
			pstmt.setString(10, member.getAddress1());
			pstmt.setString(11, member.getAddress2());
			pstmt.setString(12, member.getPhone());
			
			
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - insertMember()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	
	public int myPagePassCheck(String id, String pass) {
		
		int result = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				result = 1;
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - myPagePassCheck()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return result;
	}
	
	// member보드에 회원정보 조회에서 뿌려주는 메서드
	public MemberDTO selectMember(String id,String pass) {
		
		MemberDTO member = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDTO();
				
				member.setId(id);
				member.setPass(pass);
				member.setName(rs.getString("name"));
				member.setMobile(rs.getString("mobile"));
				member.setEmail1(rs.getString("email1"));
				member.setEmail2(rs.getString("email2"));
				member.setEmailw(rs.getString("emailw"));
				member.setCamera(rs.getString("camera"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPost_code(rs.getString("post_code"));
				member.setPhone(rs.getString("phone"));
				member.setDate(rs.getTimestamp("date"));
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectMember()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		System.out.println(member);
		
		return member;
	

	}
	// admin_member보드에 회원정보 조회에서 뿌려주는 메서드
	public MemberDTO selectMember(String id) {
		
		MemberDTO member = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDTO();
				
				member.setId(id);
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setMobile(rs.getString("mobile"));
				member.setEmail1(rs.getString("email1"));
				member.setEmail2(rs.getString("email2"));
				member.setEmailw(rs.getString("emailw"));
				member.setCamera(rs.getString("camera"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPost_code(rs.getString("post_code"));
				member.setPhone(rs.getString("phone"));
				member.setDate(rs.getTimestamp("date"));
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectMember()");
			e.printStackTrace();
		
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		
		return member;
		
		
	}
	
	
	
	// member보드에 회원정보수정해서 업데이트하는 메서드
	public int updateMember(MemberDTO member){
		int updateCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "UPDATE member SET pass=?,name=?,mobile=?,email1=?,email2=?,emailw=?,camera=?,post_code=?,address1=?,address2=?,phone=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getPass());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getMobile());
			pstmt.setString(4, member.getEmail1());
			pstmt.setString(5, member.getEmail2());
			pstmt.setString(6, member.getEmailw());
			pstmt.setString(7, member.getCamera());
			pstmt.setString(8, member.getPost_code());
			pstmt.setString(9, member.getAddress1());
			pstmt.setString(10, member.getAddress2());
			pstmt.setString(11, member.getPhone());
			pstmt.setString(12, member.getId());
			
			updateCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - updateMember()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
		return updateCount;
	}
	
	// 관리자 계정에 회원정보 목록 뿌려주는 기능 
	public ArrayList<MemberDTO> selectMemberList(int startRow, int listLimit){
		ArrayList<MemberDTO> memberList = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id NOT IN ('admin') ORDER BY date DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			
			rs = pstmt.executeQuery();
		
			memberList = new ArrayList<MemberDTO>();
			
			while(rs.next()) {
				MemberDTO member = new MemberDTO();
				
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setMobile(rs.getString("mobile"));
				member.setEmail1(rs.getString("email1"));
				member.setEmail2(rs.getString("email2"));
				member.setEmailw(rs.getString("emailw"));
				member.setCamera(rs.getString("camera"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPost_code(rs.getString("post_code"));
				member.setPhone(rs.getString("phone"));
				member.setDate(rs.getTimestamp("date"));
				
				memberList.add(member);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectMemberList()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
	
		return memberList;
	}
	
	
	
	// 회원정보조회에서 한페이지에 보여줄 회원수 계산기능
	public int selectMemberListCount() {
		int memberListCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			// 게시물 목록 갯수 조회 => COUNT(*) 함수 사용
			String sql = "SELECT COUNT(*) FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - memberListCount()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return memberListCount;
	}
	
	// 관리자가 강제탈퇴시키는 기능
	public int deleteMember(String id) {
		int result = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		con = JdbcUtil.getConnection();
		
		
			
			try {
				String sql = "DELETE FROM member WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - deleteMember()");
				e.printStackTrace();
				
			}finally {
				
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
		
		
		return result;
	}
	
	// 회원 본인이 탈퇴하는 기능
	public int deleteMember(String id,String pass) {
		int result = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		con = JdbcUtil.getConnection();
		
		
		
		try {
			String sql = "DELETE FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - deleteMember()");
			e.printStackTrace();
			
		}finally {
			
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return result;
	}
}
