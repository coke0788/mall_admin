<%@page import="gdu.mall.dao.*"%>
<%@page import="gdu.mall.vo.*"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookForm</title>
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		String ebookISBN=request.getParameter("ebookISBN");
		Ebook ebook=EbookDao.selectEbookOne(ebookISBN);
		System.out.println("ISBN :"+ebookISBN);
	%>
	<h1>updateEbookForm</h1>
		<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- enctype을 추가하면 데이터(이미지의..데이터?)가 넘어감-->
	<form action="<%=request.getContextPath()%>/ebook/updateEbookAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>ebook state</td>
				<td>
					<select name="ebookState">
						<option value="">선택</option>
						<option value="판매중">판매중</option>
						<option value="품절">품절</option>
						<option value="절판">절판</option>
						<option value="구편절판">구편절판</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>ebook ISBN</td>
				<td><input type="text" name="ebookISBN" value="<%=ebook.getEbookISBN()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>ebook title</td>
				<td><input type="text" name="ebookTitle" value="<%=ebook.getEbookTitle()%>" required pattern="^[[A-Za-zㄱ-ㅎ0-9]$@$!%*#?&]+$"></td>
			</tr>
			<tr>
				<td>category name</td>
				<td>
					<select name="categoryName">
						<option value="">선택</option>
						<%
							for(String cn : categoryNameList){
						%>
							<option value=<%=cn%>><%=cn%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>ebook author</td>
				<td><input type="text" name="ebookAuthor" value="<%=ebook.getEbookAuthor()%>" required pattern="^[[A-Za-zㄱ-ㅎ0-9]+$"></td>
			</tr>
			<tr>
				<td>ebook company</td>
				<td><input type="text" name="ebookCompany" value="<%=ebook.getEbookCompany()%>" required pattern="^[[A-Za-zㄱ-ㅎ0-9]$@$!%*#?&]+$"></td>
			</tr>
			<tr>
				<td>ebook page count</td>
				<td><input type="text" name="ebookPageCount" value="<%=ebook.getEbookPageCount()%>" required pattern="^[0-9]+$"></td>
			</tr>
			<tr>
				<td>ebook price</td>
				<td><input type="text" name="ebookPrice" value="<%=ebook.getEbookPrice()%>" required pattern="^[0-9]+$"> </td>
			</tr>
			<tr>
				<td>ebook summary</td>
				<td><textarea rows="5" cols="80" name="ebookSummary" placeholder="<%=ebook.getEbookSummary()%>"></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="button">취소</button></a>
	</form>
</body>
</html>