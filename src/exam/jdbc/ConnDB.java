package exam.jdbc;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnDB {
	public static Connection Dbcon() throws ClassNotFoundException, SQLException {
		DataSource dataSource;
		Connection conn = null;
		
		try{
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc_mariadb");
			conn = dataSource.getConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return conn;
	}
}
