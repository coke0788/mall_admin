<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookOne</title>
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
	//ebookISBN 변수 선언. ebookISBN을 받아오기.
	String ebookISBN=request.getParameter("ebookISBN");
	Ebook ebook=EbookDao.selectEbookOne(ebookISBN);
	//디버깅
	System.out.println("ISBN :"+ebookISBN);
%>
	<h1>상세페이지</h1>
	<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<table border="1">
		<tr>
			<td>Ebook State</td>
			<td><%=ebook.getEbookState()%></td>
			<td><a href="<%=request.getContextPath()%>/ebook/updateEbookStateForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="submit">책상태 수정</button></a></td>
		</tr>
		<tr>
			<td>Ebook ISBN</td>
			<td><%=ebook.getEbookISBN()%></td>
			<td></td>
		</tr>
		<tr>
			<td>Category Name</td>
			<td><%=ebook.getCategoryName()%></td>
			<td></td>
		</tr>
		<tr>
			<td>Ebook Title</td>
			<td><%=ebook.getEbookTitle()%></td>
			<td></td>
		</tr>
		<tr>
			<td>Ebook Image</td>
			<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>" width="200" height="350"></td>
			<td><a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="submit">이미지 수정</button></a></td>
		</tr>
		<tr>
			<td>Ebook Author</td>
			<td><%=ebook.getEbookAuthor()%></td>
			<td></td>
		</tr>
		<tr>
			<td>Ebook Company</td>
			<td><%=ebook.getEbookCompany()%></td>
			<td></td>
		</tr>
		<tr>
			<td>Ebook PageCount</td>
			<td><%=ebook.getEbookPageCount()%></td>
			<td></td>
		</tr>
		<tr>
			<td>Ebook Price</td>
			<td><%=ebook.getEbookPrice()%></td>
			<td></td>
		</tr>
		<tr>
			<td>Ebook Summary</td>
			<td><textarea rows="8" cols="50" name="ebookSummary" readonly="readonly" wrap="hard"><%=ebook.getEbookSummary()%></textarea></td>
			<td><a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="submit">책요약 수정</button></a></td>
		</tr>
		<tr>
			<td>Ebook Date</td>
			<td><%=ebook.getEbookDate()%></td>
			<td></td>
		</tr>
	</table>
	<%
		System.out.printf("상태:%s 이미지:%s 이름:%s 타이틀:%s ISBN:%s 저자:%s 출판사:%s 페이지수:%d 가격:%d 요약:%s 날짜:%s%n", ebook.getEbookState(), ebook.getEbookImg(), ebook.getCategoryName(), ebook.getEbookTitle(), ebook.getEbookISBN(), ebook.getEbookAuthor(), ebook.getEbookCompany(), ebook.getEbookPageCount(), ebook.getEbookPrice(), ebook.getEbookSummary(), ebook.getEbookDate());
	%>
	<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="submit">전체 수정</button></a>
	<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button type="button">삭제</button></a><br>
	<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><button type="button">리스트로 이동</button></a>
</body>
</html>