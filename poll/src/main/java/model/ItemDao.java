package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Item;
import dto.Paging;

// Table : item CRUD
public class ItemDao {
	// item 테이블 데이터를 조회 - select
	public ArrayList<Item> selectItemList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Item> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select qnum, inum, content, count from item";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		System.out.println(stmt);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Item i = new Item();
			i.setQnum(rs.getInt("qnum"));
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			i.setCount(rs.getInt("count"));
			list.add(i);
		}
		conn.close();
		return list;
	}
	
	// item 테이블 데이터를 조회 - select
		public ArrayList<Item> selectItemList(int num) throws ClassNotFoundException, SQLException {
			ArrayList<Item> list = new ArrayList<>();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "select qnum, inum, content, count from item where qnum = ?";
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			System.out.println(stmt);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Item i = new Item();
				i.setQnum(rs.getInt("qnum"));
				i.setInum(rs.getInt("inum"));
				i.setContent(rs.getString("content"));
				i.setCount(rs.getInt("count"));
				list.add(i);
			}
			conn.close();
			return list;
		}
	
	// item 테이블에서 해당 num 값이 속한 행 데이터만 조회
	public Item selectItem(int num) throws ClassNotFoundException, SQLException {
		Item i = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select qnum, inum, content, count from item where qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		System.out.println(stmt);
		rs = stmt.executeQuery();
		while(rs.next()) {
			i = new Item();
			i.setQnum(rs.getInt("qnum"));
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			i.setCount(rs.getInt("count"));
		}
		conn.close();
		return i;
	}
	
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into item (qnum, inum, content) values (?, ?, ?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.insertItem - 입력 성공");
		} else {
			System.out.println("ItemDao.insertItem - 입력 실패");
		}
		conn.close();
	}
	
	// item 테이블에서 해당하는 데이터를 삭제 - delete
	public void deleteItem(int qnum) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from item where qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		System.out.println(stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("삭제 완료");
		} else {
			System.out.println("삭제 실패");
		}
		conn.close();
	}
}
