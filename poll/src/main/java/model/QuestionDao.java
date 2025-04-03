package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Paging;
import dto.Question;

// Table : question CRUD
public class QuestionDao {
	// question 테이블 데이터를 조회 - select
	public ArrayList<Question> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Question> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select num, title, startdate, enddate, createdate, type from question limit ?, ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		System.out.println(stmt);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Question q = new Question();
			q.setNum(rs.getInt("num"));
			q.setTitle(rs.getString("title"));
			q.setStartdate(rs.getString("startdate"));
			q.setEnddate(rs.getString("enddate"));
			q.setCreatedate(rs.getString("createdate"));
			q.setType(rs.getInt("type"));
			list.add(q);
		}
		conn.close();
		return list;
	}
	
	// question 테이블에서 해당 num 값이 속한 행 데이터만 조회
	public Question selectQuestion(int qnum) throws ClassNotFoundException, SQLException {
		Question q = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select num, title, startdate, enddate, createdate, type from question where num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		System.out.println(stmt);
		rs = stmt.executeQuery();
		while(rs.next()) {
			q = new Question();
			q.setNum(rs.getInt("num"));
			q.setTitle(rs.getString("title"));
			q.setStartdate(rs.getString("startdate"));
			q.setEnddate(rs.getString("enddate"));
			q.setCreatedate(rs.getString("createdate"));
			q.setType(rs.getInt("type"));
		}
		conn.close();
		return q;
	}
	
	// 입력 후 자동으로 생성된 키 값을 반환받기 위해 반환타입 int로 설정
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		// 입력이지만 키 값을 받아올 때 사용
		ResultSet rs = null;
		String sql = "insert into question (title, startdate, enddate, type) values (?, ?, ?, ?)";
		// Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 select max(pk) from ... 실행
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		int row = stmt.executeUpdate(); // insert
		rs = stmt.getGeneratedKeys(); // select max(num) from question
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		conn.close();
		return pk;
		}
	
	// question 테이블에서 해당하는 데이터를 삭제 - delete
	public void deleteQuestion(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from question where num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		System.out.println(stmt);
		int row = stmt.executeUpdate(); // delete
		if(row == 1) {
			System.out.println("삭제 완료");
		} else {
			System.out.println("삭제 실패");
		}
		conn.close();
	}
	
	// 해당하는 데이터의 투표자 수를 반환하는 메서드
	public int checkVoter(int num) throws ClassNotFoundException, SQLException {
		int sumCnt = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT qnum, SUM(COUNT) sumCnt FROM item GROUP BY qnum HAVING qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		System.out.println(stmt);
		rs = stmt.executeQuery();
		if(rs.next()) {
			sumCnt = rs.getInt("sumCnt");
		}
		conn.close();
		return sumCnt;
	}
	
	// question 테이블의 전체 행 수를 구하는 메서드
	public int getTotalQuestion() throws ClassNotFoundException, SQLException {
		int cnt = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) cnt from question";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		System.out.println(stmt);
		rs = stmt.executeQuery();
		rs.next();
		cnt = rs.getInt("cnt");
		conn.close();
		return cnt;
	}
	
	// question 테이블 데이터를 수정 - update
	public void updateQuestion(int num, String title, int type) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update question set title = ?, type = ? where num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setInt(2, type);
		stmt.setInt(3, num);
		System.out.println(stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("수정 완료");
		} else {
			System.out.println("수정 실패");
		}
		conn.close();
	}
	
	// question 테이블에서 해당 num 값이 속한 enddate 값 수정
	public void updateQuestionEnddate(int num, String enddate) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update question set enddate = ? where num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, enddate);
		stmt.setInt(2, num);
		System.out.println(stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("수정 완료");
		} else {
			System.out.println("수정 실패");
		}
		conn.close();
	}
}
