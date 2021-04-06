<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null){ //만약 session manager가 null인 경우 admin index로 이동
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2){ //메니저 레벨이 2보다 낮은 경우에도 admin index로 이동하도록.
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//넘버 받아오기
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	
	//dao 삭제 메서드 호출 코드 구현
	ManagerDao.deleteManager(managerNo);
	System.out.println("manager No :"+managerNo);
	
	//삭제완료시 매니저리스트로 이동
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/managerList.jsp");
%>