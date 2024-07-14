<%-- 
    Document   : daftar-product
    Created on : 11 Jul 2024, 14.03.33
    Author     : Peno
--%>

<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.util.List"%>

<%!
    private void displayProductsByCategory(JspWriter out, String category) throws IOException {
        String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
        String usernameDB = "root";
        String passwordDB = "";

        String query = "SELECT product.*, jenis_produk.nama_jenis FROM product JOIN jenis_produk ON product.jenis_id = jenis_produk.id WHERE jenis_produk.nama_jenis = ?";

        try (Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, category);
            ResultSet resultSet = statement.executeQuery();

            if (!resultSet.isBeforeFirst()) {
                out.println("<div class='col-12 text-center'><p>No products found in " + category + "</p></div>");
            } else {
                while (resultSet.next()) {
                    out.println("<div class='col-sm-3 mb-3 mb-sm-0 mt-3'>");
                    out.println("<div class='card' style='width: 18rem;'>");

                    String photo = resultSet.getString("photo");
                    if (photo != null && !photo.isEmpty()) {
                        out.println("<img src='../Admin/" + photo + "' class='card-img-top' alt='" + resultSet.getString("nama") + "'>");
                    } else {
                        out.println("<img src='../Admin/' class='card-img-top' alt='No Image Available'>");
                    }

                    out.println("<div class='card-body'>");
                    out.println("<h5 class='card-title'>" + resultSet.getString("nama") + "</h5>");
                    out.println("<p class='card-text'>" + resultSet.getString("deskripsi") + "</p>");
                    out.println("<p class='card-text'>RP " + resultSet.getBigDecimal("harga") + "</p>");

                // Tambahkan form untuk menambahkan produk ke keranjang
                    out.println("<form action='keranjang.jsp' method='post'>");
                    out.println("<input type='hidden' name='product_id' value='" + resultSet.getInt("id") + "'>");
                    out.println("<input type='hidden' name='quantity' value='1'>");
                    out.println("<button href='keranjang.jsp' class='btn btn-primary'><i class='bi bi-cart-plus'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-cart-plus' viewBox='0 0 16 16'><path d='M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9z'/><path d='M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zm3.915 10L3.102 4h10.796l-1.313 7zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0'/></svg></i></button>");
                    out.println("</form>");

                    out.println("</div>");  // card-body
                    out.println("</div>");  // card
                    out.println("</div>");  // col-sm-3
                }
            }
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger' role='alert'>Error retrieving products: " + e.getMessage() + "</div>");
            e.printStackTrace();
        }
    }
%>

<div class="container kontak">
    <h1 class="container text-center">Menu</h1>
    
    <!-- Makanan -->
    <section class="container bg-body-secondary p-3 text-center text-md-start mt-5 mb-5">
        <h2>Makanan</h2>
        <div class="container">
            <div class="row">
                <%
                    displayProductsByCategory(out, "Makanan");
                %>
            </div>
        </div>
    </section>
    
    <!-- Minuman -->
    <section class="container bg-body-secondary p-3 text-center text-md-start mt-5 mb-5">
        <h2>Minuman</h2>
        <div class="container">
            <div class="row">
                <%
                    displayProductsByCategory(out, "Minuman");
                %>
            </div>
        </div>
    </section>
    
    <!-- Ekstra -->
    <section class="container bg-body-secondary p-3 text-center text-md-start mt-5 mb-5">
        <h2>Extra</h2>
        <div class="container">
            <div class="row">
                <%
                    displayProductsByCategory(out, "Extra");
                %>
            </div>
        </div>
    </section>
    
    <!-- Dimsum -->
    <section class="container bg-body-secondary p-3 text-center text-md-start mt-5 mb-5">
        <h2>Dimsum</h2>
        <div class="container">
            <div class="row">
                <%
                    displayProductsByCategory(out, "Dimsum");
                %>
            </div>
        </div>
    </section>
</div>

<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<!-- Include Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
