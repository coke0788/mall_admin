<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.ManagerDao"%>
<%@ page import="gdu.mall.vo.Manager"%>
<%
	//1. 요청, 수집
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	//디버깅
	System.out.println(managerId + "= 매니저아이디 파라미터");
	System.out.println(managerPw + "= 매니저패스워드 파라미터");
	
	//2. 처리
	Manager manager = ManagerDao.login(managerId, managerPw);
	if(manager != null) { //로그인에 성공한다면 매니저 정보를 리턴
		session.setAttribute("sessionManager", manager);
		System.out.println("로그인 성공");
	} 
	
	//3. redirect
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
%>