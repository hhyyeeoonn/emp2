<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.net.*" %>
<%
	// 1. controller
	request.setCharacterEncoding("utf-8");
	String num=request.getParameter("empNo");
	String firstName=request.getParameter("firstName");
	String lastName=request.getParameter("lastName");
	
	if((num == null) || (num.equals(""))) {
		num="0";
	}
	int empNo=Integer.parseInt(num);
	
	
	// session 유효성 검증 코드 필요시 redirect
	if(session.getAttribute("loginMemberId") != null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
		return;
	}
	
	// request 유효성 검증
	if((empNo == 0) || (firstName == null) || (firstName.equals("")) || (lastName == null) || (lastName.equals(""))) {
		String msg=URLEncoder.encode("사원번호와 이름을 입력하십시오.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
		System.out.println("=빈칸확인=");
	
	Employee employee=new Employee();
	employee.setEmpNo(empNo); // setter를 이용하여 private 데이터 불러오기
	employee.setFirstName(firstName);
	employee.setLastName(lastName);
	
	
	// 2. model
	String driver="org.mariadb.jdbc.Driver"; // 변수를 사용하면 유지보수에 용이
	String dbUrl="jdbc:mariadb://localhost:3306/employees";
	String dbUser="root";
	String dbPw="java1234";
	
	Class.forName(driver); // 외부드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println("=드라이버로딩 성공=");
		
	/*
	SELECT emp_no empNo
		, last_name lastName
	FROM employee
	WHERE emp_no=? AND first_name=? AND last_name=?
	*/
	
	String sql="SELECT emp_no empNo, last_name lastName From employees WHERE emp_no=? AND first_name=? AND last_name=?";
	PreparedStatement stmt=conn.prepareStatement(sql);
	// getter 사용
	stmt.setInt(1, employee.getEmpNo());
	stmt.setString(2, employee.getFirstName());
	stmt.setString(3, employee.getLastName());
	
	ResultSet rs=stmt.executeQuery();
	
	String targetUrl="/loginForm.jsp";
	
	if(rs.next()) {
		// 로그인 성공
		Employee loginEmp=new Employee();
		loginEmp.setEmpNo(rs.getInt("empNo"));
		loginEmp.setLastName(rs.getString("lastName"));
		session.setAttribute("loginEmp", loginEmp); // 키: "loginEmp", 값: Object object=loginEmp; Object는 모든 참조타입을 아우름 꺼내서 쓸 때는 형변환 필요
		targetUrl="/empList.jsp";
	}
	// session.setAttribute("설정한 세션아이디", 세션에 넣을 값); 
		System.out.println("=로그인성공=");

	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetUrl);
	
	// 3 view  이 Action 페이지에 view는 없다
%>