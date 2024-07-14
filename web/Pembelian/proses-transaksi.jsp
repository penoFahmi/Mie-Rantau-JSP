<%-- 
    Document   : transaksi
    Created on : 15 Jul 2024, 02.39.07
    Author     : Peno
--%>

<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

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

    String message = "";
    Connection connection = null;
    PreparedStatement insertTransaksiStmt = null;
    PreparedStatement deleteKeranjangStmt = null;

    try {
        connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
        connection.setAutoCommit(false); // Start transaction

        // Insert into transactions table
        String insertTransaksiSQL = "INSERT INTO transactions (customer_name, quantity, total_price, user_id, product_id, transaction_date) " +
                                    "SELECT ?, k.quantity, (k.quantity * p.harga), ?, k.product_id, NOW() " +
                                    "FROM keranjang k JOIN product p ON k.product_id = p.id WHERE k.user_id = ?";
        insertTransaksiStmt = connection.prepareStatement(insertTransaksiSQL);
        
        // Assuming customer name is obtained from the session or a form
        String customerName = "Customer Name";  // Replace with actual customer name
        insertTransaksiStmt.setString(1, customerName);
        insertTransaksiStmt.setInt(2, userId);
        insertTransaksiStmt.setInt(3, userId);

        insertTransaksiStmt.executeUpdate();

        // Clear the cart
        String deleteKeranjangSQL = "DELETE FROM keranjang WHERE user_id = ?";
        deleteKeranjangStmt = connection.prepareStatement(deleteKeranjangSQL);
        deleteKeranjangStmt.setInt(1, userId);
        deleteKeranjangStmt.executeUpdate();

        connection.commit(); // Commit transaction
        message = "Transaction successful!";

    } catch (SQLException e) {
        if (connection != null) {
            try {
                connection.rollback(); // Rollback transaction on error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    } finally {
        if (insertTransaksiStmt != null) {
            try {
                insertTransaksiStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (deleteKeranjangStmt != null) {
            try {
                deleteKeranjangStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Redirect back to the menu page or display a message
    if (!message.isEmpty()) {
        session.setAttribute("message", message);
    }
    response.sendRedirect("menu.jsp");
%>
