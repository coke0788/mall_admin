<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
</head>
<!-- 관리자만 들어올 수 있는 코드 추가 -->
<%
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
%>
<body>
<%
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	Notice notice=NoticeDao.selectNoticeOne(noticeNo);
	System.out.println("넘버:"+noticeNo);
%>
	<!-- no 변수선언 및 dao 받아오기 > 들어온 값들로 테이블 만들기 -->
	<h1>Notice</h1>
		<!-- 관리자화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>	 
	<table border="1">
		<tr>
			<td>no</td>
			<td><%=notice.getNoticeNo()%></td>
		</tr>
		<tr>
			<td>title</td>
			<td><%=notice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<td>content</td>
			<td><%=notice.getNoticeContent()%></td>
		</tr>
		<tr>
			<td>date</td>
			<td><%=notice.getNoticeDate()%></td>
		</tr>
		<tr>
			<td>creator</td>
			<td><%=manager.getManagerId()%></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/notice/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button>수정</button></a>
	<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button>삭제</button></a>
	
	<!-- 댓글 작성 -->
	<hr>
	<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp?noticeNo=<%=notice.getNoticeNo()%>" method="post">
		<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
		<div>
			managerId:
			<input type="text" name="managerId" value="<%=manager.getManagerId()%>" readonly="readonly">
		</div>
		<div>
			<textarea rows="2" cols="80" name="commentContent"></textarea>
		</div>
		<button type="submit">작성</button>
	</form>
	<!-- 댓글 리스트 -->
	<%
		ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
		for(Comment c : commentList) {
	%>
		<table border="1">
			<tr>
				<td><%=c.getCommentContent()%></td>
				<td><%=c.getCommentDate()%></td>
				<td><%=c.getManagerId()%></td>
				<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=notice.getNoticeNo()%>"><button type="button">삭제</button></a></td>
			</tr>
		</table>
	<%
		}
	%>
</body>
</html>