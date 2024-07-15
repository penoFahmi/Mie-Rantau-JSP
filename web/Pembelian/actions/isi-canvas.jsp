<%-- 
    Document   : isi-canvas
    Created on : 14 Jul 2024, 17.54.29
    Author     : Peno
--%>


<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

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
        String selectQuery = "SELECT k.id, p.nama, p.photo, k.quantity, p.harga, (k.quantity * p.harga) as total FROM keranjang k JOIN product p ON k.product_id = p.id WHERE k.user_id = ?";
        try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery)) {
            selectStatement.setInt(1, userId);
            ResultSet resultSet = selectStatement.executeQuery();

            if (!message.isEmpty()) {
                out.println("<div class='alert alert-success' role='alert'>" + message + "</div>");
            }

            // Begin list instead of table
            out.println("<ul class='list-group'>");
            while (resultSet.next()) {
                out.println("<li class='list-group-item'>");
                out.println("<div class='row align-items-center'>");

                String gambar = resultSet.getString("photo");
                if (gambar != null && !gambar.isEmpty()) {
                    out.println("<div class='col-3'><img src='../Admin/" + gambar + "' alt='" + resultSet.getString("nama") + "' class='img-thumbnail' style='max-width: 100px;'></div>");
                }

                out.println("<div class='col-3'>" + resultSet.getString("nama") + "</div>");
                out.println("<div class='col-2'>Jumlah: " + resultSet.getInt("quantity") + "</div>");
                out.println("<div class='col-2'>Harga: RP " + resultSet.getBigDecimal("harga") + "</div>");
                out.println("<div class='col-2'>Total: RP " + resultSet.getBigDecimal("total") + "</div>");
                out.println("<div class='col-auto'>");
                out.println("<button class='btn btn-primary btn-sm mr-2' onclick='updateQuantity(" + resultSet.getInt("id") + ", " + resultSet.getInt("quantity") + ")'>+</button>");
                out.println("<button class='btn btn-danger btn-sm' onclick='deleteItem(" + resultSet.getInt("id") + ")'>-</button>");
                out.println("</div>");
                out.println("</div>");
                out.println("</li>");
            }
            out.println("</ul>");
        }

    } catch (SQLException e) {
        out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    }
%>

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
