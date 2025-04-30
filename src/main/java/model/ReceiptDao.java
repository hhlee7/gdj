package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Receipt;

public class ReceiptDao {
	public void insertReceipt(Receipt receipt) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "insert into receipt (cash_no, filename) values (?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, receipt.getCashNo());
		stmt.setString(2, receipt.getFilename());
		int result = stmt.executeUpdate();
		if(result == 1) {
			System.out.println("insert 성공");
		} else {
			System.out.println("insert 실패");
		}
		conn.close();
	}
	
	public ArrayList<Receipt> selectImageList(int cashNo) throws ClassNotFoundException, SQLException {
		ArrayList<Receipt> list = new ArrayList<Receipt>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "select cash_no cashNo, filename, createdate from receipt where cash_no = ? order by cash_no";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Receipt receipt = new Receipt();
			receipt.setCashNo(rs.getInt("cashNo"));
			receipt.setFilename(rs.getString("filename"));
			receipt.setCreatedate(rs.getString("createdate"));
			list.add(receipt);
		}
		conn.close();
		return list;
	}
	
	public void deleteReceipt(int cashNo, String filename) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "delete from receipt where cash_no = ? and filename = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		stmt.setString(2, filename);
		int result = stmt.executeUpdate();
		if(result == 1) {
			System.out.println("delete 완료");
		} else {
			System.out.println("delete 실패");
		}
		conn.close();
	}
}
