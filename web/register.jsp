<%-- 
    Document   : register
    Created on : 8 Jul 2024, 11.54.07
    Author     : Peno
--%>

<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Register Mie Rantau</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="Admin/vendors/feather/feather.css">
  <link rel="stylesheet" href="Admin/vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="Admin/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="Admin/vendors/typicons/typicons.css">
  <link rel="stylesheet" href="Admin/vendors/simple-line-icons/css/simple-line-icons.css">
  <link rel="stylesheet" href="Admin/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- inject:css -->
  <link rel="stylesheet" href="Admin/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="img/favicon.ico" />
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0/css/bootstrap.min.css">
</head>
<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo">
                  <h1><a href="index.html" class="text-danger">Mie <span class="text-warning">Rantau</span></a></h1>
              </div>
              <h4>Registrasi Pelanggan</h4>
              <form class="pt-3" method="POST" action="prosesRegister.jsp">
                <div class="form-group">
                  <input type="text" class="form-control form-control-lg" id="name" name="name" placeholder="Nama" required>
                </div>
                <div class="form-group">
                  <input type="email" class="form-control form-control-lg" id="email" name="email" placeholder="Email">
                </div>
                <div class="form-group">
                  <input type="date" class="form-control form-control-lg" id="tanggal_lahir" name="tanggal_lahir" placeholder="Tanggal Lahir">
                </div>
                <div class="form-group">
                  <input type="text" class="form-control form-control-lg" id="no_tlp" name="no_tlp" placeholder="No. Telepon">
                </div>
                <div class="form-group">
                  <textarea class="form-control form-control-lg" id="alamat" name="alamat" rows="3" placeholder="Alamat"></textarea>
                </div>
                <hr>
                <h4>Buat Username dan Password</h4>
                <div class="form-group">
                  <input type="text" class="form-control form-control-lg" id="username" name="username" placeholder="Username" required>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Password" required>
                    <button class="btn btn-outline-secondary" type="button" id="showHidePassword" onclick="togglePassword()">Show</button>
                  </div>
                </div>
                <div class="mt-3">
                  <button type="submit" class="btn btn-primary btn-lg font-weight-medium auth-form-btn">Daftar</button>
                </div>
                <div class="text-center mt-4 fw-light">
                  Sudah punya akun? <a href="login.jsp" class="text-primary">Login</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- JavaScript -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0/js/bootstrap.bundle.min.js"></script>
  <script>
    function togglePassword() {
      var passwordField = document.getElementById("password");
      var showHideButton = document.getElementById("showHidePassword");
      if (passwordField.type === "password") {
        passwordField.type = "text";
        showHideButton.textContent = "Hide";
      } else {
        passwordField.type = "password";
        showHideButton.textContent = "Show";
      }
    }
  </script>
</body>
</html>

    