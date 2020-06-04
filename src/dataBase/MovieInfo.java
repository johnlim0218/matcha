package dataBase;

import java.util.ArrayList;

public class MovieInfo {
	
	String movieCd;	// 영진위용 영화코드
	String movieNm;
	String movieNmEn;
	String prdtYear;
	String openDt;
	String nationAlt;
	String genreAlt;
	ArrayList<String> directors;
	
	String imgUrl;
	
	public String getMovieCd() {
		return movieCd;
	}
	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}
	public String getMovieNm() {
		return movieNm;
	}
	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}
	public String getMovieNmEn() {
		return movieNmEn;
	}
	public void setMovieNmEn(String movieNmEn) {
		this.movieNmEn = movieNmEn;
	}
	public String getPrdtYear() {
		return prdtYear;
	}
	public void setPrdtYear(String prdtYear) {
		this.prdtYear = prdtYear;
	}
	public String getOpenDt() {
		return openDt;
	}
	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}
	public String getNationAlt() {
		return nationAlt;
	}
	public void setNationAlt(String nationAlt) {
		this.nationAlt = nationAlt;
	}
	public String getGenreAlt() {
		return genreAlt;
	}
	public void setGenreAlt(String genreAlt) {
		this.genreAlt = genreAlt;
	}
	public ArrayList<String> getDirectors() {
		return directors;
	}
	public void setDirectors(ArrayList<String> directors) {
		this.directors = directors;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
		
}
