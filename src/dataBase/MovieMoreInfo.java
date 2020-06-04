package dataBase;

import java.util.ArrayList;

public class MovieMoreInfo {
		
		private String movieCd;
		private String movieNm;
		private String movieNmEn;
		
		private String prdtYear;
		private String openDt;
		private String showTm;
		private ArrayList<NationsMovieMoreInfo> nations;
		private ArrayList<GenresMovieMoreInfo> genres;
		private ArrayList<DirectorsMovieMoreInfo> directors;
		private ArrayList<ActorsMovieMoreInfo> actors;
		
		private String imgUrl;
		private String starScore;
		
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
		public String getShowTm() {
			return showTm;
		}
		public void setShowTm(String showTm) {
			this.showTm = showTm;
		}
		public ArrayList<NationsMovieMoreInfo> getNations() {
			return nations;
		}
		public void setNations(ArrayList<NationsMovieMoreInfo> nations) {
			this.nations = nations;
		}
		public ArrayList<GenresMovieMoreInfo> getGenres() {
			return genres;
		}
		public void setGenres(ArrayList<GenresMovieMoreInfo> genres) {
			this.genres = genres;
		}
		public ArrayList<DirectorsMovieMoreInfo> getDirectors() {
			return directors;
		}
		public void setDirectors(ArrayList<DirectorsMovieMoreInfo> directors) {
			this.directors = directors;
		}
		public ArrayList<ActorsMovieMoreInfo> getActors() {
			return actors;
		}
		public void setActors(ArrayList<ActorsMovieMoreInfo> actors) {
			this.actors = actors;
		}
		public String getImgUrl() {
			return imgUrl;
		}
		public void setImgUrl(String imgUrl) {
			this.imgUrl = imgUrl;
		}
		public String getStarScore() {
			return starScore;
		}
		public void setStarScore(String starScore) {
			this.starScore = starScore;
		}
		
}
