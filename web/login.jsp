<%-- 
    Document   : login
    Created on : 5 Jul 2024, 23.52.55
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Required meta tags -->
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
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="Admin/vendors/select2/select2.min.css">
  <link rel="stylesheet" href="Admin/vendors/select2-bootstrap-theme/select2-bootstrap.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="Admin/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="Admin/images/favicon.png" />
</head>    

<body>
    <div class="container-scroller">
        <div class="container-fluid page-body-wrapper full-page-wrapper">
            <div class="content-wrapper d-flex align-items-center auth px-0">
                <div class="row w-100 mx-0">
                    <div class="col-lg-4 mx-auto">
                        <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                            <div class="brand-logo">
                                <h1>Mie Rantau</h1>
                            </div>
                            <h4>Hello! let's get started</h4>
                            <h6 class="fw-light">Sign in to continue.</h6>
                            <form class="pt-3" method="POST" action="LoginServlet">
                                <%@page session="true" %>
                                <% 
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
                                                // Handle unknown role or other cases
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
                                                    //HttpSession session = request.getSession();
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
                                                            // Handle unknown role or other cases
                                                            response.sendRedirect("index.jsp");
                                                            break;
                                                    }
                                                } else {
                                                    out.println("Invalid username or password");
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
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-lg" id="username" name="username" placeholder="Username">
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Password">
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">Show</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <button type="submit" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">Login</button>
                                </div>

                                <% if (request.getAttribute("error") != null) { %>
                                    <!-- Modal untuk login gagal -->
                                    <div class="modal fade" id="loginErrorModal" tabindex="-1" aria-labelledby="loginErrorModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="loginErrorModalLabel">Login Gagal</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    Username atau password salah.
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Script untuk menampilkan modal login gagal -->
                                    <script>
                                        $(document).ready(function() {
                                            $('#loginErrorModal').modal('show');
                                        });
                                    </script>
                                <% } %>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Your custom JavaScript -->
    <script>
        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#password');

        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.textContent = type === 'password' ? 'Show' : 'Hide';
        });
    </script>
</body>
</html>

