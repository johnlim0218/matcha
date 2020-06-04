package exam.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class JDBC_memberDAO {

	/*
	 * 프로퍼티 선언
	 */
	Connection con;
	Statement st;
	PreparedStatement ps;
	ResultSet rs;
	

	// MySQL
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost:3306/website";
	String id = "root";
	String pwd = "1234";

	

	public JDBC_memberDAO(){
       
        try {
        	//로드
            Class.forName(driverName);
           
            //연결
            con = DriverManager.getConnection(url,id,pwd);       
           
        } catch (ClassNotFoundException e) {
           
            System.out.println(e+"=> 로드실패");
           
        } catch (SQLException e) {
           
            System.out.println(e+"=> 연결 실패");
        }
    }// JDBC_memberDAO()

	/**
	 * DB close() 기능
	 */
	public void db_close() {

		try {

			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (st != null)
				st.close();

		} catch (SQLException e) {
			System.out.println(e + "=> 닫기 오류");
		}

	} // db_close

	/**
	 * member 테이블에 insert하는 메소드 작성
	 */

	/**
	 * member테이블의 모든 레코드 검색하(Select)는 메서드 작성 (검색필드와 검색단어가 들어왔을때는 where를 이용하여 검색해준다.)
	 **/

	public ArrayList<MemberVO> getMemberlist(String paging1) {

		ArrayList<MemberVO> list = new ArrayList<MemberVO>();

		try {// 실행

			String sql = "SELECT mem_userid, mem_name, mem_pwd, mem_gender from member1 order by mem_userid limit "+paging1+", 10";
			st = con.createStatement();
			rs = st.executeQuery(sql);

			while (rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setMem_userid(rs.getString(1));
				vo.setMem_name(rs.getString(2));
				vo.setMem_pwd(rs.getString(3));
				vo.setMem_gender(rs.getString(4));

				list.add(vo);
			}
		} catch (Exception e) {
			System.out.println(e + "=> getMemberlist fail");
		} finally {
			db_close();
		}
		return list;
	}

	public int memberInsert(MemberVO vo) {
		int result = 0;

		try {

			String sql = "INSERT INTO MEMBER1(mem_userid, mem_name, mem_pwd, mem_gender) VALUES(?,?,?,?)";

			ps = con.prepareStatement(sql);
			ps.setString(1, vo.getMem_userid());
			ps.setString(2, vo.getMem_name());
			ps.setString(3, vo.getMem_pwd());
			ps.setString(4, vo.getMem_gender());

			result = ps.executeUpdate();

		} catch (Exception e) {

			System.out.println(e + "=> memberInsert fail");

		} finally {
			db_close();
		}

		return result;
	}

	// 삭제 기능
	public int delMemberlist(String mem_userid) {
		int result = 0;
		try { // 실행
			ps = con.prepareStatement("delete from member1 where mem_userid = ?");
			ps.setString(1, mem_userid.trim());
			result = ps.executeUpdate(); // 쿼리 실행으로 삭제된 레코드 수 변환
		} catch (Exception e) {
			System.out.println(e + "delMemberlist fail");
		} finally {
			db_close();
		}
		return result;
	}

}