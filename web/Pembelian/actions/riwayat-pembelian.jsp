<%-- 
    Document   : riwayat-pembelian
    Created on : 15 Jul 2024, 11.01.38
    Author     : Peno
--%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>




        <!-- Check for success message -->
        <% 
            String message = (String) session.getAttribute("message");
            if (message != null && !message.isEmpty()) {
                out.println("<div class='alert alert-success' role='alert'>" + message + "</div>");
                session.removeAttribute("message");
            }
        %>

        <!-- Display transaction history -->
        <ul class="list-group">
            <% 
                String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
                String usernameDB = "root";
                String passwordDB = "";

                // Get user_id from session
                Integer userId = (Integer) session.getAttribute("user_id");

                // Check if user_id is null (not logged in)
                if (userId == null) {
                    response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
                    return;
                }

                try (Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB)) {
                    String selectQuery = "SELECT t.transaction_date, p.nama AS product_name, t.quantity, t.total_price " +
                                         "FROM transactions t " +
                                         "JOIN product p ON t.product_id = p.id " +
                                         "WHERE t.user_id = ?";
                    try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery)) {
                        selectStatement.setInt(1, userId);
                        ResultSet resultSet = selectStatement.executeQuery();

                        while (resultSet.next()) {
                            out.println("<li class='list-group-item'>");
                            out.println("Tanggal Transaksi: " + resultSet.getString("transaction_date") + "<br>");
                            out.println("Nama Produk: " + resultSet.getString("product_name") + "<br>");
                            out.println("Jumlah: " + resultSet.getInt("quantity") + "<br>");
                            out.println("Total Harga: RP " + resultSet.getBigDecimal("total_price") + "<br>");
                            out.println("</li>");
                        }
                    }
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
            %>
        </ul>

    <!-- Include Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

    <!-- JavaScript function to print -->
    <script>
        function print() {
            window.print();
        }
    </script>

