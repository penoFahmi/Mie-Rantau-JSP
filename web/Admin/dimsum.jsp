<%-- 
    Document   : dimsum
    Created on : 3 Jul 2024, 00.26.09
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    /*
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    */
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Dimsum</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <h1 class="mt-4 text-center">Mie Rantau - Admin</h1>
        <h2 class="m-3">Dimsum</h2>
        <a href="createDimsum.jsp" type="button" class="m-3 btn btn-primary">Tambah</a>
        <div class="d-flex justify-content-center">
            <table class="table table-shadow-lg table-striped">
                <thead>
                    <tr class="table-primary">
                        <th scope="col">Nama</th>
                        <th scope="col">Deskripsi</th>
                        <th scope="col">Harga</th>
                        <th scope="col">Foto</th>
                        <th scope="col">Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection connection = null;
                        Statement statement = null;
                        ResultSet resultSet = null;

                        try {
                            String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
                            String usernameDB = "root";
                            String passwordDB = "";

                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
                            statement = connection.createStatement();
                            String query = "SELECT * FROM product WHERE jenis_id = (SELECT id FROM jenis_produk WHERE nama_jenis = 'dimsum')";
                            resultSet = statement.executeQuery(query);

                            while (resultSet.next()) {
                    %>
                        <tr>
                            <td><%= resultSet.getString("nama") %></td>
                            <td><%= resultSet.getString("deskripsi") %></td>
                            <td>RP <%= resultSet.getBigDecimal("harga") %></td>
                            <td><img src="images/<%= resultSet.getString("photo") %>" alt="<%= resultSet.getString("nama") %>" style="width:100px;"/></td>
                            <td>
                                <div class="d-flex">
                                    <a href="deleteProduct.jsp?ID=<%= resultSet.getInt("id") %>" class="btn btn-danger">Delete</a>
                                    <a href="updateProduct.jsp?ID=<%= resultSet.getInt("id") %>" class="btn btn-warning">Update</a>
                                </div>
                            </td>
                        </tr>
                    <%
                            }
                            resultSet.close();
                            statement.close();
                            connection.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

