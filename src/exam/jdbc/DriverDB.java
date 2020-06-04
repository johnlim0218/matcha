package exam.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DriverDB {
	public static Connection driverDbcon() throws ClassNotFoundException, SQLException {
		Class.forName("org.mariadb.jdbc.Driver");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/matcha";
		String dbUser = "root";
		String dbPass = "1234";
		
		Connection re_conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		return re_conn;
		
	}
}
