<%-- 
    Document   : proses-update-keranjang
    Created on : 14 Jul 2024, 11.12.01
    Author     : Peno
--%>

<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
    String usernameDB = "root";
    String passwordDB = "";

    // Get the cart_id and new quantity from the request
    String cartId = request.getParameter("cart_id");
    String newQuantity = request.getParameter("quantity");

    // Get user_id from session
    Integer userId = (Integer) session.getAttribute("user_id");

    // Check if user_id is null (not logged in)
    if (userId == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
        return;
    }

    String message = "";
    try (Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB)) {

        // Update the quantity of the product in the keranjang table
        if (cartId != null && newQuantity != null) {
            String updateQuery = "UPDATE keranjang SET quantity = ? WHERE id = ? AND user_id = ?";
            try (PreparedStatement updateStatement = connection.prepareStatement(updateQuery)) {
                updateStatement.setInt(1, Integer.parseInt(newQuantity));
                updateStatement.setInt(2, Integer.parseInt(cartId));
                updateStatement.setInt(3, userId);
                int rowsAffected = updateStatement.executeUpdate();
                if (rowsAffected > 0) {
                    message = "Quantity updated successfully!";
                } else {
                    message = "Failed to update quantity!";
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
