<%-- 
    Document   : admin
    Created on : 6 Jul 2024, 02.46.42
    Author     : Peno
--%>


<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.util.List"%>

<%--
    //HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");

--%>
<%
    // Mengecek apakah pengguna sudah login dan memiliki role_id yang sesuai
    if (session.getAttribute("username") == null || session.getAttribute("role_id") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Mendapatkan username dan role_id dari sesi
    String username = (String) session.getAttribute("username");
    int role_id = (Integer) session.getAttribute("role_id");

    // Pengecekan apakah role_id adalah 2 (untuk role_id lain, atur halaman yang sesuai)
    if (role_id != 2) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Admin Mie Rantau</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="vendors/feather/feather.css">
  <link rel="stylesheet" href="vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="vendors/typicons/typicons.css">
  <link rel="stylesheet" href="vendors/simple-line-icons/css/simple-line-icons.css">
  <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="../img/favicon.ico" />
</head>
<body>
  <div class="container-scroller"> 
    <!-- partial:partial/navbar.jsp -->
    <jsp:include page="partials/navbar.jsp" />
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_settings-panel.html -->
      <jsp:include page="partials/setting_panel.jsp" />     
      <!-- partial -->
      <!-- partial:partials/_sidebar.html -->
      <jsp:include page="partials/sidebar.jsp" /> 
      <!-- partial -->
      <div class="main-panel">
        <!-- awal content -->  
        <jsp:include page="pages/forms/data-admin.jsp" />
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <jsp:include page="partials/footer.jsp" />
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- plugins:js -->
  <script src="vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="vendors/chart.js/Chart.min.js"></script>
  <script src="vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
  <script src="vendors/progressbar.js/progressbar.min.js"></script>

  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="js/off-canvas.js"></script>
  <script src="js/hoverable-collapse.js"></script>
  <script src="js/template.js"></script>
  <script src="js/settings.js"></script>
  <script src="js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="js/dashboard.js"></script>
  <script src="js/Chart.roundedBarCharts.js"></script>
  <!-- End custom js for this page-->
</body>

</html>

