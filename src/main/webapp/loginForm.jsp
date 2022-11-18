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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-3">
	<h1 class="text-center">로그인</h1>
	<div class="container p-5 my-5 border">
		<form action="<%=request.getContextPath()%>/loginAction.jsp">
			<table class="table table-borderless">
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
			<button type="submit" class="btn btn-secondary">로그인</button>
		</form>
		<%
			String msg=request.getParameter("msg");
			if(msg != null) {
		%>
			<div>
				<%=msg%>	
			</div>
		<%	
			}
		%>
	</div>
</div>
</body>
</html>