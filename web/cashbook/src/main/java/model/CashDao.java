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
			String sql = "SELECT ct.kind kind, ct.title title, cs.cash_no cashNo"
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
				cash.setCashNo(rs.getInt("cashNo"));
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
		
		// 해당 cashNo를 가지는 데이터 행 조회
		public Cash selectCashOne(int cashNo) throws Exception {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			String sql = "SELECT ct.kind kind, ct.title title, cs.cash_no cashNo"
						+ ", cs.cash_date cashDate, cs.amount amount, cs.memo memo, cs.color color, cs.createdate, cs.updatedate"
	    				+ " FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no"
	    				+ " WHERE cs.cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			// 완성된 쿼리 확인용 출력
			System.out.println("CashDao #selectCashOne: " + stmt);
			rs = stmt.executeQuery();
			Cash cash = null;
			if(rs.next()) {
				cash = new Cash();
		        cash.setKind(rs.getString("kind"));
		        cash.setTitle(rs.getString("title"));
		        cash.setCashNo(rs.getInt("cashNo"));
		        cash.setCashDate(rs.getString("cashDate"));
		        cash.setAmount(rs.getInt("amount"));
		        cash.setMemo(rs.getString("memo"));
		        cash.setColor(rs.getString("color"));
		        cash.setCreatedate(rs.getString("createdate"));
		        cash.setUpdatedate(rs.getString("updatedate"));
			}
			conn.close();
		    return cash;
		}
		
		// 해당 cashNo를 가지는 데이터 행 삭제
		public void deleteCash(int cashNo) throws Exception {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			String sql = "DELETE FROM cash WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			// 완성된 쿼리 확인용 출력
			System.out.println("CashDao #deleteCash: " + stmt);
			int result = stmt.executeUpdate();
			if(result == 1) {
				System.out.println("delete 성공");
			} else {
				System.out.println("delete 실패");
			}
			conn.close();
		}
		
		// 새로운 데이터 값을 받아 cash 테이블에 insert
		public void insertCash(int categoryNo, String cashDate, int amount, String memo, String color) throws Exception {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			String sql = "INSERT INTO cash(category_no, cash_date, amount, memo, color) VALUES(?, ?, ?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			stmt.setString(2, cashDate);
			stmt.setInt(3, amount);
			stmt.setString(4, memo);
			stmt.setString(5, color);
			// 완성된 쿼리 확인용 출력
			System.out.println("CashDao #insertCash: " + stmt);
			int result = stmt.executeUpdate();
			if(result == 1) {
				System.out.println("insert 성공");
			} else {
				System.out.println("insert 실패");
			}
			conn.close();
		}
		
		// 해당 cashNo을 가지는 데이터의 값 수정
		public void updateCash(int cashNo, String cashDate, int amount, String memo, String color) throws Exception {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			String sql = "UPDATE cash SET cash_date = ?, amount = ?, memo = ?, color = ? WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cashDate);
			stmt.setInt(2, amount);
			stmt.setString(3, memo);
			stmt.setString(4, color);
			stmt.setInt(5, cashNo);
			// 완성된 쿼리 확인용 출력
			System.out.println("CashDao #updateCash: " + stmt);
			int result = stmt.executeUpdate();
			if(result == 1) {
				System.out.println("update 성공");
			} else {
				System.out.println("update 실패");
			}
			conn.close();
		}
}