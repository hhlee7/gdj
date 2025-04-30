package model;

import java.sql.*;


public class AdminDao {
	// 로그인 확인 메서드
	public int loginCheck(String id, String pw) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "select admin_id, admin_pw from admin where admin_id = ? and admin_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		// 완성된 쿼리 확인용 출력
		System.out.println("AdminDao #loginCheck " + stmt);
		rs = stmt.executeQuery();
		int result = 0;
		if(rs.next()) {
			result = 1;
			System.out.println("로그인 성공");
		} else {
			System.out.println("로그인 실패");
		}
		conn.close();
		return result;
	}
	
	// 현재 접속된 사용자의 비밀번호 변경 메서드
	public int updateAdminPw(String newPw, String id, String pw) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "update admin set admin_pw = ? where admin_id = ? and admin_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, id);
		stmt.setString(3, pw);
		// 완성된 쿼리 확인용 출력
		System.out.println("AdminDao #updateAdminPw " + stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("비밀번호 변경 성공");
		} else {
			System.out.println("비밀번호 변경 실패");
		}
		conn.close();
		return row;
	}
}
