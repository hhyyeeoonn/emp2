<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// session 유효성 검증
	
	Object objLoginEmp=session.getAttribute("loginEmp");
	Employee loginEmp=(Employee)objLoginEmp; // 형변환
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<%=loginEmp.getLastName()%>(<%=loginEmp.getEmpNo()%>)님 반갑습니다.
		<a href=
	</div>
</body>
</html>