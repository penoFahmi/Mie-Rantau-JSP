<%-- 
    Document   : form-update-product
    Created on : 6 Jul 2024, 05.26.15
    Author     : Peno
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*"%>

<!-- Include Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<!-- Include Dropify CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/dropify/0.2.2/css/dropify.min.css" rel="stylesheet">

<%
    String id = request.getParameter("id");
    String jenis_id = "", nama = "", deskripsi = "", harga = "", photo = "";
    
    if (id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "");

            String query = "SELECT * FROM product WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, id);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                jenis_id = resultSet.getString("jenis_id");
                nama = resultSet.getString("nama");
                deskripsi = resultSet.getString("deskripsi");
                harga = resultSet.getString("harga");
                photo = resultSet.getString("photo");
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<div class="container-fluid">
    <div class="row">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Update Product</h4>
                <p class="card-description">Form to update product details</p>
                <form class="forms-sample" action="prosesUpdate.jsp" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="<%= id %>">

                    <div class="form-group">
                        <label for="selectJenisProduk">Jenis Produk</label>
                        <select class="form-control" id="selectJenisProduk" name="selectJenisProduk" required>
                            <option selected hidden disabled>Pilih Jenis Produk</option>
                            <% 
                                try {
                                    String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
                                    String usernameDB = "root";
                                    String passwordDB = "";

                                    Class.forName("com.mysql.cj.jdbc.Driver");

                                    Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
                                    Statement statement = connection.createStatement();

                                    String query = "SELECT * FROM jenis_produk";

                                    ResultSet resultSet = statement.executeQuery(query);
                                    while (resultSet.next()) {
                                        String selected = resultSet.getString("id").equals(jenis_id) ? "selected" : "";
                            %>
                            <option value="<%= resultSet.getString("id") %>" <%= selected %>><%= resultSet.getString("nama_jenis") %></option>
                            <%
                                    }
                                    resultSet.close(); statement.close(); connection.close();
                                } catch(Exception e){
                                    out.println(e.getMessage());
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="inputNama">Nama</label>
                        <input type="text" class="form-control" id="inputNama" name="inputNama" value="<%= nama %>" required>
                    </div>

                    <div class="form-group">
                        <label for="inputDeskripsi">Deskripsi</label>
                        <textarea class="form-control" id="inputDeskripsi" name="inputDeskripsi" rows="3" required><%= deskripsi %></textarea>
                    </div>

                    <div class="form-group">
                        <label for="inputHarga">Harga</label>
                        <input type="number" class="form-control" id="inputHarga" name="inputHarga" value="<%= harga %>" required>
                    </div>

                    <div class="form-group">
                        <label for="inputImage">Image</label>
                        <input type="file" class="form-control dropify" id="inputImage" name="inputImage" data-default-file="<%= photo %>" data-allowed-file-extensions="png jpg jpeg" data-max-file-size="2M">
                    </div>

                    <button type="submit" class="btn btn-primary me-2">Submit</button>
                    <button type="reset" class="btn btn-light">Reset</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<!-- Include Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
<!-- Include Dropify JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/dropify/0.2.2/js/dropify.min.js"></script>

<script>
    $(document).ready(function() {
        $('.dropify').dropify();
    });
</script>
