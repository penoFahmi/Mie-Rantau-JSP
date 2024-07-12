<%-- 
    Document   : donat-product
    Created on : 11 Jul 2024, 21.23.16
    Author     : Peno
--%>

<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Mendefinisikan koneksi JDBC
    String url = "jdbc:mysql://localhost/mie_rantau_jsp";
    String username = "root";
    String password = "";
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    List<String> jenisProdukLabels = new ArrayList<>();
    List<Integer> jenisProdukData = new ArrayList<>();
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        
        // Query untuk mengambil data dari tabel jenis_produk
        String query = "SELECT nama_jenis, COUNT(*) AS jumlah FROM jenis_produk JOIN product ON jenis_produk.id = product.jenis_id GROUP BY nama_jenis";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        
        // Memasukkan hasil query ke dalam list untuk labels dan data
        while (rs.next()) {
            jenisProdukLabels.add(rs.getString("nama_jenis"));
            jenisProdukData.add(rs.getInt("jumlah"));
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Menutup koneksi dan statement
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
        if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignored */ }
    }
%>

<div class="content-wrapper">
    <div class="col-lg-6 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Doughnut chart</h4>
                <canvas id="doughnutChart"></canvas>
            </div>
        </div>
    </div>
</div>

<script>
    'use strict';

    // Data dari JSP
    var labels = <%= new Gson().toJson(jenisProdukLabels) %>;
    var data = <%= new Gson().toJson(jenisProdukData) %>;

    var doughnutPieData = {
        datasets: [{
            data: data,
            backgroundColor: [
                'rgba(255, 99, 132, 0.5)',
                'rgba(54, 162, 235, 0.5)',
                'rgba(255, 206, 86, 0.5)',
                'rgba(75, 192, 192, 0.5)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
            ],
        }],

        labels: labels
    };

    var doughnutPieOptions = {
        responsive: true,
        animation: {
            animateScale: true,
            animateRotate: true
        }
    };

    // Inisialisasi chart doughnut
    var doughnutChartCanvas = document.getElementById("doughnutChart").getContext("2d");
    var doughnutChart = new Chart(doughnutChartCanvas, {
        type: 'doughnut',
        data: doughnutPieData,
        options: doughnutPieOptions
    });
</script>

