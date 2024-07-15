<%-- 
    Document   : getTransactionDetails
    Created on : 15 Jul 2024, 11.46.29
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String url = "jdbc:mysql://localhost/mie_rantau_jsp";
    String username = "root";
    String password = "";
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);
        
        // Ambil ID transaksi dari parameter GET
        String transactionId = request.getParameter("id");
        
        // Query untuk mengambil detail transaksi berdasarkan ID
        String query = "SELECT t.id, u.username, p.nama AS product_name, p.harga, t.quantity, t.total_price AS total " +
                       "FROM transactions t " +
                       "JOIN users u ON t.user_id = u.id " +
                       "JOIN product p ON t.product_id = p.id " +
                       "WHERE t.id = ?";
                       
        statement = connection.prepareStatement(query);
        statement.setString(1, transactionId);
        resultSet = statement.executeQuery();
        
        if (resultSet.next()) {
            // Menampilkan detail transaksi dalam format yang sesuai
%>
            <div>
                <h5>ID Transaksi: <%= resultSet.getString("id") %></h5>
                <p>Username: <%= resultSet.getString("username") %></p>
                <p>Product Name: <%= resultSet.getString("product_name") %></p>
                <p>Harga: RP <%= resultSet.getBigDecimal("harga") %></p>
                <p>Jumlah: <%= resultSet.getInt("quantity") %></p>
                <p>Total: RP <%= resultSet.getBigDecimal("total") %></p>
            </div>
<%
        } else {
%>
            <div>
                <p>Tidak ada data transaksi dengan ID <%= transactionId %></p>
            </div>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
