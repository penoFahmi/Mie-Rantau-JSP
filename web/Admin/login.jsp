<%-- 
    Document   : login.jsp
    Created on : 3 Jul 2024, 00.04.50
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>


<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
            String usernameDB = "root";
            String passwordDB = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

            String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Gunakan session yang sudah ada
                session.setAttribute("username", username);
%>
                <!-- Modal untuk login berhasil -->
                <div class="modal fade" id="loginSuccessModal" tabindex="-1" aria-labelledby="loginSuccessModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="loginSuccessModalLabel">Login Berhasil</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Selamat datang, <%= username %>! Anda berhasil login.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick="window.location.href='admin.jsp'">OK</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Modal -->

                <!-- Script untuk menampilkan modal secara otomatis -->
                <script>
                    $(document).ready(function() {
                        $('#loginSuccessModal').modal('show');
                    });
                </script>
<%
                // Redirect ke halaman admin setelah menampilkan modal
                response.sendRedirect("admin.jsp");
                return;
            } else {
                // Jika login gagal, redirect dengan parameter error
                response.sendRedirect("login.jsp?error=1");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Admin Login</h1>
        <form action="login.jsp" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" required>
                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">Show</button>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
            <%
                if (request.getParameter("error") != null) {
                    out.println("<div class='mt-3 alert alert-danger'>Username atau password salah.</div>");
                }
            %>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Script untuk toggle show/hide password
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
