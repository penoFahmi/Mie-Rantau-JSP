<%-- 
    Document   : keranjang
    Created on : 13 Jul 2024, 23.17.13
    Author     : Peno
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%--
    // Mengecek apakah pengguna sudah login dan memiliki role_id yang sesuai
    if (session.getAttribute("username") == null || session.getAttribute("role_id") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Mendapatkan username dan role_id dari sesi
    String username = (String) session.getAttribute("username");
    int role_id = (Integer) session.getAttribute("role_id");

    // Pengecekan apakah role_id adalah 3
    if (role_id != 3) {
        response.sendRedirect("../login.jsp");
        return;
    }
--%>
<%--
    // Mengecek apakah pengguna sudah login dan memiliki role_id yang sesuai
    if (session.getAttribute("username") == null || session.getAttribute("role_id") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Mendapatkan role_id dari sesi
    int role_id = (Integer) session.getAttribute("role_id");

    // Pengecekan apakah role_id adalah 3 (untuk role_id lain, atur halaman yang sesuai)
    if (role_id != 3) {
        response.sendRedirect("../login.jsp");
        return;
    }
--%>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>

<%
    //HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("role_id") == null || (int) session.getAttribute("role_id") != 3) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Menu</title>
    <link rel="icon" href="img/favicon.ico" type="image/x-icon" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      integrity="sha384-XJpS1nf79viuLZXFr3hht5d6c5cFO0ntea4Z46RrQ/cd3gG2aLoo6I9xH2bg2zIS"
      crossorigin="anonymous"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light shadow-lg">
      <div class="container">
        <a class="navbar-brand" href="../index.html">Mie<span>Rantau</span></a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNavAltMarkup"
          aria-controls="navbarNavAltMarkup"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
          <div class="navbar-nav ms-auto">
            <a href="menu.jsp" type="button" class="m-3 btn btn-primary">Pesan Lagi</a>
            <a href="../logout.jsp" type="button" class="m-3 btn btn-warning">LogOut</a>
          </div>
        </div>
      </div>
    </nav>
    <!-- Akhir Navbar -->

    <!-- Konten 1 -->
    <!-- Akhir Konten 1 -->
    <jsp:include page="actions/proses-add-keranjang.jsp"/>
    <!-- Konten 2 -->
    <!-- Akhir Konten 2 -->
    <audio autoplay loop src="audio/"></audio>
    <!-- Footer -->
    <jsp:include page="partial/footer.jsp"/>
    <!-- Footer Akhir -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
