<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
	<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		
		return;
	}
	//매니저 레벨이 1인 경우 리스트로 재이동
	if(manager.getManagerLevel()==1){
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		System.out.println("레벨이 1입니다.");
		return;
	}
	request.setCharacterEncoding("utf-8");
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	Notice notice=NoticeDao.selectNoticeOne(noticeNo);
	System.out.println("no:"+noticeNo);
	%>
<body>
	<h1>update notice</h1>
	<!-- 임포트 > no값 받아오기 및 변수선언 > dao 값 받아올 수 있도록 > 테이블 > 액션으로 넘기기 -->
		<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<form action="<%=request.getContextPath()%>/notice/updateNoticeAction.jsp" method="post">
		<input type="text" name="noticeNo" value="<%=notice.getNoticeNo()%>" hidden="hidden">
		<table border="1">
			<tr>
				<td>no</td>
				<td><%=notice.getNoticeNo()%></td>
			</tr>
			<tr>
				<td>title</td>
				<td><input type="text" name="noticeTitle" value="<%=notice.getNoticeTitle()%>" required pattern="^[[A-Za-zㄱ-ㅎ0-9]$@$!%*#?&]+$"></td>
			</tr>
			<tr>
				<td>content</td>
				<td><textarea name="noticeContent" rows="8" cols="100" placeholder="<%=notice.getNoticeContent()%>"></textarea></td>
			</tr>
			<tr>
				<td>date</td>
				<td><%=notice.getNoticeDate()%></td>
			</tr>
			<tr>
				<td>creator</td>
				<td><%=notice.getManagerId()%></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button type="button">취소</button></a>
	</form>
</body>
</html>