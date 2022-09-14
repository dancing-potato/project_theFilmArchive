package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.JdbcUtil;

public class ArchiveDAO {
	
	// myArchive와 community에 사진 등록하는 메서드 
	public int insertArchive(ArchiveDTO archive) {
		int insertCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;
		
		// 1,2단계
		con = JdbcUtil.getConnection();
		
		try {
			
			int num = 1;
			
			// 현재 게시물 중 가장 큰 번호(num)조회 = max() 함수 활용
			String sql = "SELECT MAX(num) FROM archive";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			// 만약, 조회결과가 있을 경우 해당 글 번호 +1 값을 새 글 번호(num)로 저장
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			// ----------------------------------------------------------
			
			sql = "INSERT INTO archive VALUES(?,?,?,?,?,?,?,?,?,now())";
			pstmt2 = con.prepareStatement(sql);
			
			pstmt2.setInt(1, num);
			pstmt2.setString(2, archive.getName());
			pstmt2.setString(3, archive.getPass());
			pstmt2.setString(4, archive.getType());
			pstmt2.setString(5, archive.getSubject());
			pstmt2.setString(6, archive.getContent());
			pstmt2.setString(7, archive.getOriginal_file());
			pstmt2.setString(8, archive.getReal_file());
			pstmt2.setInt(9, 0); // 조회수
			
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - insertArchive()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(con);
			
		}
		
		return insertCount;
	}
	
	
//-------------------------------------------------------------------------------------------------------------	
	// 조회수 증가기능 수행 
		public void updateReadcount(int num) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			con = JdbcUtil.getConnection();
			
			try {
				String sql="UPDATE archive SET readcount=readcount+1 WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("SQL구문 오류 발생! - updateReadcount()");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
				
			}
			
			
		}
	
	
//-------------------------------------------------------------------------------------------------------------	
// "나의" 전체 게시물 수 조회하는 selectMyArchiveListCount() 메서드 정의
// => 파라미터 : 세션아이디 	리턴타입: int(MyArchiveListCount)
		public int selectMyArchiveListCount(String id) {
			int MyArchiveListCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			try {
				// 게시물 목록 갯수 조회 => COUNT(*) 함수 사용
				String sql = "SELECT COUNT(*) FROM archive WHERE name=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					MyArchiveListCount = rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - selectBoardListCount()");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			
			
			return MyArchiveListCount;
		}
//-------------------------------------------------------------------------------------------------------------		
//	"나의"  전체 게시물 수 조회하는 selectMyArchiveListCount() 메서드 정의(검색기능 추가)
// => 파라미터 : 아이디,검색어(keyword) 	리턴타입: int(MyArchiveListCount)
		public int selectMyArchiveListCount(String id,String keyword) {
			int MyArchiveListCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			try {
				// 게시물 목록 갯수 조회 => COUNT(*) 함수 사용
				// => 검색기능이 추가됐으므로 WHERE 절에 검색어 추가
				String sql = "SELECT COUNT(*) FROM archive WHERE name=? AND subject LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, "%" + keyword + "%"); // 검색어를 포함하기 위해 %결합
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					MyArchiveListCount = rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - selectBoardListCount()");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			
			
			return MyArchiveListCount;
		}
		
//-------------------------------------------------------------------------------------------------------------
// 게시물 목록 조회를 수행하는 selectBoardList() 메서드 정의(검색 기능 추가)
// => 파라미터 : 시작 행번호, 페이지 당 게시물 목록 수,검색어,키워드   
	
		public ArrayList<ArchiveDTO> selectCommBoardList(int startRow, int listLimit,String keyword,String select) {
					
					ArrayList<ArchiveDTO> commBoardList = null;
				
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					 
					con = JdbcUtil.getConnection();
							
					try {
						
						String sql = "SELECT * FROM archive WHERE " + select + " LIKE ? ORDER BY num DESC LIMIT ?,?";
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%" + keyword + "%");
						pstmt.setInt(2, startRow);
						pstmt.setInt(3, listLimit);
						
						rs = pstmt.executeQuery();
						
						// 전체 게시물 목록을 저장할 ArrayList 객체 생성
						commBoardList = new ArrayList<ArchiveDTO>();  // BoardDTO 객체 저장 전용 ArrayList 객체 생성됨
						
						
						// 조회 결과가 있을 경우 레코드 접근 작업 반복
						while(rs.next()) {
							// 1개 레코드 저장할 BoardDTO 객체 생성 후 데이터 저장
							ArchiveDTO archive = new ArchiveDTO();
							
							archive.setNum(rs.getInt("num"));
							archive.setName(rs.getString("name"));
							archive.setPass(rs.getString("pass"));
							archive.setType(rs.getString("type"));
							archive.setSubject(rs.getString("subject"));
							archive.setContent(rs.getString("content"));
							archive.setOriginal_file(rs.getString("original_file"));
							archive.setReal_file(rs.getString("real_file"));
							archive.setReadcount(rs.getInt("readcount"));
							archive.setDate(rs.getTimestamp("date"));
									
							// 전체 레코드를 저장할 ArrayList<ArchiveDTO> 객체에 1개 레코드가 저장된 ArchiveDTO 객체 추가
							commBoardList.add(archive);
							
							
						}
					} catch (SQLException e) {
						System.out.println("SQL 구문 오류 발생! - selectCommBoardList()");
						e.printStackTrace();
					} finally {
						// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출
						JdbcUtil.close(rs);
						JdbcUtil.close(pstmt);
						JdbcUtil.close(con);
						
					}
					
					
					return commBoardList;
				}
			
//-------------------------------------------------------------------------------------------------------------
		// 전체 사진게시물 목록 조회를 수행하는 selectArchiveBoardList() 메서드 정의
		// => 파라미터 : 시작 행번호, 페이지 당 게시물 목록 수   
		//    리턴타입 : ArrayList(archiveBoardList)
		public ArrayList<ArchiveDTO> selectCommBoardList(int startRow, int listLimit) {
			
			// <>에 클래스이름을 넣으면 그 클래스 애만 넣을수있다. 
			// => 검사 할 필요가 없고, 나중에 꺼낼 때 변환 할 필요가 없다.
			
			// ArrayList 타입 사용 시 클래스명 뒤에 <> 기호를 쓰고, 기호 사이에 클래스타입을 지정하면
			// 해당 ArrayList 객체에서 사용되는 데이터는 모두 지정된 클래스 타입 데이터로만 사용된다!
			ArrayList<ArchiveDTO> commBoardList = null; // ArrayList에서 사용할 데이터를 ArchiveDTO 타입으로 고정
			
			// DB 작업에 사용할 변수 선언
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			 
			// 1단계 & 2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
			// => static 메서드이므로 클래스명만으로 접근 가능함
			con = JdbcUtil.getConnection();
					
			try {
				// 3단계. SQL 구문 작성 및 전달
				// => board 테이블의 모든 레코드 조회(num 기준 내림차순 정렬, 10개로 제한)
				//	  단, 글번호(num) 기준 내림차순 정렬(DESC)
				//	  시작행 번호부터 페이지 당 게시물 목록 수 만큼만 조회
				//	 ( LIMIT 시작행번호, 페이지 당 게시물 목록 수)
				String sql = "SELECT * FROM archive ORDER BY num DESC LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, listLimit);
				
				// 4단계. SQL 구문 실행 및 결과 처리
				rs = pstmt.executeQuery();
				
				// 전체 게시물 목록을 저장할 ArrayList 객체 생성
				commBoardList = new ArrayList<ArchiveDTO>();  // BoardDTO 객체 저장 전용 ArrayList 객체 생성됨
				
				
				// 조회 결과가 있을 경우 레코드 접근 작업 반복
				while(rs.next()) {
					// 1개 레코드 저장할 BoardDTO 객체 생성 후 데이터 저장
					ArchiveDTO archive = new ArchiveDTO();
					
					archive.setNum(rs.getInt("num"));
					archive.setName(rs.getString("name"));
					archive.setPass(rs.getString("pass"));
					archive.setType(rs.getString("type"));
					archive.setSubject(rs.getString("subject"));
					archive.setContent(rs.getString("content"));
					archive.setOriginal_file(rs.getString("original_file"));
					archive.setReal_file(rs.getString("real_file"));
					archive.setReadcount(rs.getInt("readcount"));
					archive.setDate(rs.getTimestamp("date"));
							
					// 전체 레코드를 저장할 ArrayList<ArchiveDTO> 객체에 1개 레코드가 저장된 ArchiveDTO 객체 추가
					commBoardList.add(archive);
					
					
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! -  selectCommBoardList()");
				e.printStackTrace();
			} finally {
				// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
				
			}
			
			
			return commBoardList;
		}
		
//----------------------------------------------------------------------------		
		public ArrayList<ArchiveDTO> selectCommBoardList(int startRow, int listLimit,String type) {
			
			// <>에 클래스이름을 넣으면 그 클래스 애만 넣을수있다. 
			// => 검사 할 필요가 없고, 나중에 꺼낼 때 변환 할 필요가 없다.
			
			// ArrayList 타입 사용 시 클래스명 뒤에 <> 기호를 쓰고, 기호 사이에 클래스타입을 지정하면
			// 해당 ArrayList 객체에서 사용되는 데이터는 모두 지정된 클래스 타입 데이터로만 사용된다!
			ArrayList<ArchiveDTO> commBoardList = null; // ArrayList에서 사용할 데이터를 ArchiveDTO 타입으로 고정
			
			// DB 작업에 사용할 변수 선언
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			// 1단계 & 2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
			// => static 메서드이므로 클래스명만으로 접근 가능함
			con = JdbcUtil.getConnection();
			
			try {
				// 3단계. SQL 구문 작성 및 전달
				// => board 테이블의 모든 레코드 조회(num 기준 내림차순 정렬, 10개로 제한)
				//	  단, 글번호(num) 기준 내림차순 정렬(DESC)
				//	  시작행 번호부터 페이지 당 게시물 목록 수 만큼만 조회
				//	 ( LIMIT 시작행번호, 페이지 당 게시물 목록 수)
				String sql = "SELECT * FROM archive WHERE type=? ORDER BY num DESC LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, type);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, listLimit);
				
				// 4단계. SQL 구문 실행 및 결과 처리
				rs = pstmt.executeQuery();
				
				// 전체 게시물 목록을 저장할 ArrayList 객체 생성
				commBoardList = new ArrayList<ArchiveDTO>();  // BoardDTO 객체 저장 전용 ArrayList 객체 생성됨
				
				
				// 조회 결과가 있을 경우 레코드 접근 작업 반복
				while(rs.next()) {
					// 1개 레코드 저장할 BoardDTO 객체 생성 후 데이터 저장
					ArchiveDTO archive = new ArchiveDTO();
					
					archive.setNum(rs.getInt("num"));
					archive.setName(rs.getString("name"));
					archive.setPass(rs.getString("pass"));
					archive.setType(rs.getString("type"));
					archive.setSubject(rs.getString("subject"));
					archive.setContent(rs.getString("content"));
					archive.setOriginal_file(rs.getString("original_file"));
					archive.setReal_file(rs.getString("real_file"));
					archive.setReadcount(rs.getInt("readcount"));
					archive.setDate(rs.getTimestamp("date"));
					
					// 전체 레코드를 저장할 ArrayList<ArchiveDTO> 객체에 1개 레코드가 저장된 ArchiveDTO 객체 추가
					commBoardList.add(archive);
					
					
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! -  selectCommBoardList()");
				e.printStackTrace();
			} finally {
				// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
				
			}
			
			
			return commBoardList;
		}
	
//-------------------------------------------------------------------------------------------------------------		
			// 나의 사진목록조회를 수행하는 selectMyArchiveList() 메서드 정의
			// 파라미터 : 아이디, 시작행번호, 페이지당 게시물 목록 수 
			// 리턴타입 : ArrayList(myArchiveList)
		
		public ArrayList<ArchiveDTO> selectMyArchiveList(String sId,int startRow, int listLimit){
			
			ArrayList<ArchiveDTO> myArchiveList = null; 
			
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			 
			
			con = JdbcUtil.getConnection();
					
			try {
				// 3단계. SQL 구문 작성 및 전달
				// => board 테이블의 모든 레코드 조회(num 기준 내림차순 정렬, 10개로 제한)
				//	  단, 글번호(num) 기준 내림차순 정렬(DESC)
				//	  시작행 번호부터 페이지 당 게시물 목록 수 만큼만 조회
				//	 ( LIMIT 시작행번호, 페이지 당 게시물 목록 수)
				String sql = "SELECT * FROM archive WHERE name=? ORDER BY num DESC LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sId);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, listLimit);
				
				// 4단계. SQL 구문 실행 및 결과 처리
				rs = pstmt.executeQuery();
				
				// 전체 게시물 목록을 저장할 ArrayList 객체 생성
				myArchiveList = new ArrayList<ArchiveDTO>();  // BoardDTO 객체 저장 전용 ArrayList 객체 생성됨
				
				
				// 조회 결과가 있을 경우 레코드 접근 작업 반복
				while(rs.next()) {
					// 1개 레코드 저장할 BoardDTO 객체 생성 후 데이터 저장
					ArchiveDTO archive = new ArchiveDTO();
					
					archive.setNum(rs.getInt("num"));
					archive.setName(rs.getString("name"));
					archive.setPass(rs.getString("pass"));
					archive.setType(rs.getString("type"));
					archive.setSubject(rs.getString("subject"));
					archive.setContent(rs.getString("content"));
					archive.setOriginal_file(rs.getString("original_file"));
					archive.setReal_file(rs.getString("real_file"));
					archive.setReadcount(rs.getInt("readcount"));
					archive.setDate(rs.getTimestamp("date"));
							
					// 전체 레코드를 저장할 ArrayList<ArchiveDTO> 객체에 1개 레코드가 저장된 ArchiveDTO 객체 추가
					myArchiveList.add(archive);
					
					
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - selectMyArchiveList()");
				e.printStackTrace();
			} finally {
				
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
				
			}
			
			
			return myArchiveList;
		}
			
//-------------------------------------------------------------------------------------------------------------		
		// 나의 사진목록조회를 수행하는 selectMyArchiveList() 메서드 정의(검색기능추가)
		// 파라미터 : 아이디, 시작행번호, 페이지당 게시물 목록 수 ,키워드
		// 리턴타입 : ArrayList(myArchiveList)
	
	public ArrayList<ArchiveDTO> selectMyArchiveList(int startRow, int listLimit,String keyword,String sId){
		
		ArrayList<ArchiveDTO> myArchiveList = null; // ArrayList에서 사용할 데이터를 ArchiveDTO 타입으로 고정
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		 
		
		con = JdbcUtil.getConnection();
				
		try {
			// 3단계. SQL 구문 작성 및 전달
			// => board 테이블의 모든 레코드 조회(num 기준 내림차순 정렬, 10개로 제한)
			//	  단, 글번호(num) 기준 내림차순 정렬(DESC)
			//	  시작행 번호부터 페이지 당 게시물 목록 수 만큼만 조회
			//	 ( LIMIT 시작행번호, 페이지 당 게시물 목록 수)
			String sql = "SELECT * FROM archive WHERE name=? AND subject LIKE ? ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sId);
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, listLimit);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 게시물 목록을 저장할 ArrayList 객체 생성
			myArchiveList = new ArrayList<ArchiveDTO>();  // BoardDTO 객체 저장 전용 ArrayList 객체 생성됨
			
			
			// 조회 결과가 있을 경우 레코드 접근 작업 반복
			while(rs.next()) {
				// 1개 레코드 저장할 BoardDTO 객체 생성 후 데이터 저장
				ArchiveDTO archive = new ArchiveDTO();
				
				archive.setNum(rs.getInt("num"));
				archive.setName(rs.getString("name"));
				archive.setPass(rs.getString("pass"));
				archive.setType(rs.getString("type"));
				archive.setSubject(rs.getString("subject"));
				archive.setContent(rs.getString("content"));
				archive.setOriginal_file(rs.getString("original_file"));
				archive.setReal_file(rs.getString("real_file"));
				archive.setReadcount(rs.getInt("readcount"));
				archive.setDate(rs.getTimestamp("date"));
						
				// 전체 레코드를 저장할 ArrayList<ArchiveDTO> 객체에 1개 레코드가 저장된 ArchiveDTO 객체 추가
				myArchiveList.add(archive);
				
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectMyArchiveList()");
			e.printStackTrace();
		} finally {
			
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
		
		return myArchiveList;
	}
	
//-------------------------------------------------------------------------------------------------------------
//			"나의"전체 게시물 수 조회하는 selectMyArchiveListCount() 메서드 정의(검색기능 추가)
			// => 파라미터 : 검색어(keyword) 	리턴타입: int(MyArchiveListCount)
			public int MyArchiveListCount(String id,String select,String keyword) {
				int MyArchiveListCount = 0;
				
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				con = JdbcUtil.getConnection();
				
				try {
					// 게시물 목록 갯수 조회 => COUNT(*) 함수 사용
					// => 검색기능이 추가됐으므로 WHERE 절에 검색어 추가
					String sql = "SELECT COUNT(*) FROM archive WHERE name=? " + select + " LIKE ?";
					 
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, "%" + keyword + "%"); // 검색어를 포함하기 위해 %결합
					
					rs = pstmt.executeQuery();
					if(rs.next()) {
						MyArchiveListCount = rs.getInt(1);
					}
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류 발생! - selectBoardListCount()");
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				
				
				return MyArchiveListCount;
			}
//-------------------------------------------------------------------------------------------------------------
			// archive게시물 목록 조회를 수행하는 selectArchiveList() 메서드 정의
			// => 파라미터 : 시작 행번호, 페이지 당 게시물 목록 수   
			//    리턴타입 : ArrayList(boardList)
			public ArrayList<ArchiveDTO> selectArchiveList(int startRow, int listLimit) {
				
				// <>에 클래스이름을 넣으면 그 클래스 애만 넣을수있다. 
				// => 검사 할 필요가 없고, 나중에 꺼낼 때 변환 할 필요가 없다.
				
				// ArrayList 타입 사용 시 클래스명 뒤에 <> 기호를 쓰고, 기호 사이에 클래스타입을 지정하면
				// 해당 ArrayList 객체에서 사용되는 데이터는 모두 지정된 클래스 타입 데이터로만 사용된다!
				ArrayList<ArchiveDTO> archiveList = null; // ArrayList에서 사용할 데이터를 ArchiveDTO 타입으로 고정
				
				// DB 작업에 사용할 변수 선언
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				 
				// 1단계 & 2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
				// => static 메서드이므로 클래스명만으로 접근 가능함
				con = JdbcUtil.getConnection();
						
				try {
					// 3단계. SQL 구문 작성 및 전달
					// => board 테이블의 모든 레코드 조회(num 기준 내림차순 정렬, 10개로 제한)
					//	  단, 글번호(num) 기준 내림차순 정렬(DESC)
					//	  시작행 번호부터 페이지 당 게시물 목록 수 만큼만 조회
					//	 ( LIMIT 시작행번호, 페이지 당 게시물 목록 수)
					String sql = "SELECT * FROM archive WHERE name=? ORDER BY num DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, listLimit);
					
					// 4단계. SQL 구문 실행 및 결과 처리
					rs = pstmt.executeQuery();
					
					// 전체 게시물 목록을 저장할 ArrayList 객체 생성
					archiveList = new ArrayList<ArchiveDTO>();  // BoardDTO 객체 저장 전용 ArrayList 객체 생성됨
					
					
					// 조회 결과가 있을 경우 레코드 접근 작업 반복
					while(rs.next()) {
						// 1개 레코드 저장할 BoardDTO 객체 생성 후 데이터 저장
						ArchiveDTO archive = new ArchiveDTO();
						
						archive.setNum(rs.getInt("num"));
						archive.setName(rs.getString("name"));
						archive.setPass(rs.getString("pass"));
						archive.setSubject(rs.getString("subject"));
						archive.setContent(rs.getString("content"));
						archive.setReadcount(rs.getInt("readcount"));
						archive.setDate(rs.getTimestamp("date"));
								
						// 전체 레코드를 저장할 ArrayList<ArchiveDTO> 객체에 1개 레코드가 저장된 ArchiveDTO 객체 추가
						archiveList.add(archive);
						
						
					}
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류 발생! - selectArchiveList()");
					e.printStackTrace();
				} finally {
					// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
					
				}
				
				
				return archiveList;
			}
		
//-------------------------------------------------------------------------------------------------------------
			
			// archive 전체 게시물 수 조회하는 selectMyArchiveListCount() 메서드 정의
			// => 파라미터 : 세션아이디 	리턴타입: int(MyArchiveListCount)
			public int selectCommListCount() {
				int commListCount = 0;
				
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				con = JdbcUtil.getConnection();
				
				try {
					// 게시물 목록 갯수 조회 => COUNT(*) 함수 사용
					String sql = "SELECT COUNT(*) FROM archive";
					pstmt = con.prepareStatement(sql);
					
					rs = pstmt.executeQuery();
					if(rs.next()) {
						commListCount = rs.getInt(1);
					}
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류 발생! - selectArchiveListCount()");
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				
				
				return commListCount;
			}
//-----------------------------------------------------------------------------------			
			public int selectCommListCount(String type) {
				int commListCount = 0;
				
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				con = JdbcUtil.getConnection();
				
				try {
					// 게시물 목록 갯수 조회 => COUNT(*) 함수 사용
					String sql = "SELECT COUNT(*) FROM archive WHERE type=? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, type);
					
					rs = pstmt.executeQuery();
					if(rs.next()) {
						commListCount = rs.getInt(1);
					}
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류 발생! - selectArchiveListCount()");
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				
				
				return commListCount;
			}
//-------------------------------------------------------------------------------------------------------------		
			//	archive 전체 게시물 수 조회하는 selectMyArchiveListCount() 메서드 정의(검색기능 추가)
			// => 파라미터 : 검색어(keyword) 	리턴타입: int(MyArchiveListCount)
			public int selectCommListCount(String keyword,String select) {
				int commListCount = 0;
				
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				con = JdbcUtil.getConnection();
				
				try {
					
					String sql = "SELECT COUNT(*) FROM archive WHERE " + select + " LIKE ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%"); 
					
					rs = pstmt.executeQuery();
					if(rs.next()) {
						commListCount = rs.getInt(1);
					}
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류 발생! - selectArchiveListCount()");
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				
				
				return commListCount;
			}
	//-------------------------------------------------------------------------------------------------------------		
			// 나의 사진 목록 조회해서 게시판에 표시해주는 메소드 
			// 나의 게시물 중 선택한 나의 글 내용 표시,내용을 찾아서 출력해주는 메서드
			public ArchiveDTO selectMyArchiveBoard(String id,int num) {
				
				ArchiveDTO archive = null;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					// 1,2단계
					con = JdbcUtil.getConnection();
					
					
					String sql = "SELECT * FROM archive WHERE name=? AND num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setInt(2, num);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						
						archive = new ArchiveDTO();
						archive.setNum(num);
						archive.setName(rs.getString("name"));
						archive.setPass(rs.getString("pass"));
						archive.setSubject(rs.getString("subject"));
						archive.setContent(rs.getString("content"));
						archive.setType(rs.getString("type"));
						archive.setOriginal_file(rs.getString("original_file"));
						archive.setReal_file(rs.getString("real_file"));
						archive.setReadcount(rs.getInt("readcount"));
						archive.setDate(rs.getTimestamp("date"));
						
					}
					
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류! - selectMyArchiveBoard() ");
					e.printStackTrace();
				} finally {
					
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
					
				}
				
				return archive;
			}
			
			// 게시물 중 선택한 글 내용 표시,내용을 찾아서 출력해주는 메서드
			public ArchiveDTO selectCommBoard(int num){
				
				ArchiveDTO archive = null;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					// 1,2단계
					con = JdbcUtil.getConnection();
					
					
					String sql = "SELECT * FROM archive WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						
						archive = new ArchiveDTO();
						archive.setNum(num);
						archive.setName(rs.getString("name"));
						archive.setPass(rs.getString("pass"));
						archive.setSubject(rs.getString("subject"));
						archive.setContent(rs.getString("content"));
						archive.setType(rs.getString("type"));
						archive.setOriginal_file(rs.getString("original_file"));
						archive.setReal_file(rs.getString("real_file"));
						archive.setReadcount(rs.getInt("readcount"));
						archive.setDate(rs.getTimestamp("date"));
						
					}
					
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류! - selectMyArchiveBoard() ");
					e.printStackTrace();
				} finally {
					
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
					
				}
				
				return archive;
			
				
			}
			
			
			
//-----------------------------------------------------------------------
				// 글 수정 작업 수행을 위한 updateMyArchiveBoard()
				// => 파라미터 : ArchiveDTO객체 (archive)    리턴타입 : int(updateCount)
				public int updateMyArchiveBoard(ArchiveDTO archive) {
					int updateCount = 0;
					
					Connection con = null;
					PreparedStatement pstmt = null;
					
					try {
						// 1단계 & 2단계
						con = JdbcUtil.getConnection();
						
						// 글번호와 패스워드가 일치하는 레코드 삭제
						String sql = "UPDATE archive " +
										"SET subject=?,content=?,original_file=?,real_file=?" +
										"WHERE num=? AND pass=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, archive.getSubject());
						pstmt.setString(2, archive.getContent());
						pstmt.setString(3, archive.getOriginal_file());
						pstmt.setString(4, archive.getReal_file());
						pstmt.setInt(5, archive.getNum());
						pstmt.setString(6, archive.getPass());
						
						updateCount = pstmt.executeUpdate();
					} catch (SQLException e) {
						System.out.println("SQL 구문 오류 발생! - updateFileBoard()");
						e.printStackTrace();
					} finally {
						// DB 자원 반환
						JdbcUtil.close(pstmt);
						JdbcUtil.close(con);
					}
					
					return updateCount;
				}

	//-----------------------------------------------------------------------
	//-------****************************이거수정해야됨**********************
	// 글 삭제 작업 전 업로드 된 파일명 조회 작업 수행하는 메서드 정의
			public String  selectRealFilm(int num) {
				
				String realFile = null;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					// 1,2단계
					con = JdbcUtil.getConnection();
					
					
					String sql = "SELECT real_file FROM archive WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						
						
						realFile = rs.getString("real_file");
						
						
					}
					
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류! - selectRealFilm() ");
					e.printStackTrace();
				} finally {
					
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
					
				}
				
				return realFile;
			}
	
//-----------------------------------------------------------------------
			// 글삭제 메소드
			public int deleteFilmArchive(int num,String pass){
				
				int deleteCount = 0;
				Connection con = null;
				PreparedStatement pstmt = null;
				
				con = JdbcUtil.getConnection();
				
				try {
					String sql="DELETE FROM archive WHERE num=? AND pass=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, pass);
				
					deleteCount = pstmt.executeUpdate();
					
				} catch (SQLException e){
					System.out.println("SQL 구문 오류 발생! - deleteFilmArchive()");
					e.printStackTrace();
				} finally {
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
					
				}
				
				return deleteCount;
				
			}
			
			
//-----------------------------------------------------------------------		
			// 조회수가 가장 높은 게시물 3개 목록 조회
			// 파라미터 : 없음    리턴타입 : ArrayList<ArchiveDTO> (archiveTopList)
			
			public ArrayList<ArchiveDTO> selectTopHitsList(){
				
				ArrayList<ArchiveDTO> archiveTopList = null;
				
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				
				con = JdbcUtil.getConnection();
				
				
				
				try {
					String sql = "SELECT * FROM archive ORDER BY readcount DESC LIMIT 3";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					
					archiveTopList = new ArrayList<ArchiveDTO>();
					
					while(rs.next()) {
						ArchiveDTO archive = new ArchiveDTO();
						
						archive.setNum(rs.getInt("num"));
						archive.setName(rs.getString("name"));
						archive.setPass(rs.getString("pass"));
						archive.setType(rs.getString("type"));
						archive.setSubject(rs.getString("subject"));
						archive.setContent(rs.getString("content"));
						archive.setOriginal_file(rs.getString("original_file"));
						archive.setReal_file(rs.getString("real_file"));
						archive.setReadcount(rs.getInt("readcount"));
						archive.setDate(rs.getTimestamp("date"));
						
						archiveTopList.add(archive);
					}
						
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류 발생! - selectTopHitsList()");
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				
				
				return archiveTopList;
			}
//-----------------------------------------------------------------------				
		// 최근 게시물 3개 목록 조회하는 selectRecentList() 메서드 정의
		// => 파라미터 : 없음    리턴타입 : ArrayList<ArchiveDTO>(archiveRecentList)
			public ArrayList<ArchiveDTO> selectRecentList() {
			ArrayList<ArchiveDTO> archiveRecentList = null; // ArrayList 에서 사용할 데이터를 BoardDTO 타입으로 고정
				
				// DB 작업에 사용할 변수 선언
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				con = JdbcUtil.getConnection();
				
				try {
					String sql = "SELECT * FROM archive ORDER BY num DESC LIMIT 3";
					pstmt = con.prepareStatement(sql);
					
					// 4단계. SQL 구문 실행 및 결과 처리
					rs = pstmt.executeQuery();
					
					// 전체 게시물 목록을 저장할 ArrayList 객체 생성
					archiveRecentList = new ArrayList<ArchiveDTO>(); // BoardDTO 객체 저장 전용 ArrayList 객체 생성됨
					
					// 조회 결과가 있을 경우 레코드 접근 반복
					while(rs.next()) {
						ArchiveDTO archive = new ArchiveDTO();
						
						archive.setNum(rs.getInt("num"));
						archive.setName(rs.getString("name"));
						archive.setPass(rs.getString("pass"));
						archive.setType(rs.getString("type"));
						archive.setSubject(rs.getString("subject"));
						archive.setContent(rs.getString("content"));
						archive.setOriginal_file(rs.getString("original_file"));
						archive.setReal_file(rs.getString("real_file"));
						archive.setReadcount(rs.getInt("readcount"));
						archive.setDate(rs.getTimestamp("date"));
						
						archiveRecentList.add(archive);
					}
					
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류 발생! - selectBoardList()");
					e.printStackTrace();
				} finally {
					
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				
				return archiveRecentList;
			}
			
			
}
