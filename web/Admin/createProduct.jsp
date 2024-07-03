<%-- 
    Document   : createProduct
    Created on : 3 Jul 2024, 00.59.07
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.Part" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tambah Produk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            var jenis_id = document.getElementById("jenis_id").value;
            if (jenis_id === "") {
                alert("Pilih kategori produk.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Tambah Produk</h1>
        <form action="createProduct.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="mb-3">
                <label for="nama" class="form-label">Nama Produk</label>
                <input type="text" class="form-control" id="nama" name="nama" required>
            </div>
            <div class="mb-3">
                <label for="deskripsi" class="form-label">Deskripsi</label>
                <textarea class="form-control" id="deskripsi" name="deskripsi" required></textarea>
            </div>
            <div class="mb-3">
                <label for="harga" class="form-label">Harga</label>
                <input type="number" class="form-control" id="harga" name="harga" required>
            </div>
            <div class="mb-3">
                <label for="jenis_id" class="form-label">Kategori</label>
                <select class="form-control" id="jenis_id" name="jenis_id" required>
                    <option value="">Pilih Kategori</option>
                    <option value="1">Makanan</option>
                    <option value="2">Minuman</option>
                    <option value="3">Extra</option>
                    <option value="4">Dimsum</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="photo" class="form-label">Foto</label>
                <input type="file" class="form-control" id="photo" name="photo">
            </div>
            <button type="submit" class="btn btn-primary">Tambah</button>
        </form>
    </div>
</body>
</html>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nama = request.getParameter("nama");
        String deskripsi = request.getParameter("deskripsi");
        String harga = request.getParameter("harga");
        String jenis_id_str = request.getParameter("jenis_id");
        int jenis_id = 0;

        if (jenis_id_str != null && !jenis_id_str.isEmpty()) {
            jenis_id = Integer.parseInt(jenis_id_str);
        }

        Part filePart = request.getPart("photo");
        String photo = filePart.getSubmittedFileName();

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
            String usernameDB = "root";
            String passwordDB = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

            String query = "INSERT INTO product (nama, deskripsi, harga, jenis_id, photo) VALUES (?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(query);
            
            preparedStatement.setString(1, nama);
            preparedStatement.setString(2, deskripsi);
            preparedStatement.setString(3, harga);
            preparedStatement.setInt(4, jenis_id);
            preparedStatement.setString(5, photo);
            
            preparedStatement.executeUpdate();

            String uploadPath = getServletContext().getRealPath("") + "images";
            filePart.write(uploadPath + "/" + photo);

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
