<%-- 
    Document   : login
    Created on : 5 Jul 2024, 23.52.55
    Author     : Peno
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Login Mie Rantau</title>
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
                  <h1><a href="index.html">Mie Rantau</a></h1>
              </div>
              <h4>Selamat datang di mie rantau</h4>
              <h6 class="fw-light">login untuk melanjutkan.</h6>
              <form class="pt-3" method="POST" action="login.jsp">
               <%-- 
                <%@ page session="true" %>
                <% 
                    String errorMessage = "";
                    if (session.getAttribute("username") != null && session.getAttribute("role_id") != null) {
                        int role_id = (Integer) session.getAttribute("role_id");
                        switch (role_id) {
                            case 1:
                                response.sendRedirect("SuperAdmin/dashboard.jsp");
                                break;
                            case 2:
                                response.sendRedirect("Admin/dashboard.jsp");
                                break;
                            case 3:
                                response.sendRedirect("index.jsp");
                                break;
                            default:
                                out.println("Unknown role");
                                break;
                        }
                    } else {
                        String username = request.getParameter("username");
                        String password = request.getParameter("password");

                        if (username != null && password != null) {
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "");

                                String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                                PreparedStatement preparedStatement = connection.prepareStatement(query);
                                preparedStatement.setString(1, username);
                                preparedStatement.setString(2, password);

                                ResultSet resultSet = preparedStatement.executeQuery();

                                if (resultSet.next()) {
                                    session.setAttribute("username", username);
                                    session.setAttribute("role_id", resultSet.getInt("role_id"));

                                    int role_id = resultSet.getInt("role_id");
                                    switch (role_id) {
                                        case 1:
                                            response.sendRedirect("SuperAdmin/dashboard.jsp");
                                            break;
                                        case 2:
                                            response.sendRedirect("Admin/dashboard.jsp");
                                            break;
                                        case 3:
                                            response.sendRedirect("index.jsp");
                                            break;
                                        default:
                                            response.sendRedirect("index.jsp");
                                            break;
                                    }
                                } else {
                                    errorMessage = "Username atau password salah. Silakan coba lagi.";
                                }

                                resultSet.close();
                                preparedStatement.close();
                                connection.close();
                            } catch (Exception e) {
                                out.println(e.getMessage());
                            }
                        }
                    }
                %> 
               --%>
               <!-- Login Logika ke 2 -->
               
                <%@ page session="true" %>
                <% 
                    String errorMessage = "";
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");

                    if (username != null && password != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "");

                            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                            PreparedStatement preparedStatement = connection.prepareStatement(query);
                            preparedStatement.setString(1, username);
                            preparedStatement.setString(2, password);

                            ResultSet resultSet = preparedStatement.executeQuery();

                            if (resultSet.next()) {
                                int role_id = resultSet.getInt("role_id");
                                session.setAttribute("username", username);
                                session.setAttribute("role_id", role_id);

                                String redirectUrl = "";
                                switch (role_id) {
                                    case 1:
                                        redirectUrl = "SuperAdmin/dashboard.jsp";
                                        break;
                                    case 2:
                                        redirectUrl = "Admin/dashboard.jsp";
                                        break;
                                    case 3:
                                        redirectUrl = "Pembelian/menu.jsp";
                                        break;
                                    default:
                                        redirectUrl = "Pembelian/menu.jsp";
                                        break;
                                }
                                response.sendRedirect(redirectUrl);
                            } else {
                                errorMessage = "Username atau password salah. Silakan coba lagi.";
                            }

                            resultSet.close();
                            preparedStatement.close();
                            connection.close();
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                    }
                %>
                <div class="form-group">
                  <input type="text" class="form-control form-control-lg" id="username" name="username" placeholder="Username">
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Password">
                    <button class="btn btn-outline-secondary" type="button" id="showHidePassword" onclick="togglePassword()">Show</button>
                  </div>
                </div>
                <div class="mt-3">
                  <button type="submit" class="btn btn-primary btn-lg font-weight-medium auth-form-btn">Masuk</button>
                </div>
                <div class="text-center mt-4 fw-light">
                  Don't have an account? <a href="register.jsp" class="text-primary">Create</a>
                </div>
                <% if (!errorMessage.isEmpty()) { %>
                  <script>
                    document.addEventListener("DOMContentLoaded", function(){
                      var errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
                      errorModal.show();
                    });
                  </script>
                <% } %>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>

  <!-- Modal -->
  <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="errorModalLabel">Login Error</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <%= errorMessage %>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="Admin/vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- inject:js -->
  <script src="Admin/js/off-canvas.js"></script>
  <script src="Admin/js/hoverable-collapse.js"></script>
  <script src="Admin/js/template.js"></script>
  <script src="Admin/js/settings.js"></script>
  <script src="Admin/js/todolist.js"></script>
  <!-- endinject -->
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0/js/bootstrap.min.js"></script>
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
    