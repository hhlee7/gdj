package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Cash;

public class CashDao {
/*
	// 년.월 별 해당하는 cash list를 조회
	public HashMap<String, ArrayList<Cash>> selectMonthList(int year, int month) throws Exception {
		HashMap<String, ArrayList<Cash>> map = new HashMap<String, ArrayList<Cash>>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "SELECT ct.kind kind, ct.title title"
					+ ", cs.cash_date cashDate, cs.amount amount, cs.memo memo, cs.color color"
					+ " FROM category ct INNER JOIN cash cs"
					+ " ON ct.category_no = cs.category_no"
					+ " where YEAR(cash_date) = ? and MONTH(cash_date) = ? order by cash_date";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		// 완성된 쿼리 확인용 출력
		System.out.println("CashDao #selectMonthList: " + stmt);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Cash cash = new Cash();
			cash.setKind(rs.getString("kind"));
			cash.setTitle(rs.getString("title"));
			cash.setCashDate(rs.getString("cashDate"));
			cash.setAmount(rs.getInt("amount"));
			cash.setMemo(rs.getString("memo"));
			cash.setColor(rs.getString("color"));
			
		}
	}
*/
	
	// 년.월 별 해당하는 cash list를 조회
		public ArrayList<Cash> selectMonthList(int year, int month) throws Exception {
			ArrayList<Cash> list = new ArrayList<Cash>();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			String sql = "SELECT ct.kind kind, ct.title title"
						+ ", cs.cash_date cashDate, cs.amount amount, cs.memo memo, cs.color color"
						+ " FROM category ct INNER JOIN cash cs"
						+ " ON ct.category_no = cs.category_no"
						+ " where YEAR(cash_date) = ? and MONTH(cash_date) = ? order by cash_date";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, year);
			stmt.setInt(2, month);
			// 완성된 쿼리 확인용 출력
			System.out.println("CashDao #selectMonthList: " + stmt);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Cash cash = new Cash();
				cash.setKind(rs.getString("kind"));
				cash.setTitle(rs.getString("title"));
				cash.setCashDate(rs.getString("cashDate"));
				cash.setAmount(rs.getInt("amount"));
				cash.setMemo(rs.getString("memo"));
				cash.setColor(rs.getString("color"));
				list.add(cash);
			}
			conn.close();
			return list;
		}
}
