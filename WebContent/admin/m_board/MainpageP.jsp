<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "exam.jdbc.DBcon" %>
    <% 
    request.setCharacterEncoding("UTF-8");
     
   
    String title = request.getParameter("title"); 
	String option = request.getParameter("op");
	
	String sql1 = "select b_idx, B.b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip,mem_power from board1 B join member1 M on B.b_useridx = M.mem_idx where ";
	String sqllast = " order by b_regdate desc,b_idx desc limit 0, 10";
	String sql = "";
	String psql = "select count(b_idx) from board1 where ";
	String sqltitle = "";

	
	
	
	if(title.equals("")){
		sql = "select b_idx, B.b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip,mem_power from board1 B join member1 M on B.b_useridx = M.mem_idx order by b_regdate desc,b_idx desc limit 10";
		psql = "";
	}
	
	else if(option.equals("title/all")){
    	sqltitle = "b_title like '%"+title+"%'"; 
    	
    	sql = sql1+sqltitle+sqllast;
    	psql = "where b_title like ";
    	
    }else if(option.equals("title/not")){
    	sqltitle = "b_title like '%"+title+"%'"; 
    	
    	String sqlpower = "and mem_power = '관리자' ";
    	sql = sql1+sqltitle+sqlpower+sqllast;
    	psql = "where b_title like ";
    	
    }else if(option.equals("title/com")){
    	sqltitle = "b_title like '%"+title+"%'"; 
    	
    	String sqlpower = "and mem_power = '일반' ";
    	sql = sql1+sqltitle+sqlpower+sqllast;
    	psql = "where b_title like ";
    	
    }else if(option.equals("name/com")){
    	sqltitle = "b_name like '%"+title+"%'"; 
    	
    	sql = sql1+sqltitle+sqllast;
    	psql = "where b_name like ";
    }else if(option.equals("con")){
    	sqltitle = "b_content like '%"+title+"%'";
    	
    	sql = sql1+sqltitle+sqllast;
    	psql = "where b_content like ";
    }
    
  
    
    
    try{
    	DBcon dd = new DBcon();
    	ResultSet re = null;
       	Connection conn = dd.DBcdriver();
        PreparedStatement pstmt = null;
        
  		
    	//sql = "select b_idx, B.b_useridx, b_name, b_title, b_email, b_content, b_file, b_regdate, b_hit, b_ip,mem_power from board1 B join member1 M on B.b_useridx = M.mem_idx where b_title like '%"+title+"%' order by b_regdate desc"; //여기에서 pw id 검사
 
    	pstmt = conn.prepareStatement(sql);
    	
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
    	
    	
pstmt = conn.prepareStatement("select count(b_idx) from board1 "+psql+"'"+"%"+title+"%"+"'");
re = pstmt.executeQuery();
while(re.next()){
int anote = re.getInt("count(b_idx)");
int pg = anote/10;
if(anote%10 > 0){
	pg += 1;
}


for(int i = 1; i <= pg ; i++){
%>	
			<a href="#" onclick='pagingS("<%=i %>","<%=psql%>","<%=title%>")'>[<%=i %>]</a>
			<%
			}
}
    	   	
    	
 }catch(Exception e){
		e.printStackTrace();
	}
    %>
