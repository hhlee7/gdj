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
	// 해당 월(년.월 일치)에 속하는 cash 목록을 조회
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
		
		// 해당 일자(년.월.일 일치)에 속하는 cash 목록을 조회
		public ArrayList<Cash> selectDateList(int year, int month, int day) throws Exception {
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
					+ " where YEAR(cash_date) = ? and MONTH(cash_date) = ? and day(cash_date) = ? order by cash_date";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, year);
			stmt.setInt(2, month);
			stmt.setInt(3, day);
			// 완성된 쿼리 확인용 출력
			System.out.println("CashDao #selectDateList: " + stmt);
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
		
		// 해당 일자(년.월.일 일치)에 속하는 cash 목록의 항목별 금액의 합 구하기
		public ArrayList<HashMap<String, Object>> selectDailyAmountByKind(int year, int month, int day) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			String sql = "SELECT kind, SUM(amount) sumAmount"
						+ " FROM category ct INNER JOIN cash cs"
						+ " ON ct.category_no = cs.category_no"
						+ " WHERE YEAR(cash_date) = ? AND month(cash_date) = ? AND DAY(cash_date) = ?"
						+ " GROUP BY day(cash_date), ct.kind"
						+ " ORDER BY day(cash_date);";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, year);
			stmt.setInt(2, month);
			stmt.setInt(3, day);
			// 완성된 쿼리 확인용 출력
			System.out.println("CashDao #selectDailyAmountByKind: " + stmt);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("kind", rs.getString("kind"));
				map.put("sumAmount", rs.getInt("sumAmount"));
				list.add(map);
			}
			conn.close();
			return list;
		}
}
