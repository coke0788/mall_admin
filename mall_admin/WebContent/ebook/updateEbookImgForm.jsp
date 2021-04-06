<%@page import="gdu.mall.dao.EbookDao"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookImgForm</title>
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
		String ebookISBN=request.getParameter("ebookISBN");
		System.out.println("ISBN :"+ebookISBN);
		Ebook ebook=EbookDao.selectEbookOne(ebookISBN);
	%>
	<h1>updateEbookImgForm</h1>
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<!-- enctype을 추가하면 데이터(이미지의..데이터?)가 넘어감-->
	<form action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
		<input type="file" name="ebookImg"><br>
		<button type="submit">이미지 수정</button>
		<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="button">취소</button></a>
	</form>
</body>
</html>