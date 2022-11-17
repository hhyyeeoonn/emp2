<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect(request.getContextPath()+"/empList.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/loginAction.jsp">
		<table>
			<tr>
				<td>사원번호</td>
				<td><input type="text" name="empNo"></td>
			</tr>
			<tr>
				<td>이름(firstName)</td>
				<td><input type="text" name="firstName"></td>
			</tr>
			<tr>
				<td>성(lastName)</td>
				<td><input type="text" name="lastName"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>