package dataBase;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SearchWordHandler extends HttpServlet {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private String sIdx;
	private String sUserId;
	private String sName;

	private boolean login;

	// movie.jsp -> search.jsp 로부터 사용자가 입력한 검색어를 받아온다.
	private String userInput;

	private boolean checkSearchWordTable;
	// 영진위로부터 받는 JSON 응답
	private String responsedKobis;
	// 영진위로부터 받는 영화인 JSON 응답
	private String responsedKobisForPeople;

	private MovieInfo movieInfo = new MovieInfo();
	private APIConnector apiConnector = new APIConnector();
	private MovieJSONParser movieJSONParser = new MovieJSONParser();
	private Crawler crawler = new Crawler();
	private DBConnector dbConnector = new DBConnector();
	private DBConnectorForWebsiteDB dbConnectorForUserInfo = new DBConnectorForWebsiteDB();

	HashMap<String, MovieInfo> kobisMovie;
	HashMap<String, MoviePeoInfo> kobisMoviePeo;

	private ArrayList<MoviePeoInfo> arrForPeopleList = new ArrayList<>();
	private ArrayList<ArrayList<MoviePeoInfo>> arrForMoviePeoInfo = new ArrayList<>();

	public SearchWordHandler(HttpServletRequest request, HttpServletResponse response) {

	}

	public SearchWordHandler(String userInput, HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		setsIdx((String) session.getAttribute("sIdx"));
		setsUserId((String) session.getAttribute("sUserid"));
		setsName((String) session.getAttribute("sName"));
		login(); // 로그인여부 확인
		
		setUserInput(userInput);
		
		// 사용자가 입력한 검색어를 저장
		userInputToDBConnector(request, response);

		// 영화 검색
		searchWordHandlerToKobisApiConnector();
		// 영화 검색 후 JSON 파싱
		responsedKobisToKobisJSONParser();
		// 영화 포스터 검색
		searchWordHandlerToCrawlerForImg();

		// 인물검색
		searchWordHandlerToKobisApiConnectorForPeopleList();
		// 인물 리스트에서 인물 코드만 추출 후 재검색
		searchWordHandlerToKobisApiConnectorForPeopleCd();
		// 인물 이미지 검색
		searchWordHandlerToCrawlerForPeopleImg();

		// DB저장
		toDBConnector();

	}

	public String getsIdx() {
		return sIdx;
	}

	public void setsIdx(String sIdx) {
		this.sIdx = sIdx;
	}

	public String getsUserId() {
		return sUserId;
	}

	public void setsUserId(String sUserId) {
		this.sUserId = sUserId;
	}

	public String getsName() {
		return sName;
	}

	public void setsName(String sName) {
		this.sName = sName;
	}

	public boolean isLogin() {
		return login;
	}

	public void setLogin(boolean login) {
		this.login = login;
	}

	public String getUserInput() {
		return userInput;
	}

	public void setUserInput(String userInput) {
		this.userInput = userInput;
	}

	public boolean isCheckSearchWordTable() {
		return checkSearchWordTable;
	}

	public void setCheckSearchWordTable(boolean checkSearchWordTable) {
		this.checkSearchWordTable = checkSearchWordTable;
	}

	public HashMap<String, MovieInfo> getKobisMovie() {
		return kobisMovie;
	}

	public void setKobisMovie(HashMap<String, MovieInfo> kobisMovie) {
		this.kobisMovie = kobisMovie;
	}

	public String getResponsedKobis() {
		return responsedKobis;
	}

	public void setResponsedKobis(String responsedKobis) {
		this.responsedKobis = responsedKobis;
	}

	public String getResponsedKobisForPeople() {
		return responsedKobisForPeople;
	}

	public void setResponsedKobisForPeople(String responsedKobisForPeople) {
		this.responsedKobisForPeople = responsedKobisForPeople;
	}

	public ArrayList<MoviePeoInfo> getArrForPeopleList() {
		return arrForPeopleList;
	}

	public void setArrForPeopleList(ArrayList<MoviePeoInfo> arrForPeopleList) {
		this.arrForPeopleList = arrForPeopleList;
	}

	public ArrayList<ArrayList<MoviePeoInfo>> getArrForMoviePeoInfo() {
		return arrForMoviePeoInfo;
	}

	public void setArrForMoviePeoInfo(ArrayList<ArrayList<MoviePeoInfo>> arrForMoviePeoInfo) {
		this.arrForMoviePeoInfo = arrForMoviePeoInfo;
	}

	public void login() {
		if (getsIdx() == null || getsUserId() == null || getsName() == null) {
			setLogin(false);
		} else if (getsIdx() != null && getsUserId() != null && getsName() != null) {
			setLogin(true);
		}
	}

	// 영진위 영화 검색 API 접속
	public void searchWordHandlerToKobisApiConnector() {
		apiConnector.setUserInput(getUserInput());
		String responsedKobis = apiConnector.kobisFilmCon();
		
		// JSON to DB 테스트
//		dbConnector.setResponsedKobis(responsedKobis);
//		dbConnector.excuteInsertJson();

		setResponsedKobis(responsedKobis);

		// 영진위로 부터 받은 JSON 응답을 JSONParser로 이동
		movieJSONParser.setResponsed(responsedKobis);

	}

	// 영진위 영화인 리스트 검색 API 접속
	public void searchWordHandlerToKobisApiConnectorForPeopleList() {
		apiConnector.setUserInput(getUserInput());
		String responsedKobisForPeople = apiConnector.kobisPeoListCon();

		setResponsedKobis(responsedKobisForPeople);

		movieJSONParser.setResponsed(responsedKobisForPeople);

		setArrForPeopleList(movieJSONParser.KobisPeoJSONParserForPeopleList());

	}

	// 영진위 영화인 검색 API 접속
	public void searchWordHandlerToKobisApiConnectorForPeopleCd() {

		for (int i = 0; i < getArrForPeopleList().size(); i++) {
			apiConnector.setPeopleCd(getArrForPeopleList().get(i).getPeoCd());
			String responsedKobisForPeople = apiConnector.kobisPeoCon();
			setResponsedKobisForPeople(responsedKobisForPeople);

			responsedKobisForPeopleToKobisPeoJSONParser();
		}
	}

	public void responsedKobisToKobisJSONParser() {
		// 영진위 영화 검색 JSON응답 Parsing 후
		kobisMovie = new HashMap<>();
		kobisMovie = movieJSONParser.KobisMovieJSONParser();
		setKobisMovie(kobisMovie);
	}

	public void responsedKobisForPeopleToKobisPeoJSONParser() {
		movieJSONParser.setResponsed(getResponsedKobisForPeople());
		arrForMoviePeoInfo.add(movieJSONParser.KobisPeoJSONParser());
	}

	public void searchWordHandlerToCrawlerForImg() {

		Set<Entry<String, MovieInfo>> set = getKobisMovie().entrySet();
		for (Map.Entry<String, MovieInfo> element : set) {
			String key = element.getKey();
			String movieTitle = element.getValue().getMovieNm();
			String movieTitleEn = element.getValue().getMovieNmEn();
			String prdtYear = element.getValue().getPrdtYear();
			String openDt = element.getValue().getOpenDt();
		}

		for (Map.Entry<String, MovieInfo> element : set) {
			String key = element.getKey();
			String movieTitle = element.getValue().getMovieNm();
			String movieTitleEn = element.getValue().getMovieNmEn();
			String prdtYear = element.getValue().getPrdtYear();
			String nationAlt = element.getValue().getNationAlt();
			String directorNm = element.getValue().getDirectors().get(0);

			crawler.setResponsedKobis(movieTitle);
			crawler.setResponsedKobisEn(movieTitleEn);
			crawler.setResponsedPrdtYear(prdtYear);
			crawler.setResponsedNationAlt(nationAlt);

			crawler.setResponsedDirectorActorNm(directorNm);

			String naverPosterUrl = crawler.crawlerForImg();

			movieInfoHashMapUpdate(key, naverPosterUrl);
		}
	}

	public void movieInfoHashMapUpdate(String key, String imgUrl) {

		MovieInfo newMovieInfo = new MovieInfo();

		String movieCd = getKobisMovie().get(key).getMovieCd();
		String movieTitle = getKobisMovie().get(key).getMovieNm();
		String movieTitleEn = getKobisMovie().get(key).getMovieNmEn();
		String prdtYear = getKobisMovie().get(key).getPrdtYear();
		String openDt = getKobisMovie().get(key).getOpenDt();
		String nationAlt = getKobisMovie().get(key).getNationAlt();
		String genreAlt = getKobisMovie().get(key).getGenreAlt();
		ArrayList<String> directors = getKobisMovie().get(key).getDirectors();
		newMovieInfo.setMovieCd(movieCd);
		newMovieInfo.setMovieNm(movieTitle);
		newMovieInfo.setMovieNmEn(movieTitleEn);
		newMovieInfo.setPrdtYear(prdtYear);
		newMovieInfo.setOpenDt(openDt);
		newMovieInfo.setNationAlt(nationAlt);
		newMovieInfo.setGenreAlt(genreAlt);
		newMovieInfo.setDirectors(directors);
		newMovieInfo.setImgUrl(imgUrl);

		getKobisMovie().put(key, newMovieInfo);

	}

	public void searchWordHandlerToCrawlerForPeopleImg() {
		String imgUrl = "";
		String peoImgUrl = "";
		for (int i = 0; i < getArrForMoviePeoInfo().size(); i++) {
			for (int j = 0; j < getArrForMoviePeoInfo().get(i).size(); j++) {
				String movieNm = getArrForMoviePeoInfo().get(i).get(j).getMovieNm();
				String peopleNm = getArrForMoviePeoInfo().get(i).get(j).getPeopleNm();
				crawler.setResponsedKobisForPeople(peopleNm);
				crawler.setResponsedKobis(movieNm);
				crawler.setResponsedKobisEn("");
				crawler.setResponsedDirectorActorNm(peopleNm);

				peoImgUrl = crawler.crawlerForPeopleImg();
				imgUrl = crawler.crawlerForImg();

				getArrForMoviePeoInfo().get(i).get(j).setPeoImgUrl(peoImgUrl);
				getArrForMoviePeoInfo().get(i).get(j).setImgUrl(imgUrl);
			}
		}

	}

	// 검색어 확인 저장
	public void userInputToDBConnector(HttpServletRequest request, HttpServletResponse response) {
		dbConnector.setUserInput(getUserInput());
		dbConnector.excuteInsertAfterSelectSearchWordSql(request, response, isLogin());

	}
	
	// 사용자 요청 처리 후 검색어 다시 저장(사용자의 요청이 정상적으로 처리되었는지를 확인하기 위함)
	public void userinputToDBConnectorToCheckSuccessful(HttpServletRequest request, HttpServletResponse response, String userInput, int result) {
		dbConnector.setUserInput(userInput);
		dbConnector.excuteInsertSearchWordCheckSuccessful(request, response, isLogin(), result);
	}

	// DB에 저장
	public void toDBConnector() {
		if (getKobisMovie().size() > 0) {
			dbConnector.setMovieInfo(getKobisMovie());
			dbConnector.excuteSelectBeforeInsertToMovieInfo();
		}
		if (arrForMoviePeoInfo.size() > 0) {
			dbConnector.setMoviePeoInfo(getArrForMoviePeoInfo());
			dbConnector.excuteSelectBeforeInsertToPeopleInfo();
		}
	}

	////////////////////////////////////////////////////////////////////

	// DB에서 불러오기 (search.jsp -> DBConnector.java)
	public ArrayList<ReturnInfo> connectJspToDBConnector(String userInput) {
		
		ArrayList<ReturnInfo> returnInfo = new ArrayList<>();

		ArrayList<ReturnInfo> tempArrForMovieInfo = new ArrayList<>();
		ArrayList<ReturnInfo> tempArrForPeopleInfo = new ArrayList<>();
		tempArrForMovieInfo = dbConnector.excuteSelectFromMovieInfoTableMovieCdSql(userInput);
		tempArrForPeopleInfo = dbConnector.excuteSelectFromPeopleInfoTableMovieCdSql(userInput);

		ReturnInfo tempReturnInfo = new ReturnInfo();

		if (tempArrForMovieInfo.size() > 0) {
			for (int i = 0; i < tempArrForMovieInfo.size(); i++) {
				returnInfo.add(tempArrForMovieInfo.get(i));
			}
		}
		if (tempArrForPeopleInfo.size() > 0) {
			for (int i = 0; i < tempArrForPeopleInfo.size(); i++) {
				returnInfo.add(tempArrForPeopleInfo.get(i));
			}
		}

		// movieCd 내림차순으로 재정렬
		for (int i = 0; i < returnInfo.size(); i++) {
			for (int j = 0; j < i; j++) {
				if (Integer.parseInt(returnInfo.get(i).getMovieCd()) > Integer
						.parseInt(returnInfo.get(j).getMovieCd())) {
					tempReturnInfo = returnInfo.get(i);
					returnInfo.set(i, returnInfo.get(j));
					returnInfo.set(j, tempReturnInfo);
				}
				if (returnInfo.get(i).getMovieCd().equals(returnInfo.get(j).getMovieCd())) {
					returnInfo.remove(i);
				}
			}
		}
		
		return returnInfo;
	}

	// DB에서 검색결과(사용자정보) 가져오기
	public ArrayList<ReturnUserInfo> connectJspToDBConnectorForUserInfo() {
		ArrayList<ReturnUserInfo> returnUserInfo = new ArrayList<>();
		dbConnectorForUserInfo.setUserInput(getUserInput());
		returnUserInfo = dbConnectorForUserInfo.excuteSelectUserInfoSql();

		return returnUserInfo;
	}

	// searchresultmore.jsp
	public int connectJspToDBConnectorForCountNumOfData() {
		dbConnector.setUserInput(getUserInput());

		int listTotal = 0;
		listTotal += dbConnector.excuteSelectCountMovieInfoDataForPagingSearchResultMoreSql();
		listTotal += dbConnector.excuteSelectCountPeopleInfoDataForPagingSearchResultMoreSql();

		return listTotal;
	}

	// searchresultmore.jsp
	public ArrayList<ReturnInfo> connectJspToDBConnectorForSearchResultMorePaging(String nowPage) {
		ArrayList<ReturnInfo> returnArr = new ArrayList<>();
		returnArr = dbConnector.excuteSelectMovieInfoDataForSearchResultMoreSql(nowPage);
		int shortage = 0;
		if (nowPage.equals("1")) {

			// nowPage가 1일 경우(최초 페이지)
			// movieInfo 테이블에서 가져올 데이터가 없을 경우
			// peopleInfo 테이블에서 데이터를 가져온다.

			if (returnArr.size() < 10) {
				shortage = 10 - returnArr.size();
				returnArr.addAll(dbConnector.excuteSelectPeopleInfoDataForSearchResultMoreSql(nowPage));
			}

			// nowPage가 2이상일 경우
		} else if (!nowPage.equals("1")) {
			if (returnArr.size() < 5) {
				shortage = 5 - returnArr.size();
				returnArr.addAll(dbConnector.excuteSelectPeopleInfoDataForSearchResultMoreSql(nowPage));

			}
		}
		return returnArr;
	}
	
	
}
