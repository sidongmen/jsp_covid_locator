package covidLocator.model;

import java.sql.*;
import java.util.*;
import java.util.Date;

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
	
	
	public CovidUser getUser(String email, String password) {
		connect();
		String sql = "select * from users where email = ? and password = ?";
		CovidUser coviduser = new CovidUser();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,email);
			pstmt.setString(2,password);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			if(rs.getRow()==1)
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
		String sql = "SELECT * FROM alerts t, areas a WHERE t.area = a.id AND a.name = ? order by t.date desc";
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
	
	public ArrayList<CovidPost> getPost(String area){
		connect();
		String sql = "SELECT p.id,p.title,p.content,u.nickname,p.view,p.date FROM posts p, areas a, users u WHERE p.area = a.id and p.user=u.id and a.name=? order by p.date DESC";
		ArrayList<CovidPost> posts = new ArrayList<CovidPost>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,area);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CovidPost covidPost = new CovidPost();
				covidPost.setPost_id(rs.getInt("id"));
				covidPost.setPost_title(rs.getString("title"));
				covidPost.setPost_content(rs.getString("content"));
				covidPost.setPost_nickname(rs.getString("nickname"));
				covidPost.setPost_view(rs.getInt("view"));
				covidPost.setPost_date(rs.getString("date"));
			    posts.add(covidPost);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return posts;	
	}
	
	public CovidPost getPostDetail(int id){
		connect();
		String sql = "SELECT p.id,p.title,p.content,u.nickname,p.view,p.date FROM posts p, areas a, users u WHERE p.area = a.id and p.user=u.id and p.id=?";
		CovidPost covidPost = new CovidPost();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
				covidPost.setPost_id(rs.getInt("id"));
				covidPost.setPost_title(rs.getString("title"));
				covidPost.setPost_content(rs.getString("content"));
				covidPost.setPost_nickname(rs.getString("nickname"));
				covidPost.setPost_view(rs.getInt("view"));
				covidPost.setPost_date(rs.getString("date"));
	
			
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return covidPost;	
	}
	
	// 신규 포스트 추가 메서드
	public boolean insertPost(CovidPost covidPost, String location) {
		connect();
				
		String sql ="insert into posts(user,area,title,content,view,date) values(?,(select id from areas where name =?),?,?,?,Now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,covidPost.getPost_user());
			pstmt.setString(2, location);
			pstmt.setString(3,covidPost.getPost_title());
			pstmt.setString(4,covidPost.getPost_content());
			pstmt.setInt(5,1);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
    public boolean insertView(int postId) {
    	connect();
    	
    	String sql = "update posts set view = view + 1 where id = ?";
    	try {
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postId);
    		pstmt.executeUpdate();
    	} catch(SQLException e) {
    		e.printStackTrace();
    		return false;
    	}
    	
    	return true;
    }
    public boolean delPost(int postId) {
    	connect();
    	
    	String sql = "delete from posts where id = ?";
    	try {
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, postId);
    		pstmt.executeUpdate();
    	} catch(SQLException e) {
    		e.printStackTrace();
    		return false;
    	}
    	
    	return true;
    }
    
	// 신규 지역 알림 추가 메소
	public boolean insertAlert(CovidAlert covidAlert, String location) {
		connect();
				
		String sql ="insert into alerts(area,title,chk,date) values((select id from areas where name =?),?,?,Now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, location);
			pstmt.setString(2,covidAlert.getAlert_title());
			pstmt.setString(3,covidAlert.getAlert_chk());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
    public boolean delAlert(int alertId) {
    	connect();
    	
    	String sql = "delete from alerts where id = ?";
    	try {
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, alertId);
    		pstmt.executeUpdate();
    	} catch(SQLException e) {
    		e.printStackTrace();
    		return false;
    	}
    	
    	return true;
    }
}
