<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		System.out.println("레벨이 1보다 낮습니다.");
		return;
	}
	String commentContent=request.getParameter("commentContent");
	String managerId=request.getParameter("managerId");
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	Comment comment = new Comment();
	comment.setCommentContent(commentContent);
	comment.setManagerId(managerId);
	comment.setNoticeNo(noticeNo);
	CommentDao.insertComment(comment);
	System.out.printf("content=%s, managerid=%s, noticeNo=%d%n", commentContent, managerId, noticeNo);
	
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/noticeOne.jsp?noticeNo="+noticeNo);
%>