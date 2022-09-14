package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.JdbcUtil;

public class ReportDAO {

	// 신고글 신고(report)테이블에 글입력해주는 기능 
	public int reportPostInsert(ReportDTO report){
		
		int insertReportResult = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "INSERT INTO report VALUES(null,?,?,?,?,?,?,now(),'처리중')";

			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, report.getBoardType());
			pstmt.setInt(2, report.getRefNum());
			pstmt.setString(3, report.getPostName());
			pstmt.setString(4, report.getPostSubject());
			pstmt.setString(5, report.getReportReason());
			pstmt.setString(6, report.getReporter());
			
			
			insertReportResult = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - reportPostInsert()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return insertReportResult;
	}
	
	
	// 관리자 신고글목록 페이지에 신고처리글 목록 뿌려주는 기능 
	public ArrayList<ReportDTO> selectReportList() {
		ArrayList<ReportDTO> reportList = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM report WHERE processing='처리중' ORDER BY num DESC";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			reportList = new ArrayList<ReportDTO>();
			
			while(rs.next()) {
				ReportDTO report = new ReportDTO();
				
				report.setNum(rs.getInt("num"));
				report.setBoardType(rs.getString("boardType"));
				report.setRefNum(rs.getInt("refNum"));
				report.setPostName(rs.getString("postName"));
				report.setPostSubject(rs.getString("postSubject"));
				report.setReportReason(rs.getString("reportReason"));
				report.setReporter(rs.getString("reporter"));
				report.setReportDate(rs.getTimestamp("reportDate"));
				report.setProcessing(rs.getString("processing"));
				
				reportList.add(report);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectReportList()");
			e.printStackTrace();
			
		} finally {
			
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return reportList;
	}
	
	// 관리자 신고글목록 페이지에 신고처리완료글 목록 뿌려주는 기능 
	public ArrayList<ReportDTO> selectReportCompleteList() {
		ArrayList<ReportDTO> reportList = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM report WHERE processing NOT IN('처리중') ORDER BY num DESC";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			reportList = new ArrayList<ReportDTO>();
			
			while(rs.next()) {
				ReportDTO report = new ReportDTO();
				
				report.setNum(rs.getInt("num"));
				report.setBoardType(rs.getString("boardType"));
				report.setRefNum(rs.getInt("refNum"));
				report.setPostName(rs.getString("postName"));
				report.setPostSubject(rs.getString("postSubject"));
				report.setReportReason(rs.getString("reportReason"));
				report.setReporter(rs.getString("reporter"));
				report.setReportDate(rs.getTimestamp("reportDate"));
				report.setProcessing(rs.getString("processing"));
				
				reportList.add(report);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectReportCompleteList()");
			e.printStackTrace();
			
		} finally {
			
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return reportList;
	}
	
	
	// 관리자 신고글목록에서 신고글처리상태 변경해주는 기능
	public int updateProcessing(int num,String processing) {
		int updateProcessingCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "UPDATE report SET processing='"+ processing + "' WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			updateProcessingCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			System.out.println("SQL 구문 오류 발생! - updateProcessing()");
			e.printStackTrace();
			
		} finally {
			
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		
		
		return updateProcessingCount;
	}
	
	
}
