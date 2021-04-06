<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "gdu.mall.vo.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null){ //만약 session manager가 null인 경우 admin index로 이동
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2){ //메니저 레벨이 2보다 낮은 경우에도 admin index로 이동하도록.
		response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/adminIndex.jsp");
		return;
	}
	
	//메일이랑 패스워드 입력 된거 받아와서 변수 선언
	String clientMail=request.getParameter("clientMail");
	String clientPw=request.getParameter("clientPw");
	//디버깅
	System.out.println("client Mail : " + clientMail);
	System.out.println("client Pw : " + clientPw);
	
	//수정메소드 실행
	ClientDao.updateClient(clientMail, clientPw);
	
	//다끝나면 클라이언트 리스트로
	response.sendRedirect(request.getContextPath()+"/themes/classimax-premium/clientList.jsp");
%>