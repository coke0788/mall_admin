<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeInsertForm</title>
</head>
<!-- 관리자만 들어올 수 있는 코드 추가 -->
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		System.out.println("레벨이 1보다 낮습니다.");
		return;
	}
	//매니저 레벨이 1인 경우 리스트로 재이동
	if(manager.getManagerLevel()==1){
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		System.out.println("레벨이 1입니다.");
		return;
	}
%>
<body>
	<%
		request.setCharacterEncoding("utf-8"); 
	%>
	<!-- Dao 먼저 만들고! 1. 값 적는란 만들기 2. 값 보낼거임. 액션으로. 
		임포트 > 폼액션 > 테이블 > submit -->
	<h1>notice insert form</h1>
	<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>	 
	<form action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp" method="post">
		<input type="text" name="managerId" value=<%=manager.getManagerId()%> hidden="hidden">
		<table border="1">
			<tr>
				<td>title</td>
				<td><input type="text" required pattern="^[[A-Za-zㄱ-ㅎ0-9]$@$!%*#?&]+$" name="noticeTitle"></td>
			</tr>
			<tr>
				<td>content</td>
				<td><textarea rows=5 cols=80 name="noticeContent"></textarea></td>
			</tr>
		</table>
		<button type="submit">등록</button>
		<a href="<%=request.getContextPath()%>/notice/noticeList.jsp"><button type="button">취소</button></a>
	</form>
</body>
</html>