<%-- 
    Document   : admin
    Created on : 3 Jul 2024, 00.18.00
    Author     : Peno
--%>

<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Periksa sesi
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Welcome, <%= username %>!</h1>
        <h2>Product Management</h2>
        <%
            displayProducts(out, "SELECT p.id, p.nama, p.deskripsi, p.harga, p.photo, j.nama_jenis FROM product p JOIN jenis_produk j ON p.jenis_id = j.id");
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%! 
    private void displayProducts(JspWriter out, String query) throws IOException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            String connectionURL = "jdbc:mysql://localhost/mie_rantau";
            String usernameDB = "root";
            String passwordDB = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);

            out.println("<table class='table'>");
            out.println("<thead>");
            out.println("<tr>");
            out.println("<th>Nama</th>");
            out.println("<th>Deskripsi</th>");
            out.println("<th>Harga</th>");
            out.println("<th>Foto</th>");
            out.println("<th>Kategori</th>");
            out.println("<th>Actions</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");

            while (resultSet.next()) {
                out.println("<tr>");
                out.println("<td>" + resultSet.getString("nama") + "</td>");
                out.println("<td>" + resultSet.getString("deskripsi") + "</td>");
                out.println("<td>" + resultSet.getBigDecimal("harga") + "</td>");
                out.println("<td><img src='images/" + resultSet.getString("photo") + "' alt='" + resultSet.getString("nama") + "' style='width:100px;'/></td>");
                out.println("<td>" + resultSet.getString("nama_jenis") + "</td>");
                out.println("<td><a href='editProduct.jsp?id=" + resultSet.getInt("id") + "' class='btn btn-warning'>Edit</a> <a href='deleteProduct.jsp?id=" + resultSet.getInt("id") + "' class='btn btn-danger'>Delete</a></td>");
                out.println("</tr>");
            }

            out.println("</tbody>");
            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>


