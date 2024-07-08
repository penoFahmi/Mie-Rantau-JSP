<%-- 
    Document   : logout
    Created on : 5 Jul 2024, 23.53.05
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<%
    // Mengambil sesi yang ada
    //HttpSession session = request.getSession(false);
    
    // Mengecek apakah sesi tidak null
    if (session != null) {
        // Mendapatkan role_id dari sesi
        Integer role_id = (Integer) session.getAttribute("role_id");
        
        // Mengecek apakah role_id sesuai dengan yang diinginkan untuk logout
        if (role_id != null && role_id == 3) {
            session.invalidate();  // Mengakhiri sesi hanya untuk role_id 3
        }
    }
    // Mengarahkan kembali ke halaman login
    response.sendRedirect("login.jsp");
%>