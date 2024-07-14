<%-- 
    Document   : proses-delete-keranjang
    Created on : 14 Jul 2024, 11.25.37
    Author     : Peno
--%>

<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
    String usernameDB = "root";
    String passwordDB = "";

    // Get the cart_id from the request
    String cartId = request.getParameter("cart_id");

    // Get user_id from session
    Integer userId = (Integer) session.getAttribute("user_id");

    // Check if user_id is null (not logged in)
    if (userId == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
        return;
    }

    String message = "";
    try (Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB)) {

        // Delete the product from the keranjang table
        if (cartId != null) {
            String deleteQuery = "DELETE FROM keranjang WHERE id = ? AND user_id = ?";
            try (PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery)) {
                deleteStatement.setInt(1, Integer.parseInt(cartId));
                deleteStatement.setInt(2, userId);
                int rowsAffected = deleteStatement.executeUpdate();
                if (rowsAffected > 0) {
                    message = "Product removed from cart successfully!";
                } else {
                    message = "Failed to remove product from cart!";
                }
            }
        }

    } catch (SQLException e) {
        out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    }

    // Redirect back to the cart page or display a message
    if (!message.isEmpty()) {
        session.setAttribute("message", message);
    }
    response.sendRedirect("menu.jsp");
%>
