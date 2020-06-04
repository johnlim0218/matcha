package dataBase;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Crawler {

	private String naverImgUrl;
	private String naverImgForPeoUrl;
	private String nullImgUrl;

	private String responsedKobis;
	private String responsedKobisEn;
	private String responsedPrdtYear;
	private String responsedNationAlt;
	private String responsedDirectorActorNm;

	private String responsedKobisForPeople;

	public String getNaverImgUrl() {
		naverImgUrl = "https://movie.naver.com/movie/search/result.nhn?section=movie&query=" + getResponsedKobis()
				+ "&section=all&ie=utf8";

		return naverImgUrl;
	}

	public String getNaverImgForPeoUrl() {
		naverImgForPeoUrl = "https://movie.naver.com/movie/search/result.nhn?section=people&query="
				+ getResponsedKobisForPeople() + "&section=all&ie=utf8";
		return naverImgForPeoUrl;
	}

	public String getNullImgUrl() {
		return nullImgUrl = "https://ssl.pstatic.net/static/movie/2012/06/dft_img203x290.png";
	}

	public String getResponsedKobis() {
		return responsedKobis.replaceAll(" ", "");
	}

	public void setResponsedKobis(String responsedKobis) {
		this.responsedKobis = responsedKobis;
	}

	public String getResponsedKobisEn() {
		return responsedKobisEn.replaceAll(" ", "");
	}

	public void setResponsedKobisEn(String responsedKobisEn) {
		this.responsedKobisEn = responsedKobisEn;
	}

	public String getResponsedPrdtYear() {
		return responsedPrdtYear;
	}

	public void setResponsedPrdtYear(String responsedPrdtYear) {
		this.responsedPrdtYear = responsedPrdtYear;
	}

	public String getResponsedNationAlt() {
		return responsedNationAlt;
	}

	public void setResponsedNationAlt(String responsedNationAlt) {
		this.responsedNationAlt = responsedNationAlt;
	}

	public String getResponsedDirectorActorNm() {
		return responsedDirectorActorNm.replaceAll(" ", "");
	}

	public void setResponsedDirectorActorNm(String responsedDirectorActorNm) {
		this.responsedDirectorActorNm = responsedDirectorActorNm;
	}

	public String getResponsedKobisForPeople() {
		return responsedKobisForPeople.replaceAll(" ", "");
	}

	public void setResponsedKobisForPeople(String responsedKobisForPeople) {
		this.responsedKobisForPeople = responsedKobisForPeople;
	}

	public String crawlerForImg() {
		ArrayList<String> test = new ArrayList<>();
		String naverMovieCode = "";
		String naverMoviePosterUrl = "";

		String naverPosterUrl = ""; // 포스터가 있는 최종 URL
									// 포스터가 없는 영화의 경우 getNullPosterImgUrl()

		try {
			String url = getNaverImgUrl();

			Document doc = null; // xml이나 html로 문서화된 것을 트리화 시켜 저장시켜주는 클래스

			doc = Jsoup.connect(url).get(); // 사이트에 접속시켜주는 메소드
			// 나중에 다시 설명

			Elements elements = doc.select("ul.search_list_1");

			if (elements.size() > 0) {
				Element element = elements.get(0);
				Elements elementsForliTag = element.getElementsByTag("li");

				// 네이버 영화 검색결과가 2건 이상일 경우
				if (elementsForliTag.size() > 1) {
					for (int i = 0; i < elementsForliTag.size(); i++) {
						Element elementForddTag = elementsForliTag.get(i).getElementsByTag("dd").get(2);
						Elements elementsForaTag = elementForddTag.getElementsByTag("a");

						if (naverPosterUrl.equals("") || naverPosterUrl.equals(getNullImgUrl())) {
							if (elementsForaTag.text().replaceAll(" ", "").contains(getResponsedDirectorActorNm())) {
								if (elementsForaTag.size() != 0) {
									naverPosterUrl = crawlerForMoviePoster(doc, elementsForaTag);
								} else {
									naverPosterUrl = getNullImgUrl();
								}
							} else {
								naverPosterUrl = getNullImgUrl();
							}
						}
					}
					// 네이버 영화 검색결과가 1건 일 경우
				} else if (elementsForliTag.size() == 1) {
					Element elementForddTag = elementsForliTag.get(0).getElementsByTag("dd").get(2);
					Elements elementsForaTag = elementForddTag.getElementsByTag("a");
					
					if (elementsForaTag.size() != 0) {
						naverPosterUrl = crawlerForMoviePoster(doc, elementsForaTag);
					} else {
						naverPosterUrl = getNullImgUrl();
					}
				}
				// 네이버 영화 검색결과가 없을 경우
			} else {
				naverPosterUrl = getNullImgUrl();
			}
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return naverPosterUrl;
	}

	public String crawlerForMoviePoster(Document doc, Elements elementsForaTag) {
		String naverPosterUrl = "";
		try {

			String naverMovieUrl = elementsForaTag.get(0).parent().parent().child(0).child(0)
					.getElementsByAttribute("href").attr("href");
			String naverMovieCode = naverMovieUrl.substring(28, naverMovieUrl.length());
			String naverMoviePosterUrl = "https://movie.naver.com/movie/bi/mi/photoViewPopup.nhn?movieCode="
					+ naverMovieCode;

			doc = Jsoup.connect(naverMoviePosterUrl).get();

			Element elementPost = doc.select("#targetImage").first();

			if (elementPost == null) {
				naverPosterUrl = getNullImgUrl();
			} else {
				naverPosterUrl = elementPost.getElementsByAttribute("src").attr("src");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return naverPosterUrl;
	}

	public String crawlerForPeopleImg() {

		String naverMoviePeopleUrl = "";

		try {
			String url = getNaverImgForPeoUrl();

			Document doc = null; // xml이나 html로 문서화된 것을 트리화 시켜 저장시켜주는 클래스

			doc = Jsoup.connect(url).get(); // 사이트에 접속시켜주는 메소드
			// 나중에 다시 설명

			Element element1 = doc.select("ul.search_list_1>li>dl>dt").first();

			if (element1 == null) {

				naverMoviePeopleUrl = getNullImgUrl();

			} else {
				for (Element element : element1.select("a")) {
					naverMoviePeopleUrl = element.getElementsByAttribute("href").attr("href");

					naverMoviePeopleUrl = "https://movie.naver.com" + naverMoviePeopleUrl;

					doc = Jsoup.connect(naverMoviePeopleUrl).get();
					Element elementPeople = doc.select("div.poster>img").first();

					if (elementPeople == null) {
						naverMoviePeopleUrl = getNullImgUrl();
					} else {
						naverMoviePeopleUrl = elementPeople.getElementsByAttribute("src").attr("src");

						if (naverMoviePeopleUrl.indexOf("&") != -1) {
							naverMoviePeopleUrl = naverMoviePeopleUrl.substring(0, naverMoviePeopleUrl.indexOf("&"));
						}
					}

				}
			}
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return naverMoviePeopleUrl;
	}
}
