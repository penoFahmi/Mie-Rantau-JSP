<%-- 
    Document   : form-update-product
    Created on : 6 Jul 2024, 05.26.15
    Author     : Peno
--%>

<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.File, java.io.IOException, java.io.PrintWriter, javax.servlet.http.HttpServlet, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.apache.commons.fileupload.FileItem, org.apache.commons.fileupload.FileItemFactory, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<!-- Include Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<!-- Include Dropify CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/dropify/0.2.2/css/dropify.min.css" rel="stylesheet">

<div class="container-fluid">
    <div class="row">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Update Product</h4>
                <p class="card-description">
                    Basic form layout
                </p>
                <form class="forms-sample" action="updateProduct.jsp" method="post" enctype="multipart/form-data">
                    <%
                        String message = null;
                        String productId = request.getParameter("id");

                        String jenisId = null, nama = null, deskripsi = null, harga = null, photoPath = null;
                        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                        
                        if (productId != null && !"POST".equalsIgnoreCase(request.getMethod())) {
                            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "")) {
                                String query = "SELECT * FROM product WHERE id = ?";
                                PreparedStatement statement = connection.prepareStatement(query);
                                statement.setString(1, productId);
                                ResultSet resultSet = statement.executeQuery();
                                if (resultSet.next()) {
                                    jenisId = resultSet.getString("jenis_id");
                                    nama = resultSet.getString("nama");
                                    deskripsi = resultSet.getString("deskripsi");
                                    harga = resultSet.getString("harga");
                                    photoPath = resultSet.getString("photo");
                                }
                                resultSet.close();
                                statement.close();
                            } catch (SQLException e) {
                                message = "Database error: " + e.getMessage();
                            }
                        }

                        if ("POST".equalsIgnoreCase(request.getMethod()) && productId != null) {
                            jenisId = request.getParameter("selectJenisProduk");
                            nama = request.getParameter("inputNama");
                            deskripsi = request.getParameter("inputDeskripsi");
                            harga = request.getParameter("inputHarga");

                            if (isMultipart) {
                                FileItemFactory factory = new DiskFileItemFactory();
                                ServletFileUpload upload = new ServletFileUpload(factory);

                                try {
                                    List<FileItem> fields = upload.parseRequest(request);
                                    Iterator<FileItem> it = fields.iterator();

                                    while (it.hasNext()) {
                                        FileItem fileItem = it.next();
                                        if (!fileItem.isFormField() && fileItem.getFieldName().equals("inputImage") && fileItem.getSize() > 0) {
                                            String uploadPath = "C:/Users/Peno/Documents/4 sem/PWL/MieRantau/web/Admin/images";
                                            File uploadDir = new File(uploadPath);
                                            if (!uploadDir.exists()) {
                                                uploadDir.mkdirs(); // Create the directory if it does not exist
                                            }

                                            String originalFileName = new File(fileItem.getName()).getName();
                                            String fileExtension = "";
                                            int dotIndex = originalFileName.lastIndexOf('.');
                                            if (dotIndex > 0) {
                                                fileExtension = originalFileName.substring(dotIndex);
                                            }

                                            String uuid = UUID.randomUUID().toString();
                                            String newFileName = originalFileName.substring(0, dotIndex) + "_" + uuid + fileExtension;

                                            File uploadedFile = new File(uploadPath + File.separator + newFileName);
                                            fileItem.write(uploadedFile);
                                            photoPath = "images/" + newFileName;
                                        }
                                    }
                                } catch (Exception e) {
                                    message = "Error: " + e.getMessage();
                                }
                            }

                            if (jenisId != null && nama != null && deskripsi != null && harga != null) {
                                try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "")) {
                                    String query = "UPDATE product SET jenis_id = ?, nama = ?, deskripsi = ?, harga = ?" + 
                                                   (photoPath != null ? ", photo = ?" : "") + " WHERE id = ?";
                                    PreparedStatement statementUpdate = connection.prepareStatement(query);
                                    statementUpdate.setString(1, jenisId);
                                    statementUpdate.setString(2, nama);
                                    statementUpdate.setString(3, deskripsi);
                                    statementUpdate.setString(4, harga);
                                    if (photoPath != null) {
                                        statementUpdate.setString(5, photoPath);
                                        statementUpdate.setString(6, productId);
                                    } else {
                                        statementUpdate.setString(5, productId);
                                    }
                                    int updatedQuery = statementUpdate.executeUpdate();
                                    if (updatedQuery != 0) {
                                        response.sendRedirect("product.jsp");
                                        return;
                                    } else {
                                        message = "Failed to update product. Please try again.";
                                    }
                                } catch (SQLException e) {
                                    message = "Database error: " + e.getMessage();
                                }
                            } else {
                                message = "Missing required form fields or file upload failed.";
                            }
                        }
                    %>

                    <!-- Modal Error -->
                    <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="errorModalLabel">Error</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <%= message %>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="selectJenisProduk">Jenis Produk</label>
                        <select class="form-control" id="selectJenisProduk" name="selectJenisProduk" required>
                            <option selected hidden disabled>Pilih Jenis Produk</option>
                            <% 
                                try {
                                    String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
                                    String usernameDB = "root";
                                    String passwordDB = "";

                                    Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
                                    Statement statement = connection.createStatement();

                                    String query = "SELECT * FROM jenis_produk";

                                    ResultSet resultSet = statement.executeQuery(query);
                                    while (resultSet.next()) {
                                        String selected = resultSet.getString("id").equals(jenisId) ? "selected" : "";
                            %>
                            <option value="<%= resultSet.getString("id") %>" <%= selected %>><%= resultSet.getString("nama_jenis") %></option>
                            <%
                                    }
                                    resultSet.close();
                                    statement.close();
                                    connection.close();
                                } catch (Exception e) {
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
                        <input type="file" class="form-control dropify" id="inputImage" name="inputImage" data-allowed-file-extensions="png jpg jpeg" data-max-file-size="2M" <%= (photoPath != null) ? "data-default-file='" + photoPath + "'" : "" %>>
                    </div>

                    <button type="submit" class="btn btn-primary mr-2">Submit</button>
                    <a href="product.jsp" type="reset" class="btn btn-light">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<!-- Include Popper.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- Include Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- Include Dropify JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/dropify/0.2.2/js/dropify.min.js"></script>

