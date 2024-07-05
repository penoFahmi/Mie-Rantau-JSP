<%-- 
    Document   : table-product
    Created on : 6 Jul 2024, 04.05.34
    Author     : Peno
--%>

<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.util.List"%>


<%! 
    private void displayProducts(JspWriter out, String query) throws IOException {
        String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
        String usernameDB = "root";
        String passwordDB = "";

        try (Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            out.println("<div class='content-wrapper'>");
            out.println("<div class='row'>");
            out.println("<div class='col-lg-12 grid-margin stretch-card'>");
            out.println("<div class='card'>");
            out.println("<div class='card-body'>");
            out.println("<h4 class='card-title'>Striped Table</h4>");
            out.println("<p class='card-description'>Add class <code>.table-striped</code></p>");
            out.println("<div class='table-responsive'>");
            out.println("<table class='table table-striped'>");
            out.println("<thead>");
            out.println("<tr class='table-primary'>");
            out.println("<th scope='col'>Nama</th>");
            out.println("<th scope='col'>Deskripsi</th>");
            out.println("<th scope='col'>Harga</th>");
            out.println("<th scope='col'>Foto</th>");
            out.println("<th scope='col'>Kategori</th>");
            out.println("<th scope='col'>Edit</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");

            if (!resultSet.isBeforeFirst()) {
                out.println("<tr><td colspan='6' class='text-center'>No products found</td></tr>");
            } else {
                while (resultSet.next()) {
                    out.println("<tr>");
                    out.println("<td>" + resultSet.getString("nama") + "</td>");
                    out.println("<td>" + resultSet.getString("deskripsi") + "</td>");
                    out.println("<td>RP " + resultSet.getBigDecimal("harga") + "</td>");

                    String photo = resultSet.getString("photo");
                    if (photo != null && !photo.isEmpty()) {
                        out.println("<td><img src='images/" + photo + "' alt='" + resultSet.getString("nama") + "' style='width:100px;'/></td>");
                    } else {
                        out.println("<td>No Image Available</td>");
                    }

                    out.println("<td>" + resultSet.getString("nama_jenis") + "</td>");
                    out.println("<td>");
                    out.println("<div class='d-flex'>");
                    out.println("<a href='deleteProduct.jsp?id=" + resultSet.getInt("id") + "' class='btn btn-danger'>Delete</a>");
                    out.println("<a href='createProduct.jsp?id=" + resultSet.getInt("id") + "' class='btn btn-warning'>Update</a>");
                    out.println("</div>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }

            out.println("</tbody>");
            out.println("</table>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger' role='alert'>Error retrieving products: " + e.getMessage() + "</div>");
            e.printStackTrace();
        }
    }
%>



              <%
                String query = "SELECT product.*, jenis_produk.nama_jenis FROM product JOIN jenis_produk ON product.jenis_id = jenis_produk.id";
                displayProducts(out, query);
              %>





