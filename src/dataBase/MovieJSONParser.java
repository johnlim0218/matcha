package dataBase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class MovieJSONParser {
	private JSONParser parser;
	private Object objResponsed;
	private JSONObject jsonObject;
	private JSONArray jsonArray;

	// 영화제목, 영화인 JSON응답(파싱 전)
	private String responsed;
	// 영화제목, 영화인 이미지주소 JSON응답(파싱 전)
	private String responsedImg;

	// DataHandler로 되돌려줄 데이터리스트(영진위)
	HashMap<String, MovieInfo> returnMapFromKobis = new HashMap<>();
	ArrayList<MoviePeoInfo> arrForPeoInfoFromKobis = new ArrayList<>();

	MovieInfo movieInfo;
	ArrayList<String> directors;
	
	MoviePeoInfo moviePeoInfo;

	public String getResponsed() {
		return responsed;
	}

	public void setResponsed(String responsed) {
		this.responsed = responsed;
	}

	public String getResponsedImg() {
		return responsedImg;
	}

	public void setResponsedImg(String responsedImg) {
		this.responsedImg = responsedImg;
	}

	public HashMap<String, MovieInfo> getReturnMapFromKobis() {
		return returnMapFromKobis;
	}

	public void setReturnMapFromKobis(HashMap<String, MovieInfo> returnMapFromKobis) {
		this.returnMapFromKobis = returnMapFromKobis;
	}

	public ArrayList<MoviePeoInfo> getReturnPeoMapFromKobis() {
		return arrForPeoInfoFromKobis;
	}

	public void setReturnPeoMapFromKobis(ArrayList<MoviePeoInfo> returnPeoMapFromKobis) {
		this.arrForPeoInfoFromKobis = returnPeoMapFromKobis;
	}

	// 영진위 영화검색 JSON Parser
	public HashMap<String, MovieInfo> KobisMovieJSONParser() {
		returnMapFromKobis = new HashMap<>();
		
		parser = new JSONParser();
		try {
			objResponsed = parser.parse(getResponsed());
			jsonObject = (JSONObject) objResponsed;
			jsonObject = (JSONObject) jsonObject.get("movieListResult");

			JSONArray arrayForMovieList = (JSONArray) jsonObject.get("movieList");

			for (int i = 0; i < arrayForMovieList.size(); i++) {
				jsonObject = (JSONObject) arrayForMovieList.get(i);

				movieInfo = new MovieInfo();
				movieInfo.setMovieCd((String) jsonObject.get("movieCd"));
				movieInfo.setMovieNm((String) jsonObject.get("movieNm"));
				movieInfo.setMovieNmEn((String) jsonObject.get("movieNmEn"));
				movieInfo.setPrdtYear((String) jsonObject.get("prdtYear"));
				movieInfo.setOpenDt((String) jsonObject.get("openDt"));
				movieInfo.setNationAlt((String) jsonObject.get("nationAlt"));
				movieInfo.setGenreAlt((String) jsonObject.get("genreAlt"));
				
				

				directors = new ArrayList<>();
				
				JSONArray arrayForDirectors = (JSONArray) jsonObject.get("directors");
				if (arrayForDirectors.size() > 0) {

					for (int j = 0; j < arrayForDirectors.size(); j++) {
						JSONObject jsonObject2 = (JSONObject) arrayForDirectors.get(j);
						directors.add((String) jsonObject2.get("peopleNm"));
					}
				} else {
					directors.add("");
				}
				movieInfo.setDirectors(directors);
				
				if(!((String)jsonObject.get("prdtStatNm")).equals("기타")) {
				returnMapFromKobis.put(movieInfo.getMovieCd(), movieInfo);
				}
				
			}
			setReturnMapFromKobis(returnMapFromKobis);
		} catch (ParseException e) {

			e.printStackTrace();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return getReturnMapFromKobis();

	}
	
	// 인물리스트 JSON에서 peopleCd와 filmoNames를 빼내는 메소드
	public ArrayList<MoviePeoInfo> KobisPeoJSONParserForPeopleList() {
		ArrayList<MoviePeoInfo> arrForPeopleList = new ArrayList<>();
		MoviePeoInfo moviePeoInfo = new MoviePeoInfo();
		parser = new JSONParser();
		try {
			objResponsed = parser.parse(getResponsed());
			jsonObject = (JSONObject) objResponsed;
			jsonObject = (JSONObject) jsonObject.get("peopleListResult");
			
			JSONArray arrayForPeopleList = (JSONArray) jsonObject.get("peopleList");
			
			for(int i = 0; i < arrayForPeopleList.size(); i++) {
				jsonObject = (JSONObject)arrayForPeopleList.get(i);
				moviePeoInfo = new MoviePeoInfo();
				moviePeoInfo.setPeoCd((String) jsonObject.get("peopleCd"));
				moviePeoInfo.setFilmoNames((String) jsonObject.get("filmoNames"));
				arrForPeopleList.add(moviePeoInfo);
			}
			
		} catch (ParseException e) {

			e.printStackTrace();
		} catch (Exception e) {

			e.printStackTrace();
		}

		return arrForPeopleList;
	}

	// 영진위 영화인검색 JSON Parser(영화인 코드 이용)
	public ArrayList<MoviePeoInfo> KobisPeoJSONParser() {
		
		
		arrForPeoInfoFromKobis = new ArrayList<>();
		parser = new JSONParser();
		try {
			objResponsed = parser.parse(getResponsed());
			jsonObject = (JSONObject) objResponsed;
			jsonObject = (JSONObject) jsonObject.get("peopleInfoResult");
			jsonObject = (JSONObject) jsonObject.get("peopleInfo");
			JSONArray arrayForPeople = (JSONArray) jsonObject.get("filmos");
			
			for(int i = 0; i < arrayForPeople.size(); i++) {
				moviePeoInfo = new MoviePeoInfo();
				moviePeoInfo.setPeoCd((String)jsonObject.get("peopleCd"));
				moviePeoInfo.setPeopleNm((String)jsonObject.get("peopleNm"));
				moviePeoInfo.setPeopleNmEn((String)jsonObject.get("peopleNmEn"));
				
				JSONObject jsonObjectForArray = (JSONObject)arrayForPeople.get(i);
				moviePeoInfo.setMovieNm((String)jsonObjectForArray.get("movieNm"));
				moviePeoInfo.setMovieCd((String)jsonObjectForArray.get("movieCd"));
				moviePeoInfo.setMoviePartNm((String)jsonObjectForArray.get("moviePartNm"));
//				System.out.println((String)jsonObjectForArray.get("movieNm"));
//				System.out.println((String)jsonObjectForArray.get("prdtStatNm"));
				arrForPeoInfoFromKobis.add(moviePeoInfo);
			}
			
			
		} catch (ParseException e) {

			e.printStackTrace();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return arrForPeoInfoFromKobis;
	}
	
	// 영화 상세정보 JSON Parser
	public MovieMoreInfo KobisMoreInfoJSONParser(){
		MovieMoreInfo movieMoreInfo = new MovieMoreInfo();
		NationsMovieMoreInfo nationsMovieMoreInfo = new NationsMovieMoreInfo();
		GenresMovieMoreInfo genresMovieMoreInfo = new GenresMovieMoreInfo();
		DirectorsMovieMoreInfo directorsMovieMoreInfo = new DirectorsMovieMoreInfo();
		ActorsMovieMoreInfo actorsMovieMoreInfo = new ActorsMovieMoreInfo();
		
		ArrayList<NationsMovieMoreInfo> arrForNation = new ArrayList<>();
		ArrayList<GenresMovieMoreInfo> arrForGenres = new ArrayList<>();
		ArrayList<DirectorsMovieMoreInfo> arrForDirectors = new ArrayList<>();
		ArrayList<ActorsMovieMoreInfo> arrForActors = new ArrayList<>();
		String movieCd = "";
		String movieNm = "";
		String movieNmEn = "";
		String prdtYear = "";
		String openDt = "";
		String showTm = "";
		
		parser = new JSONParser();
		try {
			objResponsed = parser.parse(getResponsed());
			jsonObject = (JSONObject) objResponsed;
			jsonObject = (JSONObject) jsonObject.get("movieInfoResult");
			jsonObject = (JSONObject) jsonObject.get("movieInfo");
			
			JSONArray arrayForNations = (JSONArray) jsonObject.get("nations");
			JSONArray arrayForGenres = (JSONArray) jsonObject.get("genres");
			JSONArray arrayForDirectorsList = (JSONArray) jsonObject.get("directors");
			JSONArray arrayForActorsList = (JSONArray) jsonObject.get("actors");
			
			movieCd = (String)jsonObject.get("movieCd");
			movieNm = (String)jsonObject.get("movieNm");
			movieNmEn = (String)jsonObject.get("movieNmEn");
			prdtYear = (String)jsonObject.get("prdtYear");
			openDt = (String)jsonObject.get("openDt");
			showTm = (String)jsonObject.get("showTm");
			
			
			for(int i = 0; i < arrayForNations.size(); i++) {
				String nationNm = "";
				
				JSONObject jsonObjectForArray = (JSONObject)arrayForNations.get(i);
				nationNm = (String)jsonObjectForArray.get("nationNm");
				
				nationsMovieMoreInfo = new NationsMovieMoreInfo();
				nationsMovieMoreInfo.setNationNm(nationNm);
				arrForNation.add(nationsMovieMoreInfo);
			}
			for(int i = 0; i < arrayForGenres.size(); i++) {
				String genreNm = "";
				
				JSONObject jsonObjectForArray = (JSONObject)arrayForGenres.get(i);
				genreNm = (String)jsonObjectForArray.get("genreNm");
				
				genresMovieMoreInfo = new GenresMovieMoreInfo();
				genresMovieMoreInfo.setGenreNm(genreNm);
				arrForGenres.add(genresMovieMoreInfo);
			}
			for(int i = 0; i < arrayForDirectorsList.size(); i++) {
				String peopleNm ="";
				String peopleNmEn ="";
				
				JSONObject jsonObjectForArray = (JSONObject)arrayForDirectorsList.get(i);
				peopleNm = (String)jsonObjectForArray.get("peopleNm");
				peopleNmEn = (String)jsonObjectForArray.get("peopleNmEn");
				
				directorsMovieMoreInfo = new DirectorsMovieMoreInfo();
				directorsMovieMoreInfo.setPeopleNm(peopleNm);
				directorsMovieMoreInfo.setPeopleNmEn(peopleNmEn);
				arrForDirectors.add(directorsMovieMoreInfo);
			}
			for(int i = 0; i < arrayForActorsList.size(); i++) {
				String peopleNm ="";
				String peopleNmEn ="";
				String cast ="";
				String castEn ="";
				
				JSONObject jsonObjectForArray = (JSONObject)arrayForActorsList.get(i);
				peopleNm = (String)jsonObjectForArray.get("peopleNm");
				peopleNmEn = (String)jsonObjectForArray.get("peopleNmEn");
				cast = (String)jsonObjectForArray.get("cast");
				castEn = (String)jsonObjectForArray.get("castEn");
				
				actorsMovieMoreInfo = new ActorsMovieMoreInfo();
				actorsMovieMoreInfo.setPeopleNm(peopleNm);
				actorsMovieMoreInfo.setPeopleNmEn(peopleNmEn);
				actorsMovieMoreInfo.setCast(cast);
				actorsMovieMoreInfo.setCastEn(castEn);
				arrForActors.add(actorsMovieMoreInfo);
			}
			movieMoreInfo.setMovieCd(movieCd);
			movieMoreInfo.setMovieNm(movieNm);
			movieMoreInfo.setMovieNmEn(movieNmEn);
			movieMoreInfo.setPrdtYear(prdtYear);
			movieMoreInfo.setOpenDt(openDt);
			movieMoreInfo.setShowTm(showTm);
			movieMoreInfo.setNations(arrForNation);
			movieMoreInfo.setGenres(arrForGenres);
			movieMoreInfo.setDirectors(arrForDirectors);
			movieMoreInfo.setActors(arrForActors);
			
		} catch (ParseException e) {

			e.printStackTrace();
		} catch (Exception e) {

			e.printStackTrace();
		}
		
		return movieMoreInfo;
	}
}
