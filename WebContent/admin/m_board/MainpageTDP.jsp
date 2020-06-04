<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.SQLException" %>
<%



	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet re = null;
	String sql = "";

		
			
			int clickpage = Integer.parseInt(request.getParameter("clickpage"));
			String option = request.getParameter("option");
			String search = request.getParameter("search");
			String bug = "";
			
			clickpage *= 10;
			clickpage -= 10;
			
			try{
			
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/website", "root", "1234");
			
				if(search.equals("a") || search.equals("")){
					option = "";
					search = "";
					sql = "select b_idx, B.b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip,mem_power from board1 B join member1 M on B.b_useridx = M.mem_idx order by b_regdate desc,b_idx desc limit ?, 10";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, clickpage);
				}
				else{
					sql = "select b_idx, B.b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip,mem_power from board1 B join member1 M on B.b_useridx = M.mem_idx "+option+"'%"+search+"%' order by b_regdate desc,b_idx desc limit ?, 10";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, clickpage);
					bug = "'"+"%"+search+"%"+"'";
				}
				
				
				
				
			pstmt.executeUpdate();
			re = pstmt.executeQuery();
			
			if(re.next()){
				re.beforeFirst();
			while(re.next()){
				
				String b_idx = re.getString("b_idx");
				String re_b_idx = re.getString("b_idx");
				String b_title = re.getString("b_title");
				String b_name = re.getString("b_name");
				String b_file = re.getString("b_file");
				String b_regdate = re.getString("b_regdate");
				String b_ip = re.getString("b_ip");
				String b_hit = re.getString("b_hit");
				String mem_power = re.getString("mem_power");
				
				if(mem_power.equals("관리자")){
					b_idx = "[공지]";
				}
				
				b_regdate = b_regdate.substring(0, 10);
				
			%>
			        <table>
		            <tr>
		                <td width="5%"><%=b_idx %></td>
		                <td width="30%"><%=b_title %></td>
		                <td width="10%"><%=b_name %></td>
		                <td width="10%"><%=b_file %></td>
		                <td width="10%"><%=b_regdate %></td>
		                <td width="5%"><%=b_hit %></td>
		                <td width="10%"><%=b_hit %></td>
		                <td width="10%"><%= mem_power%></td>
		                
		                <td width="10%"><input type="button" id="mod" value="수정" onclick="noticepopup(<%=re_b_idx %>)"> <input type="button" id="del" value="삭제" onclick="noticedelete(<%=re_b_idx%>)"></td>
		            </tr>
		    </table>
		    <hr>
			<%
			}
			}else{
				%>
		        <table>
	            <tr>
	       
                <td width="100%">검색결과가 없습니다...</td>
         
	            </tr>
	    </table>
	    <hr>
		<%
			}
			
			
			
		
		pstmt = conn.prepareStatement("select count(b_idx) from board1 "+option+bug);
		re = pstmt.executeQuery();
		while(re.next()){
		int anote = re.getInt("count(b_idx)");
		int pg = anote/10;
		if(anote%10 > 0){
			pg += 1;
		}

		for(int i = 1; i <= pg ; i++){
		%>	
					<a href="#" onclick='pagingS("<%=i %>","<%=option%>","<%=search%>")'>[<%=i %>]</a>
		<% }
					}
			}catch(Exception e){
				e.printStackTrace();
			}
			
		%>