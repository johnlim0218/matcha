package exam.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBcon {
	public Connection DBcdriver() throws ClassNotFoundException, SQLException{

		Class.forName("org.mariadb.jdbc.Driver");

		String jdbcDriver = "jdbc:mariadb://localhost:3306/website";

		String dbuser = "root";

		String dbpass = "1234";

		Connection conn = DriverManager.getConnection(jdbcDriver,dbuser,dbpass);
		
		return conn;

	} 
}
