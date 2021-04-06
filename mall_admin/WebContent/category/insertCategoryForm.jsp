<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "gdu.mall.vo.*" %>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryForm</title>
</head>
<body>
	<% 
		request.setCharacterEncoding("utf-8"); 
	%>
	<h1>insertCategoryForm</h1>
	<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>category name</td>
					<td><input type="text" required="required" pattern="^[A-Za-zㄱ-ㅎ0-9]+$" name="categoryName"></td>
				</tr>
				<tr>
					<td>category weight</td>
					<td><select name="categoryWeight">
					<%
						for(int i=0; i<=10; i++){
					%>
							<option value="<%=i%>"><%=i%></option>
					<%
						}
					%>
					</select></td>
				</tr>
			</table>
			<button type="submit">등록</button>
	</form>
</body>
</html>