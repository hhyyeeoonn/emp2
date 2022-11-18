<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	// 1) 
	// session 유효성 검증
	if(session.getAttribute("loginEmp") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	
	/*
	Object objLoginEmp=session.getAttribute("loginEmp"); // getAttribute 메서드로 세션에 저장된 값을 조회 리턴 타입은 Object
	Employee loginEmp=(Employee)objLoginEmp; // 형변환 
	*/

	Employee loginEmp=(Employee)(session.getAttribute("loginEmp"));
	
	int currentPage=1;
	if(request.getParameter("currentPage") != null) {
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String sort="ASC";
	if(request.getParameter("sort") !=null && request.getParameter("sort").equals("DESC")) {
		sort="DESC";
	}
	
	
	// 2) Model 	
	// 사원목록 불러오기
	String driver="org.mariadb.jdbc.Driver"; // 변수를 사용하면 유지보수에 용이
	String dbUrl="jdbc:mariadb://localhost:3306/employees";
	String dbUser="root";
	String dbPw="java1234";
	
	//
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println("=드라이버로딩 성공=");
	//
	int rowPerPage=10;
	int beginRow=(currentPage-1) * rowPerPage;

	String cntSql="SELECT COUNT(*) cnt FROM employees";
	PreparedStatement cntStmt=conn.prepareStatement(cntSql);
	ResultSet cntRs=cntStmt.executeQuery();
	int cnt=0; //전체 행의 수
	if(cntRs.next()) {
		cnt=cntRs.getInt("cnt");
	}	
	int lastPage=(int)(Math.ceil((double)cnt / (double)rowPerPage));
		System.out.println("="+"lastPage : "+lastPage+"=");
	
	//
	String sql="SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY first_name ASC LIMIT ?, ?";
	if(sort.equals("DESC")) {
		sql="SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY first_name DESC LIMIT ?, ?";
	}
		System.out.println("="+"sort : "+sort+"=");
	
	PreparedStatement stmt=conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, rowPerPage);
	
	ResultSet rs=stmt.executeQuery();
	ArrayList<Employee> list=new ArrayList<Employee>();
	while(rs.next()) {
		Employee e=new Employee();
		e.setEmpNo(rs.getInt("empNo"));
		e.setFirstName(rs.getString("firstName"));
		e.setLastName(rs.getString("lastname"));
		list.add(e);
	}
		System.out.println("ArrayList<Employees>");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-3">
	<div>
		<h4><small><%=loginEmp.getLastName()%>(<%=loginEmp.getEmpNo()%>)님 반갑습니다.</small></h4>
		<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	</div>
	<br>
	<h2 class="text-center">사원목록</h2>
	<div class="container p-5 my-5 border">
		<table class="table">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>
						<%
							if(sort.equals("ASC")) {
						%>
								<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage%>&sort=DESC">[내림차순]</a>				
						<%		
							} else {
						%>
								<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage%>&sort=ASC">[오름차순]</a>								
						<%		
							}
						%>
				</th>
			</tr>
			<%
				for(Employee e:list) {
			%>	
				<tr>
					<td><%=e.getEmpNo()%></td>
					<td colspan="2"><%=e.getFirstName() +""+ e.getLastName()%></td>
				</tr>
			<%
				}
			%>
		</table>
		
		
		<!-- 페이징 -->
		<div>
			<span>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=1&sort=<%=sort%>">처음</a>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage-1%>&sort=<%=sort%>">이전</a>
				<%
					}
				%>
			</span>
			<span><%=currentPage%></span>
			<span>
				<%
					if(currentPage < lastPage) { 
				%>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage+1%>&sort=<%=sort%>">다음</a>
				<%
					}
				%>		
			</span>
			<span>
				<%
					if(currentPage < lastPage) {
				%>
					<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=lastPage%>&sort=<%=sort%>">마지막</a>
				<%
					}
				%>
			</span>
		</div>
	</div>
</div>
</body>
</html>