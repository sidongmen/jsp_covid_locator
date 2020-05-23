package covidLocator.model;

import java.sql.*;
import java.util.*;

public class CovidBean {

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://127.0.0.1:3306/covidb";
	
	void connect() {
	  try {
		  Class.forName(jdbc_driver);
		  conn = DriverManager.getConnection(jdbc_url,"root","my123123");
	  }catch(Exception e) {
		  e.printStackTrace();
	  }
	}
	
	void disconnect() {
		if(pstmt != null)
			try {
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public CovidUser getUser() {
		connect();
		String sql = "select * from users where id = 1";
		CovidUser coviduser = new CovidUser();
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			coviduser.setUser_id(rs.getInt("id"));
			coviduser.setUser_nickname(rs.getString("nickname"));
			coviduser.setUser_email(rs.getString("email"));
			coviduser.setUser_password(rs.getString("password"));
			coviduser.setUser_role(rs.getInt("role"));
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return coviduser;
	}
	
	public ArrayList<CovidArea> getArea(){
		connect();
		String sql = "select * from areas";
		ArrayList<CovidArea> areas = new ArrayList<CovidArea>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CovidArea covidArea = new CovidArea();
			    covidArea.setArea_id(rs.getInt("id"));
			    covidArea.setArea_name(rs.getString("name"));
			    covidArea.setArea_x(rs.getDouble("x"));
			    covidArea.setArea_y(rs.getDouble("y"));
				areas.add(covidArea);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return areas;	
	}
}
