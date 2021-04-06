<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.EbookDao"%>
<%@ page import = "gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookStateForm</title>
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
	<h1>updateEbookStateForm</h1>
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<%
		request.setCharacterEncoding("utf-8");
		String ebookISBN=request.getParameter("ebookISBN");
		Ebook ebook=EbookDao.selectEbookOne(ebookISBN);
	%>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp" method="post">
	<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
	<table>
		<tr>
			<td>책상태수정<td>
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
	</table>
	<button type="submit">수정</button>
	<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="button">취소</button></a>
	</form>
</body>
</html>