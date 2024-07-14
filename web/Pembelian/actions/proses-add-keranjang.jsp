<%-- 
    Document   : proses-add-keranjang
    Created on : 13 Jul 2024, 23.21.35
    Author     : Peno
--%>

<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<section class="container bg-body-secondary p-3 text-center text-md-start mt-5 mb-5">
    <h2>Daftar Pesanan</h2>
    <div class="container">
        <div class="row">
<%
    String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
    String usernameDB = "root";
    String passwordDB = "";

    // Get the product_id and quantity from the request
    String productId = request.getParameter("product_id");
    String quantity = request.getParameter("quantity");

    // Get user_id from session
    Integer userId = (Integer) session.getAttribute("user_id");

    // Check if user_id is null (not logged in)
    if (userId == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
        return;
    }

    String message = "";
    try (Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB)) {

        // Insert the product into the keranjang table
        if (productId != null && quantity != null) {
            String insertQuery = "INSERT INTO keranjang (product_id, user_id, quantity) VALUES (?, ?, ?)";
            try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                insertStatement.setInt(1, Integer.parseInt(productId));
                insertStatement.setInt(2, userId);
                insertStatement.setInt(3, Integer.parseInt(quantity));
                insertStatement.executeUpdate();
                message = "Product added to cart successfully!";
            }
        }

        // Fetch the cart data for the logged-in user
        String selectQuery = "SELECT k.id, p.nama, k.quantity, p.harga, (k.quantity * p.harga) as total FROM keranjang k JOIN product p ON k.product_id = p.id WHERE k.user_id = ?";
        try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery)) {
            selectStatement.setInt(1, userId);
            ResultSet resultSet = selectStatement.executeQuery();

            out.println("<h3>Pesanan kamu saat ini</h3>");
            if (!message.isEmpty()) {
                out.println("<div class='alert alert-success' role='alert'>" + message + "</div>");
            }

            out.println("<table class='table'>");
            out.println("<thead><tr><th>Product</th><th>Jumlah</th><th>Price</th><th>Total</th><th>Edit</th></tr></thead>");
            out.println("<tbody>");
            while (resultSet.next()) {
                out.println("<tr>");
                out.println("<td>" + resultSet.getString("nama") + "</td>");
                out.println("<td>" + resultSet.getInt("quantity") + "</td>");
                out.println("<td>RP " + resultSet.getBigDecimal("harga") + "</td>");
                out.println("<td>RP " + resultSet.getBigDecimal("total") + "</td>");
                out.println("<td>");
                out.println("<button class='btn btn-primary mr-2' onclick='updateQuantity(" + resultSet.getInt("id") + ", " + resultSet.getInt("quantity") + ")'>Update</button>");
                out.println("<button class='btn btn-danger' onclick='deleteItem(" + resultSet.getInt("id") + ")'>Hapus</button>");
                out.println("</td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        }

    } catch (SQLException e) {
        out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    }
%>

        </div>
    </div>
</section>

<section class="container bg-body-secondary p-3 text-center text-md-start mt-5 mb-5">
    <h2>Status Pesanan</h2>
    <div class="container">
        <div class="row">
            
        </div>
    </div>
</section>

<section class="container bg-body-secondary p-3 text-center text-md-start mt-5 mb-5">
    <h2>Riwayat Pesanan</h2>
    <div class="container">
        <div class="row">
            
        </div>
    </div>
</section>

<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<!-- Include Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

<script>
    function updateQuantity(cartId, currentQuantity) {
        let newQuantity = prompt("Masukkan jumlah baru:", currentQuantity);
        if (newQuantity != null) {
            window.location.href = "proses-update-keranjang.jsp?cart_id=" + cartId + "&quantity=" + newQuantity;
        }
    }

    function deleteItem(cartId) {
        if (confirm("Apakah Anda yakin ingin menghapus item ini dari keranjang?")) {
            window.location.href = "proses-delete-keranjang.jsp?cart_id=" + cartId;
        }
    }
</script>
