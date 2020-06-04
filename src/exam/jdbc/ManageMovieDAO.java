package exam.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ManageMovieDAO {
	private static ManageMovieDAO instance;
	private ManageMovieDAO() {}
	
	public static ManageMovieDAO getInstance() {
		if(instance == null) instance = new ManageMovieDAO();
		return instance;
	}
	
	public void insertMovie(ManageMovieBean bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			conn = DriverDB.driverDbcon();
			String sql = "insert into movieinfo (movieCd, movieNm, movieNmEn, movieprdtYear, movieopenDt, movienationAlt, genreAlt, imgUrl) values (?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getMovieCd());
			pstmt.setString(2, bean.getMovieNm());
			pstmt.setString(3, bean.getMovieNmEn());
			pstmt.setString(4, bean.getMovieprdtYear());
			pstmt.setString(5, bean.getMovieopenDt());
			pstmt.setString(6, bean.getMovienationAlt());
			pstmt.setString(7, bean.getGenreAlt());
			pstmt.setString(8, bean.getImgUrl());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}
	
	public void deleteMovie(ManageMovieBean bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			conn = DriverDB.driverDbcon();
			String sql = "delete from movieinfo where movieCd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getMovieCd());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}
}
