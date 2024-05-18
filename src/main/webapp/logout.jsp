<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.IOException" %>

<%
    // Obtém a sessão atual
    HttpSession sessio = request.getSession(false);
    if (session != null) {
        // Invalida a sessão
        sessio.invalidate();
    }

    // Redireciona para a página de login
    response.sendRedirect("login.jsp");
%>
