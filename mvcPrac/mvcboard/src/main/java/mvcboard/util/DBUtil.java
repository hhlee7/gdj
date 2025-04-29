package mvcboard.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://127.0.0.1:3306/mvcboard";
        String dbUser = "root";
        String dbPw = "java1234";
        Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
        return connection;
	}
}
