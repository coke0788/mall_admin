<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.EbookDao"%>
<%@page import = "gdu.mall.vo.*" %>
<%

	//매니저 등록이 안 되어 있거나 매니저레벨이 1보다 낮은 경우 진입 불가
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	String ebookISBN=request.getParameter("ebookISBN");
	String ebookState=request.getParameter("ebookState");
	System.out.printf("ISBN:%s 상태:%s%n", ebookISBN, ebookState);
	
	Ebook ebook=new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	EbookDao.updateEbookState(ebook);
	
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebook.getEbookISBN());
%>
