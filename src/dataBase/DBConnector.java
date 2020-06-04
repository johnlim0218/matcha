package dataBase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DBConnector {

	private PreparedStatement pstmt;
	private Connection con;
	private String dbUrl = "";
	private String dbUser = "";
	private String dbPw = "";
	private String sql = "";
	private ResultSet rs;

	private String userInput;
	private String responsedKobis;
	private HashMap<String, MovieInfo> movieInfo = new HashMap<>();
	private ArrayList<ArrayList<MoviePeoInfo>> moviePeoInfo = new ArrayList<>();

	private MovieMoreInfo movieMoreInfo = new MovieMoreInfo();

	DBConnector() {
		setUpDBConnetor();
	}

	public String getUserInput() {
		return userInput;
	}

	public void setUserInput(String userInput) {
		this.userInput = userInput;
	}

	public String getResponsedKobis() {
		return responsedKobis;
	}

	public void setResponsedKobis(String responsedKobis) {
		this.responsedKobis = responsedKobis;
	}

	public HashMap<String, MovieInfo> getMovieInfo() {
		return movieInfo;
	}

	public void setMovieInfo(HashMap<String, MovieInfo> movieInfo) {
		this.movieInfo = movieInfo;
	}

	public ArrayList<ArrayList<MoviePeoInfo>> getMoviePeoInfo() {
		return moviePeoInfo;
	}

	public void setMoviePeoInfo(ArrayList<ArrayList<MoviePeoInfo>> moviePeoInfo) {
		this.moviePeoInfo = moviePeoInfo;
	}

	public MovieMoreInfo getMovieMoreInfo() {
		return movieMoreInfo;
	}

	public void setMovieMoreInfo(MovieMoreInfo movieMoreInfo) {
		this.movieMoreInfo = movieMoreInfo;
	}

	public PreparedStatement getPstmt() {
		return pstmt;
	}

	public void setPstmt(PreparedStatement pstmt) {
		this.pstmt = pstmt;
	}

	public Connection getCon() {
		return con;
	}

	public void setCon(Connection con) {
		this.con = con;
	}

	public String getDbUrl() {
		return dbUrl = "jdbc:mariadb://localhost:3306/matcha";
	}

	public String getDbUser() {
		return dbUser = "root";
	}

	public String getDbPw() {
		return dbPw = "1234";
	}

	public void setUpDBConnetor() {

		try {
			Class.forName("org.mariadb.jdbc.Driver");

			con = DriverManager.getConnection(getDbUrl(), getDbUser(), getDbPw());

			if (con != null) {

			}

			setCon(con);

		} catch (ClassNotFoundException e) {
			System.out.println("드라이버가 존재하지 않습니다.");
		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

	public String selectBeforeInsertSearchWordSql() {
		return sql = "select w_mem_searchword from searchword where w_mem_searchword = ?";
	}

	public String insertAfterSelectSearchWordLogInSql() {
		return sql = "insert into searchword (w_mem_idx, w_mem_userid, w_mem_searchword,  w_result, w_successful, w_mem_ip) values (?,?,?,?,?,?)";
	}

	public String insertAfterSelectSearchWordLogOutSql() {
		return sql = "insert into searchword (w_mem_searchword,  w_result, w_successful, w_mem_ip) values (?,?,?,?)";
	}

	public String insertSearchWordCheckSuccessfulLogInSql() {
		return sql = "insert into searchword (w_mem_idx, w_mem_userid, w_mem_searchword, w_result, w_successful ,w_mem_ip) values (?,?,?,?,?,?)";
	}

	public String insertSearchWordCheckSuccessfulLogOutSql() {
		return sql = "insert into searchword (w_mem_searchword, w_result, w_successful ,w_mem_ip) values (?,?,?,?)";
	}

	public String selectBeforeInsertMovieSql() {
		return sql = "select movieCd from movieInfo where movieCd = ?";
	}

	public String insertAfterSelectMovieSql() {
		return sql = "insert into movieInfo (movieCd, movieNm, movieNmEn, movieprdtYear, movieopenDt, movienationAlt, genreAlt, imgUrl) values (?,?,?,?,?,?,?,?)";
	}

	public String selectBeforInsertPeoSql() {
		return sql = "select peoCd, movieCd from peopleinfo where peoCd = ? and movieCd = ?";
	}

	public String insertAfterSelectPeoSql() {
		return sql = "insert into peopleinfo (peoCd, peopleNm, peopleNmEn, movieNm, movieCd, moviePartNm, imgUrl, peoImgUrl) values (?,?,?,?,?,?,?,?)";
	}

	public String selectFromMovieInfoTableMovieCdSql() {
		return sql = "select movieCd, movieNm ,imgUrl from movieInfo where replace(movieNm,' ', '') like ? or replace(movieNmEn,' ', '') like ? order by movieCd desc limit 0, 10";
	}

	public String selectFromPeopleInfoTableMovieCdSql() {
		return sql = "select movieCd, movieNm ,imgUrl, peoImgUrl from peopleInfo where replace(peopleNm,' ', '') like ? or replace(peopleNmEn,' ', '') like ? order by movieCd desc limit 0, 10";
	}

	// 영화 이미지 URL 가져오는 쿼리
	public String selectFromMovieInfoTableForImgUrlSql() {
		return sql = "select imgUrl from movieInfo where movieCd like ?";
	}

	public String selectFromPeopleInfoTableForImgUrlSql() {
		return sql = "select imgUrl from peopleInfo where movieCd like ?";
	}

	// 영화 상세정보 중복 확인용 쿼리
	public String selectFromMovieMoreInfoTableBeforeInsertSql() {
		return sql = "select movieCd from movieMoreInfo where movieCd like ?";
	}

	public String updateHitsAtMovieMoreInfoTableSql() {
		return sql = "update movieMoreInfo set hits = hits+1 where movieCd=?";
	}

	// 영화 상세정보 삽입 쿼리
	public String insertMovieMoreInfoTableAfterSelectSql() {
		return sql = "insert into movieMoreInfo (movieCd, movieNm, movieNmEn, moviePrdtYear, movieOpenDt, movieShowTm, imgUrl) values (?,?,?,?,?,?,?)";
	}

	// 영화 상세정보 삽입(제작국가정보) 쿼리
	public String insertNationsMovieMoreInfoTableAfterSelectSql() {
		return sql = "insert into nationsMovieMoreInfo (movieCd, nationNm) values (?,?)";
	}

	// 영화 상세정보 삽입(장르정보) 쿼리
	public String insertGenresMovieMoreInfoTableAfterSelectSql() {
		return sql = "insert into genresMovieMoreInfo (movieCd, genreNm) values (?,?)";
	}

	// 영화 상세정보 삽입(감독정보) 쿼리
	public String insertDirectorsMovieMoreInfoTableAfterSelectSql() {
		return sql = "insert into directorsMovieMoreInfo (movieCd, drPeopleNm, drPeopleNmEn) values (?,?,?)";
	}

	// 영화 상세정보 삽입(배우정보) 쿼리
	public String insertActorsMovieMoreInfoTableAfterSelectSql() {
		return sql = "insert into actorsMovieMoreInfo (movieCd, acPeopleNm, acPeopleNmEn, castNm, castNmEn) values (?,?,?,?,?)";
	}

	////////////////////////////////////////////////////////
	// 보고싶어요 등록 전 확인
	public String selectBeforInsertWishListSql() {
		return sql = "select movieCd, mem_idx from wishlist where movieCd = ? and mem_idx = ?";
	}

	// 보고싶어요 등록
	public String insertWishListAfterSelectSql() {
		return sql = "insert into wishlist (movieCd, mem_idx, mem_userid) values(?,?,?)";
	}

	// 보고싶어요 리스트
	public String selectMovieCdOnWishListSql() {
		return sql = "select movieCd, mem_idx from wishlist where mem_idx = ? and mem_userid = ? order by wishdate desc";
	}

	// 보고싶어요 리스트에서 가져온 movieCd로 movieMoreInfo의 영화 정보를 가져오기
	public String selectMovieInfoToMakeWishlistSql() {
		return sql = "select movieCd, movieNm, movieNmEn, moviePrdtYear, movieShowTm, imgUrl from moviemoreinfo where movieCd = ?";
	}

	////////////////////////////////////////////////////////

	// searchresultmore.jsp(영화 검색 결과 더보기) 페이징을 위한 데이터 총 개수
	public String selectCountMovieInfoDataForPagingSearchResultMoreSql() {
		return sql = "select count(movieCd) from movieinfo where replace(movieNm,' ', '') like ? or replace(movieNmEn,' ', '') like ?";
	}

	// searchresultmore.jsp(영화 검색 결과 더보기) 페이징을 위한 데이터 총 개수
	public String selectCountPeopleInfoDataForPagingSearchResultMoreSql() {
		return sql = "select count(movieCd) from peopleinfo where replace(peopleNm,' ', '') like ? or replace(peopleNmEn,' ', '') like ?";
	}

	public String selectMovieInfoDataForSearchResultMoreSql() {
		return sql = "select movieCd, movieNm, imgUrl from movieInfo where replace(movieNm,' ', '') like ? or replace(movieNmEn,' ', '') like ? order by movieCd desc limit ?, ?";
	}

	public String selectPeopleInfoDataForSearchResultMoreSql() {
		return sql = "select movieCd, movieNm, imgUrl from peopleInfo where replace(peopleNm,' ', '') like ? or replace(peopleNmEn,' ', '') like ? order by movieCd desc limit ?, ?";
	}

	//////////////////////////////////////////////////////////////////

	// (로그인시)기존 별점 확인
	public String selectStarScoreBeforInsertSql() {
		return sql = "select ss_movieCd, ss_mem_idx, ss_score from starscore where ss_movieCd = ? and ss_mem_idx=?";
	}

	// (로그인시)기존 별점 수정
	public String updateStarScoreSql() {
		return sql = "update starscore set ss_score = ? where ss_movieCd = ? and ss_mem_idx=?";
	}

	// (로그인시)별점 주기
	public String insertStarScoreAfterSelectSql() {
		return sql = "insert into starscore (ss_movieCd, ss_mem_idx, ss_score) values(?,?,?)";
	}

	// 별점 총 개수 
	public String selectTotalCountStarScoreSql() {
		return sql = "select count(ss_movieCd) from starscore";
	}
	
	// 마이페이지 - 평가한 영화 리스트 (movieCd, 별점 정보 가져오기)
	public String selectStarScoreToGetMovieCdAndScoreSql() {
		return sql = "select ss_movieCd, ss_mem_idx, ss_score from starscore where ss_mem_idx = ?";
	}
	// 마이페이지 - 평가한 영화 리스트 (movieCd로 영화 정보 가져오기)
	public String selectStarScoreListWithMovieCdSql() {
		return sql = "select movieCd, movieNm, movieNmEn, moviePrdtYear, imgUrl from moviemoreinfo where movieCd = ?";
	}

	//////////////////////////////////////////////////////////////////
	public String selectDirectorMoreFromDirectorMoreInfo() {
		return sql = "select movieCd, drPeopleNm, drPeopleNmEn from directorsmoviemoreinfo where movieCd=?";
	}

	public String selectActorMoreFromActorsMoreInfo() {
		return sql = "select movieCd, acPeopleNm, acPeopleNmEn, castNm, castNmEn from actorsmoviemoreinfo where movieCd=?";
	}

	// 검색어 DB에 사용자가 입력한 검색어가 존재하는지 확인한다.
	// 있다면 true, 없다면 false 반환
	public boolean excuteSelectBeforeInsertSearchWordSql(HttpServletRequest request, HttpServletResponse response) {
		boolean checkSearchWordTable = false;
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectBeforeInsertSearchWordSql());
			pstmt.setString(1, getUserInput());
			rs = pstmt.executeQuery();

			if (rs.next() != true) {
				// 없다
				checkSearchWordTable = false;

			} else {
				// 있다
				checkSearchWordTable = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return checkSearchWordTable;
	}

	public void excuteInsertAfterSelectSearchWordSql(HttpServletRequest request, HttpServletResponse response,
			Boolean login) {
		// 세션을 가져와야함
		HttpSession session = request.getSession();

		pstmt = null;
		try {
			// 로그인 상태
			if (login) {
				pstmt = getCon().prepareStatement(insertAfterSelectSearchWordLogInSql());
				pstmt.setString(1, (String) session.getAttribute("sIdx"));
				pstmt.setString(2, (String) session.getAttribute("sUserid"));
				pstmt.setString(3, getUserInput());
				pstmt.setInt(4, 0);
				pstmt.setInt(5, 0);
				pstmt.setString(6, request.getRemoteAddr());

				// 로그아웃 상태
			} else if (!login) {
				pstmt = getCon().prepareStatement(insertAfterSelectSearchWordLogOutSql());
				pstmt.setString(1, getUserInput());
				pstmt.setInt(2, 0);
				pstmt.setInt(3, 0);
				pstmt.setString(4, request.getRemoteAddr());

			}

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}

	}

	public void excuteInsertSearchWordCheckSuccessful(HttpServletRequest request, HttpServletResponse response,
			Boolean login, int result) {

		// 세션을 가져와야함
		HttpSession session = request.getSession();

		pstmt = null;
		try {
			// 로그인 상태
			if (login) {
				pstmt = getCon().prepareStatement(insertSearchWordCheckSuccessfulLogInSql());
				pstmt.setString(1, (String) session.getAttribute("sIdx"));
				pstmt.setString(2, (String) session.getAttribute("sUserid"));
				pstmt.setString(3, getUserInput());
				pstmt.setInt(4, result);
				pstmt.setInt(5, 1); // 1 - "문제없이 데이터를 전송했다"
				pstmt.setString(6, request.getRemoteAddr());

				// 로그아웃 상태
			} else if (!login) {
				pstmt = getCon().prepareStatement(insertSearchWordCheckSuccessfulLogOutSql());
				pstmt.setString(1, getUserInput());
				pstmt.setInt(2, result);
				pstmt.setInt(3, 1); // 1 - "문제없이 데이터를 전송했다"
				pstmt.setString(4, request.getRemoteAddr());
			}

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}

	}

	public void excuteSelectBeforeInsertToMovieInfo() {

		pstmt = null;
		try {
			Set<Entry<String, MovieInfo>> set = getMovieInfo().entrySet();
			for (Map.Entry<String, MovieInfo> element : set) {

				String key = element.getKey();

				pstmt = getCon().prepareStatement(selectBeforeInsertMovieSql());

				pstmt.setString(1, key);

				rs = pstmt.executeQuery();

				if (rs.next() != true) {

					excuteInsertAfterSelectToMovieInfo(key);
				} else {

//					System.out.println("중복된 데이터");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}

	}

	public void excuteInsertAfterSelectToMovieInfo(String key) {
		pstmt = null;
		try {
			String movieTitle = getMovieInfo().get(key).getMovieNm();
			String movieTitleEn = getMovieInfo().get(key).getMovieNmEn();
			String prdtYear = getMovieInfo().get(key).getPrdtYear();
			String movieopenDt = getMovieInfo().get(key).getOpenDt();
			String nationAlt = getMovieInfo().get(key).getNationAlt();
			String genreAlt = getMovieInfo().get(key).getGenreAlt();
			String imgUrl = getMovieInfo().get(key).getImgUrl();

			pstmt = getCon().prepareStatement(insertAfterSelectMovieSql());
			pstmt.setString(1, key);
			pstmt.setString(2, movieTitle);
			pstmt.setString(3, movieTitleEn);
			pstmt.setString(4, prdtYear);
			pstmt.setString(5, movieopenDt);
			pstmt.setString(6, nationAlt);
			pstmt.setString(7, genreAlt);
			pstmt.setString(8, imgUrl);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public void excuteSelectBeforeInsertToPeopleInfo() {

		pstmt = null;
		try {
			for (int i = 0; i < getMoviePeoInfo().size(); i++) {
				for (int j = 0; j < getMoviePeoInfo().get(i).size(); j++) {

					pstmt = getCon().prepareStatement(selectBeforInsertPeoSql());
					pstmt.setString(1, getMoviePeoInfo().get(i).get(j).getPeoCd());
					pstmt.setString(2, getMoviePeoInfo().get(i).get(j).getMovieCd());

					rs = pstmt.executeQuery();

					if (rs.next() != true) {
						excuteInsertAfterSelectToPeopleInfo(getMoviePeoInfo().get(i).get(j));
					} else {
//						System.out.println("중복된 데이터");
					}

				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}

	}

	public void excuteInsertAfterSelectToPeopleInfo(MoviePeoInfo moviePeoInfo) {
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(insertAfterSelectPeoSql());
			pstmt.setString(1, moviePeoInfo.getPeoCd());
			pstmt.setString(2, moviePeoInfo.getPeopleNm());
			pstmt.setString(3, moviePeoInfo.getPeopleNmEn());
			pstmt.setString(4, moviePeoInfo.getMovieNm());
			pstmt.setString(5, moviePeoInfo.getMovieCd());
			pstmt.setString(6, moviePeoInfo.getMoviePartNm());
			pstmt.setString(7, moviePeoInfo.getImgUrl());
			pstmt.setString(8, moviePeoInfo.getPeoImgUrl());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public ArrayList<ReturnInfo> excuteSelectFromMovieInfoTableMovieCdSql(String userInput) {
		ArrayList<ReturnInfo> returnArrForMovieInfo = new ArrayList<>();
		pstmt = null;

		try {
			pstmt = getCon().prepareStatement(selectFromMovieInfoTableMovieCdSql());
			pstmt.setString(1, "%" + userInput + "%");
			pstmt.setString(2, "%" + userInput + "%");

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReturnInfo returnInfo = new ReturnInfo();
				returnInfo.setMovieCd(rs.getString("movieCd"));
				returnInfo.setMovieNm(rs.getString("movieNm"));
				returnInfo.setImgUrl(rs.getString("imgUrl"));
				returnArrForMovieInfo.add(returnInfo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return returnArrForMovieInfo;
	}

	public ArrayList<ReturnInfo> excuteSelectFromPeopleInfoTableMovieCdSql(String userInput) {
		ArrayList<ReturnInfo> returnArrForPeopleInfo = new ArrayList<>();
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectFromPeopleInfoTableMovieCdSql());
			pstmt.setString(1, "%" + userInput + "%");
			pstmt.setString(2, "%" + userInput + "%");

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReturnInfo returnInfo = new ReturnInfo();
				returnInfo.setMovieCd(rs.getString("movieCd"));
				returnInfo.setMovieNm(rs.getString("movieNm"));
				returnInfo.setImgUrl(rs.getString("imgUrl"));
				returnArrForPeopleInfo.add(returnInfo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return returnArrForPeopleInfo;
	}

	public String excuteSelectFromMovieInfoTableForImgUrlSql() {
		String imgUrl = "";
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectFromMovieInfoTableForImgUrlSql());
			pstmt.setString(1, "%" + getMovieMoreInfo().getMovieCd() + "%");

			rs = pstmt.executeQuery();

			while (rs.next()) {
				imgUrl = rs.getString("imgUrl");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return imgUrl;
	}

	public String excuteSelectFromPeopleInfoTableForImgUrlSql() {
		String imgUrl = "";
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectFromPeopleInfoTableForImgUrlSql());
			pstmt.setString(1, "%" + getMovieMoreInfo().getMovieCd() + "%");

			rs = pstmt.executeQuery();

			while (rs.next()) {
				imgUrl = rs.getString("imgUrl");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return imgUrl;
	}

	public void excuteSelectFromMovieMoreInfoTableBeforeInsertSql() {
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectFromMovieMoreInfoTableBeforeInsertSql());
			pstmt.setString(1, "%" + getMovieMoreInfo().getMovieCd() + "%");

			rs = pstmt.executeQuery();

			if (rs.next() != true) {
				excuteInsertMovieMoreInfoTableAfterSelectSql();
			} else {
//				System.out.println("중복된 데이터");
				excuteUpdateHitsAtMovieMoreInfoTableSql();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public void excuteUpdateHitsAtMovieMoreInfoTableSql() {
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(updateHitsAtMovieMoreInfoTableSql());
			pstmt.setString(1, getMovieMoreInfo().getMovieCd());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public void excuteInsertMovieMoreInfoTableAfterSelectSql() {
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(insertMovieMoreInfoTableAfterSelectSql());
			pstmt.setString(1, getMovieMoreInfo().getMovieCd());
			pstmt.setString(2, getMovieMoreInfo().getMovieNm());
			pstmt.setString(3, getMovieMoreInfo().getMovieNmEn());
			pstmt.setString(4, getMovieMoreInfo().getPrdtYear());
			pstmt.setString(5, getMovieMoreInfo().getOpenDt());
			pstmt.setString(6, getMovieMoreInfo().getShowTm());
			pstmt.setString(7, getMovieMoreInfo().getImgUrl());
			
			pstmt.executeUpdate();

			excuteInsertNationsMovieMoreInfoTableAfterSelectSql();
			excuteInsertGenresMovieMoreInfoTableAfterSelectSql();
			excuteInsertDirectorsMovieMoreInfoTableAfterSelectSql();
			excuteInsertActorsMovieMoreInfoTableAfterSelectSql();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public void excuteInsertNationsMovieMoreInfoTableAfterSelectSql() {
		pstmt = null;
		try {
			for (int i = 0; i < getMovieMoreInfo().getNations().size(); i++) {
				pstmt = getCon().prepareStatement(insertNationsMovieMoreInfoTableAfterSelectSql());
				pstmt.setString(1, getMovieMoreInfo().getMovieCd());
				pstmt.setString(2, getMovieMoreInfo().getNations().get(i).getNationNm());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public void excuteInsertGenresMovieMoreInfoTableAfterSelectSql() {
		pstmt = null;
		try {
			for (int i = 0; i < getMovieMoreInfo().getGenres().size(); i++) {
				pstmt = getCon().prepareStatement(insertGenresMovieMoreInfoTableAfterSelectSql());
				pstmt.setString(1, getMovieMoreInfo().getMovieCd());
				pstmt.setString(2, getMovieMoreInfo().getGenres().get(i).getGenreNm());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public void excuteInsertDirectorsMovieMoreInfoTableAfterSelectSql() {
		pstmt = null;
		try {
			for (int i = 0; i < getMovieMoreInfo().getDirectors().size(); i++) {
				pstmt = getCon().prepareStatement(insertDirectorsMovieMoreInfoTableAfterSelectSql());
				pstmt.setString(1, getMovieMoreInfo().getMovieCd());
				pstmt.setString(2, getMovieMoreInfo().getDirectors().get(i).getPeopleNm());
				pstmt.setString(3, getMovieMoreInfo().getDirectors().get(i).getPeopleNmEn());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public void excuteInsertActorsMovieMoreInfoTableAfterSelectSql() {
		pstmt = null;
		try {
			for (int i = 0; i < getMovieMoreInfo().getActors().size(); i++) {
				pstmt = getCon().prepareStatement(insertActorsMovieMoreInfoTableAfterSelectSql());
				pstmt.setString(1, getMovieMoreInfo().getMovieCd());
				pstmt.setString(2, getMovieMoreInfo().getActors().get(i).getPeopleNm());
				pstmt.setString(3, getMovieMoreInfo().getActors().get(i).getPeopleNmEn());
				pstmt.setString(4, getMovieMoreInfo().getActors().get(i).getCast());
				pstmt.setString(5, getMovieMoreInfo().getActors().get(i).getCastEn());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public boolean excuteSelectBeforInsertWishListSql(String movieCd, String mem_idx, String mem_userid) {
		boolean dbCheck = false;
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectBeforInsertWishListSql());
			pstmt.setString(1, movieCd);
			pstmt.setString(2, mem_idx);

			rs = pstmt.executeQuery();

			if (rs.next() != true) {
				excuteInsertWishListAfterSelectSql(movieCd, mem_idx, mem_userid);
			} else {
//				System.out.println("중복된 데이터");
				dbCheck = true;

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return dbCheck;
	}

	public void excuteInsertWishListAfterSelectSql(String movieCd, String mem_idx, String mem_userid) {
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(insertWishListAfterSelectSql());
			pstmt.setString(1, movieCd);
			pstmt.setString(2, mem_idx);
			pstmt.setString(3, mem_userid);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public ArrayList<String> excuteSelectMovieCdOnWishListSql(String mem_idx, String mem_userid) {
		ArrayList<String> arrForMovieCd = new ArrayList<>();
		String movieCd = "";
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectMovieCdOnWishListSql());
			pstmt.setString(1, mem_idx);
			pstmt.setString(2, mem_userid);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				movieCd = rs.getString("movieCd");
				arrForMovieCd.add(movieCd);
			}
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return arrForMovieCd;
	}

	public MovieMoreInfo excuteSelectMovieInfoToMakeWishlistSql(String movieCd) {

		MovieMoreInfo movieMoreInfo = new MovieMoreInfo();
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectMovieInfoToMakeWishlistSql());
			pstmt.setString(1, movieCd);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				movieMoreInfo = new MovieMoreInfo();
				movieMoreInfo.setMovieCd(rs.getString("movieCd"));
				movieMoreInfo.setMovieNm(rs.getString("movieNm"));
				movieMoreInfo.setMovieNmEn(rs.getString("movieNmEn"));
				movieMoreInfo.setImgUrl(rs.getString("imgUrl"));
				movieMoreInfo.setPrdtYear(rs.getString("moviePrdtYear"));
				movieMoreInfo.setShowTm(rs.getString("movieShowTm"));
			}
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return movieMoreInfo;
	}

	public int excuteSelectCountMovieInfoDataForPagingSearchResultMoreSql() {
		int listTotal = 0;
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectCountMovieInfoDataForPagingSearchResultMoreSql());
			pstmt.setString(1, '%' + getUserInput() + '%');
			pstmt.setString(2, '%' + getUserInput() + '%');

			rs = pstmt.executeQuery();
			while (rs.next()) {
				listTotal = rs.getInt("count(movieCd)");

			}
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return listTotal;
	}

	public int excuteSelectCountPeopleInfoDataForPagingSearchResultMoreSql() {
		int listTotal = 0;
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectCountPeopleInfoDataForPagingSearchResultMoreSql());
			pstmt.setString(1, '%' + getUserInput() + '%');
			pstmt.setString(2, '%' + getUserInput() + '%');

			rs = pstmt.executeQuery();
			while (rs.next()) {
				listTotal = rs.getInt("count(movieCd)");

			}
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return listTotal;
	}

	public ArrayList<ReturnInfo> excuteSelectMovieInfoDataForSearchResultMoreSql(String nowPage) {
		ArrayList<ReturnInfo> returnArr = new ArrayList<>();
		int startIdx = Integer.parseInt(nowPage) * 5;
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectMovieInfoDataForSearchResultMoreSql());
			pstmt.setString(1, "%" + userInput + "%");
			pstmt.setString(2, "%" + userInput + "%");

			if (!nowPage.equals("1")) {
				pstmt.setInt(3, startIdx);
				pstmt.setInt(4, 5);
			} else if (nowPage.equals("1")) {
				pstmt.setInt(3, 0);
				pstmt.setInt(4, 10);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReturnInfo returnInfo = new ReturnInfo();
				returnInfo.setMovieCd(rs.getString("movieCd"));
				returnInfo.setMovieNm(rs.getString("movieNm"));
				returnInfo.setImgUrl(rs.getString("imgUrl"));
				returnArr.add(returnInfo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return returnArr;
	}

	public ArrayList<ReturnInfo> excuteSelectPeopleInfoDataForSearchResultMoreSql(String nowPage) {
		ArrayList<ReturnInfo> returnArr = new ArrayList<>();
		int startIdx = Integer.parseInt(nowPage) * 5;
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(selectPeopleInfoDataForSearchResultMoreSql());
			pstmt.setString(1, "%" + userInput + "%");
			pstmt.setString(2, "%" + userInput + "%");
			if (!nowPage.equals("1")) {
				pstmt.setInt(3, startIdx);
				pstmt.setInt(4, 5);

			} else if (nowPage.equals("1")) {
				pstmt.setInt(3, 0);
				pstmt.setInt(4, 10);
			}
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReturnInfo returnInfo = new ReturnInfo();
				returnInfo.setMovieCd(rs.getString("movieCd"));
				returnInfo.setMovieNm(rs.getString("movieNm"));
				returnInfo.setImgUrl(rs.getString("imgUrl"));
				returnArr.add(returnInfo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return returnArr;
	}

///////////////////////////////////////////////////////////////////////////////////

	//
	public int excuteSelectStarScoreToGetSql(String ss_movieCd, String ss_mem_idx) {
		int starScore = 0;
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectStarScoreBeforInsertSql());
			pstmt.setString(1, ss_movieCd);
			pstmt.setInt(2, Integer.parseInt(ss_mem_idx));

			rs = pstmt.executeQuery();

			while (rs.next()) {
				starScore = rs.getInt("ss_score");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return starScore;
	}

	public void excuteSelectStarScoreBeforInsertSql(String ss_movieCd, String ss_mem_idx, String ss_score) {
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectStarScoreBeforInsertSql());
			pstmt.setString(1, ss_movieCd);
			pstmt.setInt(2, Integer.parseInt(ss_mem_idx));

			rs = pstmt.executeQuery();

			if (rs.next() != true) {
				excuteInsertStarScoreAfterSelectSql(ss_movieCd, ss_mem_idx, ss_score);
			} else {
//				System.out.println("중복된 데이터");
				excuteUpdateStarScoreSql(ss_movieCd, ss_mem_idx, ss_score);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	// 과거에 평점을 준 영화라면 다시 평점을 매길 수 있다.
	public void excuteUpdateStarScoreSql(String ss_movieCd, String ss_mem_idx, String ss_score) {
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(updateStarScoreSql());
			pstmt.setInt(1, Integer.parseInt(ss_score));
			pstmt.setString(2, ss_movieCd);
			pstmt.setInt(3, Integer.parseInt(ss_mem_idx));

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	// 과거에 평점을 주지 않은 영화라면 평점을 매길 수 있다.
	public void excuteInsertStarScoreAfterSelectSql(String ss_movieCd, String ss_mem_idx, String ss_score) {
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(insertStarScoreAfterSelectSql());
			pstmt.setString(1, ss_movieCd);
			pstmt.setInt(2, Integer.parseInt(ss_mem_idx));
			pstmt.setInt(3, Integer.parseInt(ss_score));

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

	public int excuteSelectTotalCountStarScoreSql() {
		int totalCountStarScore = 0;
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectTotalCountStarScoreSql());
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				totalCountStarScore = rs.getInt("count(ss_movieCd)");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}

		return totalCountStarScore;
	}
	
	public ArrayList<MovieMoreInfo> excuteSelectStarScoreToGetMovieCdAndScoreSql(String mem_idx) {
		ArrayList<MovieMoreInfo> arrForMovieCdAndStarScore = new ArrayList<>();
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectStarScoreToGetMovieCdAndScoreSql());
			pstmt.setString(1, mem_idx);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MovieMoreInfo movieMoreInfo = new MovieMoreInfo();
				movieMoreInfo.setMovieCd(rs.getString("ss_movieCd"));
				movieMoreInfo.setStarScore(rs.getString("ss_score"));

				arrForMovieCdAndStarScore.add(movieMoreInfo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return arrForMovieCdAndStarScore;
	}
	
	public MovieMoreInfo excuteSelectStarScoreListWithMovieCdSql(String movieCd, String starScore) {
		MovieMoreInfo movieMoreInfo = new MovieMoreInfo();
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectStarScoreListWithMovieCdSql());
			pstmt.setString(1, movieCd);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				movieMoreInfo = new MovieMoreInfo();
				movieMoreInfo.setMovieCd(rs.getString("movieCd"));
				movieMoreInfo.setMovieNm(rs.getString("movieNm"));
				movieMoreInfo.setMovieNmEn(rs.getString("movieNmEn"));
				movieMoreInfo.setPrdtYear(rs.getString("moviePrdtYear"));
				movieMoreInfo.setImgUrl(rs.getString("imgUrl"));
				movieMoreInfo.setStarScore(starScore);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return movieMoreInfo;
	}

	public ArrayList<DirectorsMovieMoreInfo> excuteSelectDirectorMoreFromDirectorMoreInfo(String movieCd) {
		ArrayList<DirectorsMovieMoreInfo> arrForReturnDirectors = new ArrayList<>();
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectDirectorMoreFromDirectorMoreInfo());
			pstmt.setString(1, movieCd);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				DirectorsMovieMoreInfo directorsMovieMoreInfo = new DirectorsMovieMoreInfo();
				directorsMovieMoreInfo.setPeopleNm(rs.getString("drPeopleNm"));
				directorsMovieMoreInfo.setPeopleNmEn(rs.getString("drPeopleNmEn"));

				arrForReturnDirectors.add(directorsMovieMoreInfo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return arrForReturnDirectors;
	}

	public ArrayList<ActorsMovieMoreInfo> excuteSelectActorMoreFromActorsMoreInfo(String movieCd) {
		ArrayList<ActorsMovieMoreInfo> arrForReturnActors = new ArrayList<>();
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectActorMoreFromActorsMoreInfo());
			pstmt.setString(1, movieCd);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActorsMovieMoreInfo actorsMovieMoreInfo = new ActorsMovieMoreInfo();
				actorsMovieMoreInfo.setPeopleNm(rs.getString("acPeopleNm"));
				actorsMovieMoreInfo.setPeopleNmEn(rs.getString("acPeopleNmEn"));
				actorsMovieMoreInfo.setCast(rs.getString("castNm"));
				actorsMovieMoreInfo.setCastEn(rs.getString("castNmEn"));

				arrForReturnActors.add(actorsMovieMoreInfo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return arrForReturnActors;
	}

}
