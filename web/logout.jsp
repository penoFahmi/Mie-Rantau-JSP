<%-- 
    Document   : logout
    Created on : 5 Jul 2024, 23.53.05
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<%
    //HttpSession session = request.getSession(false); // Mengambil sesi yang ada atau null jika tidak ada
    if (session != null) {
        session.invalidate();  // Mengakhiri sesi
    }
    response.sendRedirect("login.jsp");  // Mengarahkan kembali ke halaman login
%>
