<%-- 
    Document   : data-admin
    Created on : 11 Jul 2024, 10.39.10
    Author     : Peno
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*"%>

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
        String query = "SELECT * FROM admins"; 
        resultSet = statement.executeQuery(query); 
%>
<div class="content-wrapper">
    <div class="row">
        <div class="grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Data Admin</h4>
                    <p class="card-description">Selamat datang....</p>
                    <div class="forms-sample">
                        <% 
                            while(resultSet.next()) { 
                                String id = resultSet.getString("id");
                                String nama = resultSet.getString("nama");
                                String email = resultSet.getString("email");
                                String tanggal_lahir = resultSet.getString("tanggal_lahir");
                                String no_telepon = resultSet.getString("no_tlp");
                                String alamat = resultSet.getString("alamat");
                        %>
                        <div class="form-group">
                            <label for="exampleInputUsername1">Nama</label>
                            <input type="text" class="form-control" id="exampleInputUsername1" value="<%= nama %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" value="<%= email %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputTanggalLahir1">Tanggal Lahir</label>
                            <input type="text" class="form-control" id="exampleInputTanggalLahir1" value="<%= tanggal_lahir %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputNoTelepon1">No Telepon</label>
                            <input type="text" class="form-control" id="exampleInputNoTelepon1" value="<%= no_telepon %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputAlamat1">Alamat</label>
                            <input type="text" class="form-control" id="exampleInputAlamat1" value="<%= alamat %>" readonly>
                        </div>
                        <form action="updateAdmin.jsp" method="get">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit" class="btn btn-primary me-2">Edit</button>
                        </form>
                        <hr>
                        <% 
                            } 
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
        resultSet.close(); 
        statement.close(); 
        connection.close();
    } catch(Exception e) {
        out.println(e.getMessage());
    }       
%>
