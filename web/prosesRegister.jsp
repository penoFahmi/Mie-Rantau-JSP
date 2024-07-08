<%-- 
    Document   : prosesRegister
    Created on : 8 Jul 2024, 12.44.43
    Author     : Peno
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Proses Registrasi</title>
</head>
<body>
    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String tanggal_lahir = request.getParameter("tanggal_lahir");
        String no_tlp = request.getParameter("no_tlp");
        String alamat = request.getParameter("alamat");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Diasumsikan input sudah divalidasi dan disaring

        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "");
            connection.setAutoCommit(false); // Mulai transaksi

            // Langkah 1: Masukkan ke dalam tabel users
            String insertUserQuery = "INSERT INTO users (username, password, role_id) VALUES (?, ?, ?)";
            PreparedStatement insertUserStatement = connection.prepareStatement(insertUserQuery, Statement.RETURN_GENERATED_KEYS);
            insertUserStatement.setString(1, username);
            insertUserStatement.setString(2, password);
            insertUserStatement.setInt(3, 3); // Asumsikan role_id 3 adalah untuk pelanggan

            int affectedRows = insertUserStatement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Gagal membuat pengguna, tidak ada baris yang terpengaruh.");
            }

            ResultSet generatedKeys = insertUserStatement.getGeneratedKeys();
            int userId = -1;
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("Gagal membuat pengguna, tidak ada ID yang diperoleh.");
            }

            // Langkah 2: Masukkan ke dalam tabel pelanggan
            String insertPelangganQuery = "INSERT INTO pelanggan (user_id, name, email, tanggal_lahir, no_tlp, alamat) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement insertPelangganStatement = connection.prepareStatement(insertPelangganQuery);
            insertPelangganStatement.setInt(1, userId);
            insertPelangganStatement.setString(2, name);
            insertPelangganStatement.setString(3, email);
            insertPelangganStatement.setString(4, tanggal_lahir);
            insertPelangganStatement.setString(5, no_tlp);
            insertPelangganStatement.setString(6, alamat);

            int pelangganAffectedRows = insertPelangganStatement.executeUpdate();
            if (pelangganAffectedRows == 0) {
                throw new SQLException("Gagal membuat pelanggan, tidak ada baris yang terpengaruh.");
            }

            // Commit transaksi jika semua penyisipan berhasil
            connection.commit();

            // Redirect atau tampilkan pesan sukses
            response.sendRedirect("login.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            out.println("Error: " + e.getMessage());
            // Lakukan rollback transaksi jika terjadi kesalahan
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                out.println("Error rollback: " + ex.getMessage());
            }
        } finally {
            // Tutup koneksi dan statement
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                out.println("Error tutup koneksi: " + ex.getMessage());
            }
        }
    %>
</body>
</html>
