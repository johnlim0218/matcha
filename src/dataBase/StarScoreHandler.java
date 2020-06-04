package dataBase;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class StarScoreHandler {
	DBConnector dbConnector = new DBConnector();
	
	public int connectJspToDBConnectorToGetStarScore(String ss_movieCd, String ss_mem_idx) {
		int starScore = 0;
		starScore = dbConnector.excuteSelectStarScoreToGetSql(ss_movieCd, ss_mem_idx);
		return starScore;
	}
	
	public void connectJspToDBConnectorForStarScore(String ss_movieCd, String ss_mem_idx, String ss_score) {
		dbConnector.excuteSelectStarScoreBeforInsertSql(ss_movieCd, ss_mem_idx, ss_score);
	}
	
	public int connetJspToDBConnectorToGetTotalCountStarScore() {
		int totalCountStarScore = 0;
		totalCountStarScore = dbConnector.excuteSelectTotalCountStarScoreSql();
		return totalCountStarScore;
	}
	
	public ArrayList<MovieMoreInfo> connectJspToDBConnectorToGetMovieCdAndScoreFromStarScoreTable(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String mem_idx = (String)session.getAttribute("sIdx");
		String sUserid = (String)session.getAttribute("sUserid");
		String sName = (String)session.getAttribute("sName");
		
		ArrayList<MovieMoreInfo> arrForMovieCdAndStarScore = new ArrayList<>();
		arrForMovieCdAndStarScore = dbConnector.excuteSelectStarScoreToGetMovieCdAndScoreSql(mem_idx);
		
		ArrayList<MovieMoreInfo> arrForMovieMoreInfo = new ArrayList<>();
		MovieMoreInfo movieMoreInfo = new MovieMoreInfo();
		for(int i = 0; i < arrForMovieCdAndStarScore.size(); i++) {
			String movieCd = arrForMovieCdAndStarScore.get(i).getMovieCd();
			String starScore = arrForMovieCdAndStarScore.get(i).getStarScore();
			movieMoreInfo = dbConnector.excuteSelectStarScoreListWithMovieCdSql(movieCd, starScore);
			arrForMovieMoreInfo.add(movieMoreInfo);
		}
		
		return arrForMovieMoreInfo;
	}
	
}
