<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.*"%>
<%@ page import = "gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookSummaryForm</title>
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
		String ebookISBN=request.getParameter("ebookISBN");
		Ebook ebook=EbookDao.selectEbookOne(ebookISBN);
	%>
	<h1>updateEbookSummaryForm</h1>
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp" method="post">
	<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
		<table>
			<tr>
				<td>Summary</td>
				<!-- 가독성이 너무 떨어져서 줄바꿈해서 보여주고 싶음. wrap="hard" 설정-->
				<td><textarea rows="5" cols="80" name="ebookSummary" placeholder="<%=ebook.getEbookSummary()%>" wrap="hard"></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		<!-- 취소하면 ebookone으로 돌아간다. -->
		<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="button">취소</button></a>
	</form>
</body>
</html>