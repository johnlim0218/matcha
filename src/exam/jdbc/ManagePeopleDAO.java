package exam.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ManagePeopleDAO {
	private static ManagePeopleDAO instance;
	private ManagePeopleDAO() {}
	
	public static ManagePeopleDAO getInstance() {
		if(instance == null) instance = new ManagePeopleDAO();
		return instance;
	}
	
	public void insertPeople(ManagePeopleBean bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			conn = DriverDB.driverDbcon();
			String sql = "insert into peopleinfo (peoCd, peopleNm, peopleNmEn, movieNm, movieCd, moviePartNm, imgUrl, peoImgUrl) values (?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getPeoCd());
			pstmt.setString(2, bean.getPeopleNm());
			pstmt.setString(3, bean.getPeopleNmEn());
			pstmt.setString(4, bean.getMovieNm());
			pstmt.setString(5, bean.getMovieCd());
			pstmt.setString(6, bean.getMoviePartNm());
			pstmt.setString(7, bean.getImgUrl());
			pstmt.setString(8, bean.getPeoImgUrl());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}
	
	public void deletePeople(ManagePeopleBean bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			conn = DriverDB.driverDbcon();
			String sql = "delete from peopleinfo where peoCd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getPeoCd());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}
}
