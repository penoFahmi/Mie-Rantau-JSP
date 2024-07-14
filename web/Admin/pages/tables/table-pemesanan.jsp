<%-- 
    Document   : table-pemesanan
    Created on : 14 Jul 2024, 03.01.01
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
        
        // Query untuk join tabel keranjang dengan users dan product, termasuk harga dan total
        String query = "SELECT k.id, u.username, p.nama AS product_name, p.harga, k.quantity, (p.harga * k.quantity) AS total " +
                       "FROM keranjang k " +
                       "JOIN users u ON k.user_id = u.id " +
                       "JOIN product p ON k.product_id = p.id";
        resultSet = statement.executeQuery(query);
%> 
<!DOCTYPE html>

<div class="content-wrapper">
    <div class="row">
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Pemesanan</h4>
                    <p class="card-description">
                        Daftar Pesanan Pelanggan
                    </p>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Product Name</th>
                                    <th>Harga</th>
                                    <th>Jumlah</th>
                                    <th>Total</th>
                                    <!--
                                    <th>Tindakan</th>
                                    -->
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (resultSet.next()) {
                                %>
                                <tr>
                                    <td><%= resultSet.getString("username") %></td>
                                    <td><%= resultSet.getString("product_name") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("harga") %></td>
                                    <td><%= resultSet.getInt("quantity") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("total") %></td>
                                    <!--
                                    <td>
                                        <button type="button" class="btn btn-primary btn-rounded btn-fw">Terima</button>
                                        <button type="button" class="btn btn-danger btn-rounded btn-fw">Tolak</button>
                                    </td>
                                    -->
                                </tr>
                                <%
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
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
