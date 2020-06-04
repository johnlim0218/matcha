package dataBase;

import java.util.ArrayList;

public class MoreInfoHandler {

	private String movieCd;
	private String responsedKobis;

	private APIConnector apiConnector = new APIConnector();
	private MovieJSONParser movieJSONParser = new MovieJSONParser();
	private DBConnector dbConnector = new DBConnector();
	private DBConnectorForWebsiteDB dbConnectorForUserInfo = new DBConnectorForWebsiteDB();

	private MovieMoreInfo movieMoreInfo = new MovieMoreInfo();
	private ArrayList<ReturnBoard> returnArrForMovieArticle = new ArrayList<>();

	public MoreInfoHandler() {

	}

	public MoreInfoHandler(String movieCd) {
		setMovieCd(movieCd);

		moreInfoHandlerToKobisApiConnector();

		responsedKobisMoreInfoToKobisJSONParser();

		toDBConnectorToGetImgUrl();
		toDBConnector();
		toDBConnectorForUserInfoToGetMovieArticle();
	}

	public String getMovieCd() {
		return movieCd;
	}

	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}

	public String getResponsedKobis() {
		return responsedKobis;
	}

	public void setResponsedKobis(String responsedKobis) {
		this.responsedKobis = responsedKobis;
	}

	public MovieMoreInfo getMovieMoreInfo() {
		return movieMoreInfo;
	}

	public void setMovieMoreInfo(MovieMoreInfo movieMoreInfo) {
		this.movieMoreInfo = movieMoreInfo;
	}

	public ArrayList<ReturnBoard> getReturnArrForMovieArticle() {
		return returnArrForMovieArticle;
	}

	public void setReturnArrForMovieArticle(ArrayList<ReturnBoard> returnArrForMovieArticle) {
		this.returnArrForMovieArticle = returnArrForMovieArticle;
	}

	public void moreInfoHandlerToKobisApiConnector() {
		apiConnector.setMovieCd(movieCd);
		String responsedKobisMoreInfo = apiConnector.kobisMovieMoreInfoCon();
		setResponsedKobis(responsedKobisMoreInfo);

		movieJSONParser.setResponsed(responsedKobisMoreInfo);
	}

	public void responsedKobisMoreInfoToKobisJSONParser() {

		movieMoreInfo = movieJSONParser.KobisMoreInfoJSONParser();
		setMovieMoreInfo(movieMoreInfo);
	}

	public void toDBConnectorToGetImgUrl() {
		dbConnector.setMovieMoreInfo(getMovieMoreInfo());
		String imgUrl = dbConnector.excuteSelectFromMovieInfoTableForImgUrlSql();
		if (imgUrl.equals("")) {
			imgUrl = dbConnector.excuteSelectFromPeopleInfoTableForImgUrlSql();
		}
		getMovieMoreInfo().setImgUrl(imgUrl);
		setMovieMoreInfo(getMovieMoreInfo());
	}

	public void toDBConnector() {
		dbConnector.setMovieMoreInfo(getMovieMoreInfo());
		dbConnector.excuteSelectFromMovieMoreInfoTableBeforeInsertSql();
	}

	// 감독 정보 더보기
	public ArrayList<DirectorsMovieMoreInfo> toDBConnectorToGetDirectorsMore(String movieCd) {
		ArrayList<DirectorsMovieMoreInfo> arrForReturnDirectors = new ArrayList<>();
		arrForReturnDirectors = dbConnector.excuteSelectDirectorMoreFromDirectorMoreInfo(movieCd);
		return arrForReturnDirectors;
	}

	// 배우 정보 더보기
	public ArrayList<ActorsMovieMoreInfo> toDBConnectorToGetActorsMore(String movieCd) {
		ArrayList<ActorsMovieMoreInfo> arrForReturnActors = new ArrayList<>();
		arrForReturnActors = dbConnector.excuteSelectActorMoreFromActorsMoreInfo(movieCd);
		return arrForReturnActors;
	}
	
	// 게시판에서 코멘트 가져오기
	public void toDBConnectorForUserInfoToGetMovieArticle() {
		dbConnectorForUserInfo.setMovieCd(getMovieCd());
		setReturnArrForMovieArticle(dbConnectorForUserInfo.excuteSelectMovieArticleFromBoardTableSql());
	}
	
}
