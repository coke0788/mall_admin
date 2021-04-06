<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
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
<title>categoryList</title>
</head>
<body>
	<%
		//배열 선언(categorydao에서 가져오기.)
		ArrayList<Category> list = CategoryDao.selectCategoryList();
	%>
	<h1>카테고리 목록</h1>
	<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<a href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp"><button type="button">카테고리 추가</button></a>
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<!-- weight는 수정 가능하게 만들거임(레벨처럼?) -->
				<th>categoryWeight</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Category c : list){
		%>
			<tr>
				<td><%=c.getCategoryName()%></td>
				<!-- 가중치 수정 -> 액션으로 넘기기 -->
				<td><form action="<%=request.getContextPath()%>/category/updateCategoryWeightAction.jsp" method="post">
					<!-- 넘버값 넘어가지만 보이지 않게 -->
					<input type="hidden" name="categoryNo" value="<%=c.getCategoryNo()%>">
					<select name="categoryWeight">
					<%
						for(int i=0; i<=10; i++){
							if(c.getCategoryWeight()==i){ //카테고리 가중치가 i와 같은 경우 옵션값이 선택 되어지도록
					%>
								<option value="<%=i%>" selected=selected><%=i%></option>
					<%
							}else{
					%>
								<option value="<%=i%>"><%=i%></option>
					<%
							}
						}
					%>
					</select>
					<button type="submit">수정</button>
					</form>
				</td>
				<td><a href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>"><button type="button">삭제</button></a></td>
			</tr>
		<%
			}
		 %>
		</tbody>
	</table>
</body>
</html>