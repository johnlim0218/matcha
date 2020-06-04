package dataBase;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WishListHandler {
	private String movieCd;
	private DBConnector dbConnector = new DBConnector();

	public String getMovieCd() {
		return movieCd;
	}

	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}

	public boolean connectJspToDBConnectorForWishList(HttpServletRequest request, HttpServletResponse response,
			String movieCd) {
		boolean dbCheck = false;

		HttpSession session = request.getSession();
		String mem_idx = (String) session.getAttribute("sIdx");
		String sUserid = (String) session.getAttribute("sUserid");
		String sName = (String) session.getAttribute("sName");

		dbCheck = dbConnector.excuteSelectBeforInsertWishListSql(movieCd, mem_idx, sUserid);

		return dbCheck;
	}

	// 마이페이지 - 보고싶어요 목록 가져오기 (
	public ArrayList<MovieMoreInfo> connectJspToDBConnectorToGetWishList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String mem_idx = (String)session.getAttribute("sIdx");
		String sUserid = (String)session.getAttribute("sUserid");
		String sName = (String)session.getAttribute("sName");
		
		ArrayList<String> arrForMovieCd = new ArrayList<>();
		arrForMovieCd = dbConnector.excuteSelectMovieCdOnWishListSql(mem_idx, sUserid);
		
		ArrayList<MovieMoreInfo> arrForMovieMoreInfo = new ArrayList<>();
		MovieMoreInfo movieMoreInfo = new MovieMoreInfo();
		for(int i = 0; i < arrForMovieCd.size(); i++) {
			movieMoreInfo = dbConnector.excuteSelectMovieInfoToMakeWishlistSql(arrForMovieCd.get(i));
			arrForMovieMoreInfo.add(movieMoreInfo);
		}
		
		return arrForMovieMoreInfo;
	}
}
