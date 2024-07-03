<%-- 
    Document   : updateProduct
    Created on : 3 Jul 2024, 01.00.03
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    String nama = "", deskripsi = "", photo = "";
    BigDecimal harga = null;
    int jenis_id = 0;

    try {
        String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
        String usernameDB = "root";
        String passwordDB = "";

        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

        String query = "SELECT * FROM product WHERE id = ?";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, id);
        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            nama = resultSet.getString("nama");
            deskripsi = resultSet.getString("deskripsi");
            harga = resultSet.getBigDecimal("harga");
            jenis_id = resultSet.getInt("jenis_id");
            photo = resultSet.getString("photo");
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
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Produk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Update Produk</h1>
        <form action="updateProduct.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= id %>">
            <div class="mb-3">
                <label for="nama" class="form-label">Nama Produk</label>
                <input type="text" class="form-control" id="nama" name="nama" value="<%= nama %>" required>
            </div>
            <div class="mb-3">
                <label for="deskripsi" class="form-label">Deskripsi</label>
                <textarea class="form-control" id="deskripsi" name="deskripsi" required><%= deskripsi %></textarea>
            </div>
            <div class="mb-3">
                <label for="harga" class="form-label">Harga</label>
                <input type="number" class="form-control" id="harga" name="harga" value="<%= harga %>" required>
            </div>
            <div class="mb-3">
                <label for="jenis_id" class="form-label">Kategori</label>
                <select class="form-control" id="jenis_id" name="jenis_id" required>
                    <option value="1" <%= jenis_id == 1 ? "selected" : "" %>>Makanan</option>
                    <option value="2" <%= jenis_id == 2 ? "selected" : "" %>>Minuman</option>
                    <option value="3" <%= jenis_id == 3 ? "selected" : "" %>>Extra</option>
                    <option value="4" <%= jenis_id == 4 ? "selected" : "" %>>Dimsum</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="photo" class="form-label">Foto</label>
                <input type="file" class="form-control" id="photo" name="photo">
                <img src="images/<%= photo %>" alt="<%= nama %>" style="width:100px;">
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
</body>
</html>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        id = Integer.parseInt(request.getParameter("id"));
        nama = request.getParameter("nama");
        deskripsi = request.getParameter("deskripsi");
        harga = request.getParameter("harga");
        jenis_id = Integer.parseInt(request.getParameter("jenis_id"));
        Part filePart = request.getPart("photo");
        String newPhoto = filePart.getSubmittedFileName();

        connection = null;
        preparedStatement = null;

        try {
            String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
            String usernameDB = "root";
            String passwordDB = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

            String query = "UPDATE product SET nama = ?, deskripsi = ?, harga = ?, jenis_id = ?" + (newPhoto.isEmpty() ? "" : ", photo = ?") + " WHERE id = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, nama);
            preparedStatement.setString(2, deskripsi);
            preparedStatement.setBigDecimal(3, harga);
            preparedStatement.setInt(4, jenis_id);
            if (!newPhoto.isEmpty()) {
                preparedStatement.setString(5, newPhoto);
                preparedStatement.setInt(6, id);
            } else {
                preparedStatement.setInt(5, id);
            }
            preparedStatement.executeUpdate();

            if (!newPhoto.isEmpty()) {
                String uploadPath = getServletContext().getRealPath("") + "images";
                filePart.write(uploadPath + "/" + newPhoto);
            }

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

