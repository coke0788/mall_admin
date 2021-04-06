<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import ="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertEbookForm</title>
</head>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<body>
	<%	
		request.setCharacterEncoding("utf-8");
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		System.out.println("카테고리 목록 사이즈 :" + categoryNameList.size());
	%>
	<h1>insertEbookForm</h1>
	<!-- img, date, state는 기본값으로 가져오므로 안 만듦-->
	<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>category name</td>
				<td>
					<select name="categoryName">
						<option value="">선택</option>
						<%
							for(String cn : categoryNameList){
						%>
							<!-- 카테고리이름 배열에 있는거 다 가져오기 -->
							<option value="<%=cn%>"><%=cn%></option>
						<%	
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>ebook ISBN</td>
				<td>
					<input type="text" name="ebookISBN" required pattern="^[a-zA-Z0-9]+$">
				</td>
			</tr>
			<tr>
				<td>ebook Title</td>
				<td>
					<input type="text" name="ebookTitle" required pattern="^[[A-Za-zㄱ-ㅎ0-9]$@$!%*#?&]+$">
				</td>
			</tr>
			<tr>
				<td>ebook Author</td>
				<td>
					<input type="text" name="ebookAuthor" required pattern="^[[A-Za-zㄱ-ㅎ0-9]+$">
				</td>
			</tr>
			<tr>
				<td>ebook Company</td>
				<td>
					<input type="text" name="ebookCompany" required pattern="^[[A-Za-zㄱ-ㅎ0-9]$@$!%*#?&]+$">
				</td>
			</tr>
			<tr>
				<td>ebook Page Count</td>
				<td>
					<input type="text" name="ebookPageCount" required pattern="^[0-9]+$">
				</td>
			</tr>
			<tr>
				<td>ebook Price</td>
				<td>
					<input type="text" name="ebookPrice" required pattern="^[0-9]+$">
				</td>
			</tr>
			<tr>
				<td>ebook Summary</td>
				<td>
					<textarea rows="5" cols="80" name="ebookSummary"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><button type="button">취소</button></a>
	</form>
</body>
</html>