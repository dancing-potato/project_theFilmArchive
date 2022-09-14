package board;

import java.sql.Timestamp;

public class ReportDTO {

	
	/*
	  
	 신고글(report)테이블 생성
	 ----------------------
	 신고작성 글번호(num) - 정수 PK AI
	 신고원본글게시판타입(boardType) - 문자 15자 NN
	 신고원본게시물번호(refNum) - 정수 FK NN (임시로 FK 생략)
	 신고원본글작성자(postName) - 문자 20자 NN
	 신고원본글제목(postSubject) - 문자 50자 NN 
	 신고사유(reportReason) - 문자 100자 NN
	 신고자(reporter) 문자 20자 NN
	 신고일시(reportDate) - TIMESTAMP NN
	 처리상태(processing) 문자 20자 NN DEFAULT 'processing'
	 ------------------------------
	 
	 CREATE TABLE report (
	 	num INT PRIMARY KEY AUTO_INCREMENT,
	 	boardType VARCHAR(15) NOT NULL,
	 	refNum INT NOT NULL,
	 	postName VARCHAR(20) NOT NULL,
	 	postSubject VARCHAR(50) NOT NULL,
	 	reportReason VARCHAR(100) NOT NULL,
	 	reporter VARCHAR(20) NOT NULL,
	 	reportDate TIMESTAMP NOT NULL,
	 	processing VARCHAR(20) NOT NULL DEFAULT 'processing'
	 );
	 
	 
	 */
	
	private int num;				// 신고글 글번호
	private String boardType;		// 신고당한글 게시판이름(타입)
	private int refNum;				// 신고당한글 글번호
	private String postName;		// 신고당한글 작성자
	private String postSubject;		// 신고당한글 글제목
	private String reportReason;	// 신고이유
	private String reporter;		// 신고자
	private Timestamp reportDate;			// 신고글 작성일
	private String processing;      // 신고글 처리상태 
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public int getRefNum() {
		return refNum;
	}
	public void setRefNum(int refNum) {
		this.refNum = refNum;
	}
	public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	}
	public String getPostSubject() {
		return postSubject;
	}
	public void setPostSubject(String postSubject) {
		this.postSubject = postSubject;
	}
	public String getReportReason() {
		return reportReason;
	}
	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	
	public Timestamp getReportDate() {
		return reportDate;
	}
	public void setReportDate(Timestamp reportDate) {
		this.reportDate = reportDate;
	}

	
	public String getProcessing() {
		return processing;
	}
	public void setProcessing(String processing) {
		this.processing = processing;
	}
	
	
	
}
