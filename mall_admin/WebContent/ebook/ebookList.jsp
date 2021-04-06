<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookList</title>
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
	<h1>ebook list</h1>
	<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<%
	//카테고리네임 변수 선언
		String categoryName=request.getParameter("categoryName");
		if(request.getParameter("categoryName")!=null){
			categoryName = request.getParameter("categoryName");
		}
	//현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage")!=null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}	
	//페이지 당 row
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage")!=null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}	
	//시작 행
		int beginRow = (currentPage-1) * 10;	
	//전체 행과 마지막 페이지
		int totalRow = EbookDao.totalCount(categoryName);
		int lastPage = totalRow/rowPerPage;
	//배열 선언
		ArrayList<Ebook> list = EbookDao.selectEbookList(rowPerPage, beginRow, categoryName);
	%>
		<!-- 카테고리별 목록을 볼 수 있는 메뉴 있어야 됨. 카테고리 클릭하면 갈 수 있는 네비게이션 메뉴 -->
	<div>
		<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">전체보기</a>
		<%	
			//arraylist 받아오기
			ArrayList<String> categoryNameList=CategoryDao.categoryNameList();
			for(String s : categoryNameList){
		%>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>"><%=s%></a>
		<%
			}
		%>
		</form>
	</div>
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button>ebook 추가</button></a>
	<!-- 페이지 개수 보기 -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
		<!-- 히든값으로 카테고리네임 넘겨서 몇개씩 보기 누르면 카테고리네임이 넘어가도록. 그러면 몇개씩 보기랑 카테고리네임이 연동 됨. -->
		<input type= "hidden" name="categoryName" value="<%=categoryName%>">
		<select name="rowPerPage">
		<%
			for(int i=10; i<=30; i+=5){
				//rowPerPage가 i일 경우 i를 선택되도록 하는 코드
				if(rowPerPage==i){
		%>
					<option value="<%=i%>" selected="selected"><%=i%></option>
		<%
				} else{
		%>
					<option value="<%=i%>"><%=i%></option>
		<%	
			}
		}
		%>
		</select>
		<button type="submit">보기</button>
	</form>
	<!-- 페이징 작업 -->
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th>
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPrice</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Ebook e : list){
		%>
			<tr>
				<td><%=e.getCategoryName()%></td>
				<td><%=e.getEbookISBN()%></td>
				<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle()%></a></td>
				<td><%=e.getEbookAuthor()%></td>
				<td><%=e.getEbookDate().substring(0,11)%></td>
				<td><%=e.getEbookPrice()%></td>
			</tr>
		<%
			}
		 %>
		</tbody>
	</table>
	<div>
		<%
		// 첫번째 페이지에서는 이전 버튼 안 보이도록
		if(currentPage>1){
		%>
		<!-- 첫번째 페이지로 -->
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
			<button type = button>&lt;&lt; 처음으로</button></a>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
			<button type = button><%=currentPage-1 %></button></a>
		<%
		}
		//라스트 페이지에서는 다음 버튼이 안 보이도록
		if(currentPage<lastPage){
		%>
			<button type=button><%=currentPage%></button>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
			<button type = button><%=currentPage+1%></button></a>
		<!-- 마지막 페이지로 -->
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
			<button type = button>끝으로 &gt;&gt;</button></a>	
		<%
		//라스트페이지일 때 현재 페이지는 출력 되어야 하기 때문에 코드 추가
		} else if(currentPage==lastPage){
		%>
			<button type=button><%=currentPage%></button>
		<%
		}
		%>	
	</div>
</body>
</html>