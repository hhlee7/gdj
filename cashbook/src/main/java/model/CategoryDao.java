package model;

import java.sql.*;
import java.util.*;

import dto.*;

public class CategoryDao {
	// 카테고리 리스트를 조회하는 메서드
	public ArrayList<Category> selectCategoryList(Paging p) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "select category_no categoryNo, kind, title, createdate from category limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		System.out.println("CategoryDao #selectCategoryList: " + stmt);
		rs = stmt.executeQuery();
		ArrayList<Category> list = new ArrayList<Category>();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		conn.close();
		return list;
	}
	
	// 카테고리 리스트의 전체 행 수를 구하는 메서드
	public int getTotalCategory() throws ClassNotFoundException, SQLException {
		int cnt = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "select count(*) cnt from category";
		stmt = conn.prepareStatement(sql);
		System.out.println("CategoryDao #getTotalCategory: " + stmt);
		rs = stmt.executeQuery();
		rs.next();
		cnt = rs.getInt("cnt");
		conn.close();
		return cnt;
	}
	
	// 해당 categoryNo값을 가지는 데이터 행 조회
	public Category selectCategory(int num) throws ClassNotFoundException, SQLException {
		Category c = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "select category_no categoryNo, kind, title, createdate from category where category_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		System.out.println("CategoryDao #selectCategory: " + stmt);
		rs = stmt.executeQuery();
		while(rs.next()) {
			c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
			c.setCreatedate(rs.getString("createdate"));
		}
		conn.close();
		return c;
	}
	
	// 카테고리 추가 메서드
	public void insertCategory(String kind, String title) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "insert into category (kind, title) values (?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, kind);
		stmt.setString(2, title);
		System.out.println("CategoryDao #insertCategory: " + stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("insert 성공");
		} else {
			System.out.println("insert 실패");
		}
		conn.close();
	}
	
	// 해당 카테고리 번호의 데이터 값을 수정하는 메서드
	public void updateCategory(String kind, String title, int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "update category set kind = ?, title = ? where category_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, kind);
		stmt.setString(2, title);
		stmt.setInt(3, num);
		System.out.println("CategoryDao #updateCategory: " + stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("update 완료");
		} else {
			System.out.println("update 실패");
		}
		conn.close();
	}
}
