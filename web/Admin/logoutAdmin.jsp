<%-- 
    Document   : logoutAdmin
    Created on : 8 Jul 2024, 11.21.57
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Logout Role 2</title>
</head>
<body>
<%
    // Mengambil sesi yang ada
    HttpSession session = request.getSession(false);
    
    // Mengecek apakah sesi tidak null
    if (session != null) {
        // Mendapatkan role_id dari sesi
        Integer role_id = (Integer) session.getAttribute("role_id");
        
        // Mengecek apakah role_id sesuai dengan yang diinginkan untuk logout
        if (role_id != null && role_id == 2) {
            session.invalidate();  // Mengakhiri sesi hanya untuk role_id 2
        }
    }
    // Mengarahkan kembali ke halaman login
    response.sendRedirect("login.jsp");
%>
</body>
</html>

