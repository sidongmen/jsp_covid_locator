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
	
	
	public boolean getUser(String email, String password) {
		connect();
		String sql = "select * from users where email = ? and password = ?";
		CovidUser coviduser = new CovidUser();
		boolean chk = false;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,email);
			pstmt.setString(2,password);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			if(rs.getRow()==1)
				chk = true;
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
		return chk;
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
	
	public ArrayList<CovidPatient> getPatient(String area){
		connect();
		String sql = "SELECT * FROM patients p, areas a WHERE p.area = a.id AND a.name = ?";
		ArrayList<CovidPatient> patients = new ArrayList<CovidPatient>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,area);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CovidPatient covidPatient = new CovidPatient();
				covidPatient.setPatient_id(rs.getInt("id"));
				covidPatient.setPatient_cntname(rs.getString("cntname"));
				covidPatient.setPatient_cntcode(rs.getString("cntcode"));
				covidPatient.setPatient_area(rs.getInt("area"));
				covidPatient.setPatient_sex(rs.getInt("sex"));
				covidPatient.setPatient_age(rs.getInt("age"));
				covidPatient.setPatient_home(rs.getString("home"));
				covidPatient.setPatient_job(rs.getString("job"));
				covidPatient.setPatient_route(rs.getString("route"));
				covidPatient.setPatient_first(rs.getString("first"));
				covidPatient.setPatient_end(rs.getString("end"));
				covidPatient.setPatient_hospi(rs.getString("hospi"));
			    patients.add(covidPatient);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return patients;	
	}
	
	public ArrayList<CovidAlert> getAlert(String area){
		connect();
		String sql = "SELECT * FROM alerts t, areas a WHERE t.area = a.id AND a.name = ?";
		ArrayList<CovidAlert> alerts = new ArrayList<CovidAlert>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,area);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CovidAlert covidAlert = new CovidAlert();
				covidAlert.setAlert_id(rs.getInt("id"));
				covidAlert.setAlert_title(rs.getString("title"));
				covidAlert.setAlert_chk(rs.getString("chk"));
				covidAlert.setAlert_date(rs.getString("date"));
			    alerts.add(covidAlert);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return alerts;	
	}
}
