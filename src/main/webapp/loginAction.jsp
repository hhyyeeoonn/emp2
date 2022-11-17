<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>

<%
	// 1. controller
	// session 유효성 검증 코드 필요시 redirect
	// request 유효성 검증
	int empNo=Integer.parseInt(request.getParameter("empNo"));
	String firstName=request.getParameter("firstName");
	String lastName=request.getParameter("lastName");
	
	Employee employee=new Employee();
	employee.setEmpNo(empNo); // setter를 이용하여 private 데이터 불러오기
	
	
	
	// 2. model
	String driver="org.mariadb.jdbc.Driver"; // 변수를 사용하면 유지보수에 용이
	String dbUrl="jdbc:mariadb://localhost:3306/employees";
	String dbUser="root";
	String dbPw="java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println("=드라이버로딩 성공=");
		
	/*
	SELECT emp_No empNo
	FROM employee
	WHERE emp_No=? AND first_name=? AND last_name=?
	*/
	
	String sql=null;
	PreparedStatement stmt=conn.prepareStatement(sql);
	// getter 사용
	stmt.setInt(1, employee.getEmpNo());
	stmt.setString(2, employee.getFirstName());
	
	ResultSet rs=stmt.executeQuery();
	
	String targetUrl="/loginForm.jsp";
	
	if(rs.next()) {
		// 로그인 성공
		Employee loginEmp=new Employee();
		loginEmp.setEmpNo(rs.getInt("empNo"));
		loginEmp.setLastName(rs.getString("lastName"));
		session.setAttribute("loginEmp", loginEmp); // 키: "loginEmp", 값: Object object=loginEmp; Object는 모든 참조타입을 아우름 모든 참조타입을 Object라고 할 수 있음 하지만 꺼내서 쓸 때는 형변환 해야함
		targetUrl="/empList.jsp";
	}
	
	
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetUrl);
	
	// 3 view  이 Action 페이지에 view는 없다
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>