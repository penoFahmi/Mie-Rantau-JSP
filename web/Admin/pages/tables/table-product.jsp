<%-- 
    Document   : table-product
    Created on : 6 Jul 2024, 04.05.34
    Author     : Peno
--%>

<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@page import="java.util.List"%>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  

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
            out.println("<h4 class='card-title'>Produk</h4>");
            out.println("<a href='createProduct.jsp' class='btn btn-primary mb-3'>Tambah Produk</a>");  // Button "Tambah Produk"
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
                        out.println("<td><img class='img-thumbnail' src='" + photo + "' alt='" + resultSet.getString("nama") + "''/></td>");
                    } else {
                        out.println("<td>No Image Available</td>");
                    }

                    out.println("<td>" + resultSet.getString("nama_jenis") + "</td>");
                    out.println("<td>");
                    out.println("<div>");
                    out.println("<button class='btn btn-danger' data-toggle='modal' data-target='#deleteModal' data-id='" + resultSet.getInt("id") + "'>Delete</button>");
                    out.println("<a href='updateProduct.jsp?id=" + resultSet.getInt("id") + "' class='btn btn-warning'>Update</a>");
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

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this product?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<!-- Include Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

<script>
    $('#deleteModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var id = button.data('id'); // Extract info from data-* attributes
        var deleteUrl = 'deleteProduct.jsp?id=' + id; // Create delete URL

        var modal = $(this);
        modal.find('#confirmDeleteBtn').attr('href', deleteUrl); // Set the URL for the confirm button
    });
</script>
