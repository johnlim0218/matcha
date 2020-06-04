package dataBase;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class APIConnector {

	private String clientId = "";
	private String clientSecret = "";
	private String itemPerPage = "50";
	private String userInputText = "";
	private String userInput = "";
	private String movieTitleForSearchImg = "";
	private String movieTitleEnForSearchImg = "";
	private String peopleCd = "";
	private String movieCd = "";

	private String apiURL = "";

	public String getItemPerPage() {
		return itemPerPage;
	}

	public void setItemPerPage(String itemPerPage) {
		this.itemPerPage = itemPerPage;
	}

	public String getUserInput() {
		return userInput;
	}

	public void setUserInput(String userInput) {
		this.userInput = userInput;
	}

	public String getMovieTitleForSearchImg() {
		return movieTitleForSearchImg;
	}

	public void setMovieTitleForSearchImg(String movieTitleForSearchImg) {
		this.movieTitleForSearchImg = movieTitleForSearchImg;
	}

	public String getMovieTitleEnForSearchImg() {
		return movieTitleEnForSearchImg;
	}

	public void setMovieTitleEnForSearchImg(String movieTitleEnForSearchImg) {
		this.movieTitleEnForSearchImg = movieTitleEnForSearchImg;
	}

	public String getPeopleCd() {
		return peopleCd;
	}

	public void setPeopleCd(String peopleCd) {
		this.peopleCd = peopleCd;
	}

	public String getMovieCd() {
		return movieCd;
	}

	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}

	// 사용자 검색어 UTF-8 인코더
	public String getUserInputText() throws UnsupportedEncodingException {
		return userInputText = URLEncoder.encode(getUserInput(), "UTF-8");
	}

	// 영진위 API 클라이언트ID
	public String getkobisClientId() {
		return clientId = "8f0f072fbdc8e3d2fefb8a4694110e17";
	}

	// 네이버 API 클라이언트ID
	public String getNaverClientId() {
		return clientId = "7UNOK7IsDw2lCq3XtdDj";
	}

	// 네이버 API 시크릿값
	public String getNaverClientSecret() {
		return clientSecret = "T3eyw4lm_x";
	}

	// 영진위 영화제목 검색 URL
	public String getkobisConFilmAPIUrl() {
		try {
			apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key="
					+ getkobisClientId() + "&itemPerPage=" + getItemPerPage() + "&movieNm=" + getUserInputText();
		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();
		}
		return apiURL;
	}

	// 영진위 영화인리스트 검색 URL
	public String getkobisConPeoListAPIURL() {
		try {
			apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key="
					+ getkobisClientId() + "&itemPerPage=" + getItemPerPage() + "&peopleNm=" + getUserInputText();
		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();
		} // 영화인 검색
		return apiURL;
	}

	public String getKobisConPeoApiURL() {

		apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleInfo.json?key="
				+ getkobisClientId() + "&peopleCd=" + getPeopleCd();

		return apiURL;
	}

	public String getKobisConPeoMoreInfoApiUrl() {

		apiURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key="
				+ getkobisClientId() + "&movieCd=" + getMovieCd();

		return apiURL;
	}

	// 영진위에서 영화제목 검색
	public String kobisFilmCon() {

		String responsedString = "";
		try {
			URL url = new URL(getkobisConFilmAPIUrl());
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer responsed = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				responsed.append(inputLine);
			}
			br.close();
			responsedString = responsed.toString();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return responsedString;

	}

	// 영진위에서 영화인 검색
	public String kobisPeoListCon() {

		String responsedString = "";
		try {
			URL url = new URL(getkobisConPeoListAPIURL());
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer responsed = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				responsed.append(inputLine);
			}
			br.close();
			responsedString = responsed.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return responsedString;
	}

	public String kobisPeoCon() {

		String responsedString = "";
		try {
			URL url = new URL(getKobisConPeoApiURL());
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer responsed = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				responsed.append(inputLine);
			}
			br.close();
			responsedString = responsed.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return responsedString;
	}

	public String kobisMovieMoreInfoCon() {
		
		String responsedString = "";
		try {
			URL url = new URL(getKobisConPeoMoreInfoApiUrl());
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer responsed = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				responsed.append(inputLine);
			}
			br.close();
			responsedString = responsed.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return responsedString;
	}
}
