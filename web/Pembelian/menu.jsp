<%-- 
    Document   : menu
    Created on : 11 Jul 2024, 13.06.32
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
    <jsp:include page="partial/navbar.jsp"/>
    <!-- Akhir Navbar -->
    <div  class="container">
    <!-- Konten 1 -->
    <!-- Akhir Konten 1 -->
    <jsp:include page="actions/daftar-product.jsp"/>
    <!-- Konten 2 -->
    <!-- Akhir Konten 2 -->
<div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle">   
    <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">
        <i class="bi bi-cart-plus-fill">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart-plus-fill" viewBox="0 0 16 16">
             <path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0M9 5.5V7h1.5a.5.5 0 0 1 0 1H9v1.5a.5.5 0 0 1-1 0V8H6.5a.5.5 0 0 1 0-1H8V5.5a.5.5 0 0 1 1 0"/>
            </svg>
        </i>
    </button>
</div>
<div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
  <div class="offcanvas-header bg-danger p-4">
    <h5 class="offcanvas-title" id="offcanvasScrollingLabel">Pesanan</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
         <%-- Your Java servlet and HTML code here --%>
        <jsp:include page="actions/isi-canvas.jsp"/>
         <%-- Your Java servlet and HTML code here --%>
  </div>
  
<div class="footer bg-warning text-body-secondary p-3">
    <a type="button" class="btn btn-primary" href="proses-transaksi.jsp">
        <i class="bi bi-cart-check-fill">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart-check-fill" viewBox="0 0 16 16">
        <path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m-1.646-7.646-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708.708"/>
        </svg>
        </i>
    </a>
</div>

</div> 
    
<div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasWithBothOptionsLabel">Riwayat Pembelian</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
        <jsp:include page="actions/riwayat-pembelian.jsp"/>
  </div>
</div>    
    
    
    
    <audio autoplay loop src="audio/"></audio>
    </div> 
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