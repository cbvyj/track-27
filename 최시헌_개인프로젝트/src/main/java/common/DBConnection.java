package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {
	
	//DB 접속
	
	public static Connection getConnection(){
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String db_url = "jdbc:oracle:thin:@jsl-704:1523/xe";
		String db_user = "track27_11g";
		String db_passward = "1234";
		
		try {
			con = DriverManager.getConnection(db_url, db_user, db_passward);
		} catch (SQLException e) {
			System.out.println("DB 접속 오류~~~");
			e.printStackTrace();
		}
		return con;
	}
	
	// DB 연결 종료
	
	public static void closeDB(Connection con, PreparedStatement ps, ResultSet rs) {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(ps != null) {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	
	
}
