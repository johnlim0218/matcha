package dataBase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DBConnectorForWebsiteDB {
	private PreparedStatement pstmt;
	private Connection con;
	private String dbUrl = "";
	private String dbUser = "";
	private String dbPw = "";
	private String sql = "";
	private ResultSet rs;

	private String userInput;
	private String movieCd;

	DBConnectorForWebsiteDB() {
		setUpDBConnetor();
	}

	public String getUserInput() {
		return userInput;
	}

	public void setUserInput(String userInput) {
		this.userInput = userInput;
	}

	public String getMovieCd() {
		return movieCd;
	}

	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
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
		return dbUrl = "jdbc:mariadb://localhost:3306/website";
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

	public String selectUserInfoSql() {
		return sql = "select mem_idx, mem_userid,mem_name from member1 where mem_name like ?";
	}

	public String selectMovieArticleFromBoardTableSql() {
		return sql = "select b_idx, b_movieCd, b_name, b_title, b_content, b_likeit from board1 where b_movieCd = ?";
	}

	public String updateLikeitOnBoardTableSql() {
		return sql = "update board1 set b_likeit = b_likeit+1 where b_idx=?";
	}

	public String selectCommentsCountSql() {
		return sql = "select count(c_idx) from comment1 where c_boardidx = ?";
	}

	public ArrayList<ReturnUserInfo> excuteSelectUserInfoSql() {
		ArrayList<ReturnUserInfo> returnArrForUserInfo = new ArrayList<>();
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectUserInfoSql());
			pstmt.setString(1, "%" + getUserInput() + "%");
			rs = pstmt.executeQuery();

			if (rs.next() != true) {
				// 없다
			} else {
				// 있다
				ReturnUserInfo returnUserInfo = new ReturnUserInfo();
				returnUserInfo.setMem_idx(rs.getString("mem_idx"));
				returnUserInfo.setMem_userid(rs.getString("mem_userid"));
				returnUserInfo.setMem_name(rs.getString("mem_name"));
				returnArrForUserInfo.add(returnUserInfo);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return returnArrForUserInfo;
	}

	public ArrayList<ReturnBoard> excuteSelectMovieArticleFromBoardTableSql() {
		ArrayList<ReturnBoard> returnArrForMovieArticle = new ArrayList<>();
		int countOfComment = 0;
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectMovieArticleFromBoardTableSql());
			pstmt.setString(1, getMovieCd());
			rs = pstmt.executeQuery();

			if (rs.next() != true) {
				// 없다
			} else {
				// 있다
				ReturnBoard returnBoard = new ReturnBoard();
				returnBoard.setB_idx(rs.getInt("b_idx"));
				returnBoard.setB_movieCd(rs.getString("b_movieCd"));
				returnBoard.setB_name(rs.getString("b_name"));
				returnBoard.setB_title(rs.getString("b_title"));
				returnBoard.setB_content(rs.getString("b_content"));
				returnBoard.setB_likeit(rs.getInt("b_likeit"));
				returnBoard.setCountOfComment(excuteSelectCommentsCountSql(rs.getInt("b_idx")));

				returnArrForMovieArticle.add(returnBoard);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return returnArrForMovieArticle;
	}

	public int excuteSelectCommentsCountSql(int c_boardidx) {
		int countOfComment = 0;
		pstmt = null;
		try {

			pstmt = getCon().prepareStatement(selectCommentsCountSql());
			pstmt.setInt(1, c_boardidx);
			rs = pstmt.executeQuery();

			if (rs.next() != true) {
				// 없다
			} else {
				// 있다
				countOfComment = rs.getInt("count(c_idx)");

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
		return countOfComment;
	}

	public void excuteUpdateLikeitOnBoardTableSql(String b_idx) {
		pstmt = null;
		try {
			pstmt = getCon().prepareStatement(updateLikeitOnBoardTableSql());
			pstmt.setInt(1, Integer.parseInt(b_idx));
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("데이터베이스에 연결 할 수 없습니다.<br>");
		}
	}

}
