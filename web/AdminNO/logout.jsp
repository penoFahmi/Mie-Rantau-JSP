<%-- 
    Document   : logout
    Created on : 3 Jul 2024, 02.27.37
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<%
    //HttpSession session = request.getSession();
    session.invalidate();  // Mengakhiri sesi
    response.sendRedirect("login.jsp");  // Mengarahkan kembali ke halaman login
%>