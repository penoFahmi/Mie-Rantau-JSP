<%-- 
    Document   : table-pembelian
    Created on : 14 Jul 2024, 09.18.44
    Author     : Peno
--%>
<%--
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
        
        // Query untuk join tabel transactions dengan users dan product, termasuk harga dan total
        String query = "SELECT t.id, u.username, p.nama AS product_name, p.harga, t.quantity, t.total_price AS total " +
                       "FROM transactions t " +
                       "JOIN users u ON t.user_id = u.id " +
                       "JOIN product p ON t.product_id = p.id";
        resultSet = statement.executeQuery(query);
%> 
<!DOCTYPE html>

<div class="content-wrapper">
    <div class="row">
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Pembelian</h4>
                    <p class="card-description">
                        Riwayat Pembelian Pelanggan
                    </p>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID Transaksi</th>
                                    <th>Username</th>
                                    <th>Product Name</th>
                                    <th>Harga</th>
                                    <th>Jumlah</th>
                                    <th>Total</th>
                                    <th>Tindakan</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (resultSet.next()) {
                                %>
                                <tr>
                                    <td><%= resultSet.getString("id") %></td>
                                    <td><%= resultSet.getString("username") %></td>
                                    <td><%= resultSet.getString("product_name") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("harga") %></td>
                                    <td><%= resultSet.getInt("quantity") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("total") %></td>
                                   
                                    <td>
                                        <button type="button" class="btn btn-primary btn-rounded btn-fw">Cetak</button>
                                    </td>
                                    
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
--%>

<%--
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*, javax.servlet.http.*" %>
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
        
        // Query untuk join tabel transactions dengan users dan product, termasuk harga dan total
        String query = "SELECT t.id, u.username, p.nama AS product_name, p.harga, t.quantity, t.total_price AS total " +
                       "FROM transactions t " +
                       "JOIN users u ON t.user_id = u.id " +
                       "JOIN product p ON t.product_id = p.id";
        resultSet = statement.executeQuery(query);
%> 
<!DOCTYPE html>

<div class="content-wrapper">
    <div class="row">
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Pembelian</h4>
                    <p class="card-description">
                        Riwayat Pembelian Pelanggan
                    </p>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID Transaksi</th>
                                    <th>Username</th>
                                    <th>Product Name</th>
                                    <th>Harga</th>
                                    <th>Jumlah</th>
                                    <th>Total</th>
                                    <th>Tindakan</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (resultSet.next()) {
                                %>
                                <tr>
                                    <td><%= resultSet.getString("id") %></td>
                                    <td><%= resultSet.getString("username") %></td>
                                    <td><%= resultSet.getString("product_name") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("harga") %></td>
                                    <td><%= resultSet.getInt("quantity") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("total") %></td>
                                   
                                    <td>
                                        <button type="button" class="btn btn-primary btn-rounded btn-fw" onclick="openBillingModal('<%= resultSet.getString("id") %>')">Cetak</button>
                                    </td>
                                    
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

<!-- Modal Billing -->
<div class="modal fade" id="billingModal" tabindex="-1" role="dialog" aria-labelledby="billingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="billingModalLabel">Tagihan Transaksi</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="billingModalBody">
                <!-- Isi modal billing akan di-update melalui JavaScript -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="saveToPDF()">Save to PDF</button>
            </div>
        </div>
    </div>
</div>

<script>
    function openBillingModal(transactionId) {
        // Ambil data transaksi berdasarkan ID
        fetch('getTransactionDetails.jsp?id=' + transactionId)
            .then(response => response.text())
            .then(data => {
                document.getElementById('billingModalBody').innerHTML = data;
                $('#billingModal').modal('show');
            })
            .catch(error => console.error('Error:', error));
    }

    function saveToPDF() {
        // Mendapatkan content modal billing
        var content = document.getElementById('billingModalBody').innerHTML;

        // Membuat dokumen PDF baru
        var doc = new jsPDF();

        // Menambahkan content ke PDF
        doc.fromHTML(content, 15, 15);

        // Simpan PDF
        doc.save('tagihan.pdf');
    }
</script>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*, javax.servlet.http.*" %>
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
        
        // Query untuk join tabel transactions dengan users dan product, termasuk harga dan total
        String query = "SELECT t.id, u.username, p.nama AS product_name, p.harga, t.quantity, t.total_price AS total " +
                       "FROM transactions t " +
                       "JOIN users u ON t.user_id = u.id " +
                       "JOIN product p ON t.product_id = p.id";
        resultSet = statement.executeQuery(query);
%> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Riwayat Pembelian Pelanggan</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="content-wrapper">
    <div class="row">
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Pembelian</h4>
                    <p class="card-description">
                        Riwayat Pembelian Pelanggan
                    </p>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID Transaksi</th>
                                    <th>Username</th>
                                    <th>Product Name</th>
                                    <th>Harga</th>
                                    <th>Jumlah</th>
                                    <th>Total</th>
                                    <th>Tindakan</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (resultSet.next()) {
                                %>
                                <tr>
                                    <td><%= resultSet.getString("id") %></td>
                                    <td><%= resultSet.getString("username") %></td>
                                    <td><%= resultSet.getString("product_name") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("harga") %></td>
                                    <td><%= resultSet.getInt("quantity") %></td>
                                    <td>RP <%= resultSet.getBigDecimal("total") %></td>
                                   
                                    <td>
                                        <button type="button" class="btn btn-primary btn-rounded btn-fw" onclick="openBillingModal('<%= resultSet.getString("id") %>')">Cetak</button>
                                    </td>
                                    
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

<!-- Modal Billing -->
<div class="modal fade" id="billingModal" tabindex="-1" role="dialog" aria-labelledby="billingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="billingModalLabel">Tagihan Transaksi</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="billingModalBody">
                <!-- Isi modal billing akan di-update melalui JavaScript -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="saveToPDF()">Ok</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- jsPDF -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>

<script>
    function openBillingModal(transactionId) {
        // Ambil data transaksi berdasarkan ID
        fetch('getTransactionDetails.jsp?id=' + transactionId)
            .then(response => response.text())
            .then(data => {
                document.getElementById('billingModalBody').innerHTML = data;
                $('#billingModal').modal('show');
            })
            .catch(error => console.error('Error:', error));
    }

    function saveToPDF() {
        // Mendapatkan content modal billing
        var content = document.getElementById('billingModalBody').innerHTML;

        // Membuat dokumen PDF baru
        var doc = new jsPDF();

        // Menambahkan content ke PDF
        doc.fromHTML(content, 15, 15);

        // Simpan PDF
        doc.save('tagihan.pdf');
    }
</script>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
