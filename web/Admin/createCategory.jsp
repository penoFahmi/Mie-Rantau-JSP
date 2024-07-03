<%-- 
    Document   : createCategory
    Created on : 3 Jul 2024, 00.59.07
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tambah Kategori</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Tambah Kategori</h1>
        <form action="createCategory.jsp" method="post">
            <div class="mb-3">
                <label for="nama" class="form-label">Nama Kategori</label>
                <input type="text" class="form-control" id="nama" name="nama" required>
            </div>
            <button type="submit" class="btn btn-primary">Tambah</button>
        </form>
    </div>
</body>
</html>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nama = request.getParameter("nama");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
            String usernameDB = "root";
            String passwordDB = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

            String query = "INSERT INTO jenis (nama) VALUES (?)";
            preparedStatement = connection.prepareStatement(query);
            
            preparedStatement.setString(1, nama);
            
            preparedStatement.executeUpdate();

            response.sendRedirect("admin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
