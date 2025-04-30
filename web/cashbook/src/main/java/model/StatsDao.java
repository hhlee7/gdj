package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.Stats;

public class StatsDao {
	// 전체 수입/지출 통계 데이터 값 조회
	public ArrayList<Stats> selectStatsByTotal() throws Exception {
		ArrayList<Stats> list = new ArrayList<Stats>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "SELECT kind, COUNT(*) count, SUM(amount) amount"
					+ " FROM category ct INNER JOIN cash cs"
					+ " ON ct.category_no = cs.category_no"
					+ " GROUP BY ct.kind";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Stats stats = new Stats();
			stats.setKind(rs.getString("kind"));
			stats.setCount(rs.getInt("count"));
			stats.setAmount(rs.getInt("amount"));
			list.add(stats);
		}
		conn.close();
		return list;
	}
	
	// 연도별 수입/지출 통계 데이터 값 조회
	public ArrayList<Stats> selectStatsByYearAndKind(String kind) throws Exception {
		ArrayList<Stats> list = new ArrayList<Stats>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "SELECT year(cash_date) cashDate, kind, COUNT(*) count, SUM(amount) amount"
					+ " FROM category ct INNER JOIN cash cs"
					+ " ON ct.category_no = cs.category_no"
					+ " WHERE kind = ?"
					+ " GROUP BY YEAR(cash_date), ct.kind"
					+ " ORDER BY YEAR(cash_date)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, kind);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Stats stats = new Stats();
			stats.setCashDate(rs.getString("cashDate"));
			stats.setKind(rs.getString("kind"));
			stats.setCount(rs.getInt("count"));
			stats.setAmount(rs.getInt("amount"));
			list.add(stats);
		}
		conn.close();
		return list;
	}
	
	// 해당 연도의 월별 수입/지출 통계 데이터 값 조회
	public ArrayList<Stats> selectStatsByMonthAndYearAndKind(String year, String kind) throws Exception {
		ArrayList<Stats> list = new ArrayList<Stats>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "SELECT month(cash_date) cashDate, kind, COUNT(*) count, SUM(amount) amount"
					+ " FROM category ct INNER JOIN cash cs"
					+ " ON ct.category_no = cs.category_no"
					+ " WHERE YEAR(cash_date) = ? AND kind = ?"
					+ " GROUP BY month(cash_date), ct.kind"
					+ " ORDER BY month(cash_date)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, year);
		stmt.setString(2, kind);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Stats stats = new Stats();
			stats.setCashDate(rs.getString("cashDate"));
			stats.setKind(rs.getString("kind"));
			stats.setCount(rs.getInt("count"));
			stats.setAmount(rs.getInt("amount"));
			list.add(stats);
		}
		conn.close();
		return list;
	}
}