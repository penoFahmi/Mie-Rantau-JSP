<%-- 
    Document   : table-pelanggan
    Created on : 11 Jul 2024, 12.35.36
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String url = "jdbc:mysql://localhost/mie_rantau_jsp";
    String username = "root";
    String password = "";
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);
        statement = connection.createStatement();
        String query = "SELECT * FROM pelanggan";
        resultSet = statement.executeQuery(query);
%>  <div class="content-wrapper">
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Data Pelanggan</h4>
                        <p class="card-description">
                            Data lengkap pelanggan terdaftar
                        </p>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th> Nama </th>
                                        <th> Email </th>
                                        <th> Tanggal Lahir </th>
                                        <th> No. Telepon </th>
                                        <th> Alamat </th>
                                    </tr>
                                </thead>
                                <tbody>
<%
        while (resultSet.next()) {
%>
                                    <tr>
                                        <td> <%= resultSet.getString("name") %> </td>
                                        <td> <%= resultSet.getString("email") %> </td>
                                        <td> <%= resultSet.getDate("tanggal_lahir") %> </td>
                                        <td> <%= resultSet.getString("no_tlp") %> </td>
                                        <td> <%= resultSet.getString("alamat") %> </td>
                                    </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (statement != null) statement.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%
%>
