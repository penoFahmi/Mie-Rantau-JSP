<%-- 
    Document   : form-add-product
    Created on : 6 Jul 2024, 05.25.44
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
                <h4 class="card-title">Add Product</h4>
                <p class="card-description">
                    Basic form layout
                </p>
                <form class="forms-sample" action="createProduct.jsp" method="post" enctype="multipart/form-data">
                    <%
                        String message = null;

                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            String jenisId = null, nama = null, deskripsi = null, harga = null, photoPath = null;

                            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                            if (!isMultipart) {
                                message = "File Not Uploaded";
                            } else {
                                FileItemFactory factory = new DiskFileItemFactory();
                                ServletFileUpload upload = new ServletFileUpload(factory);

                                try {
                                    List<FileItem> fields = upload.parseRequest(request);
                                    Iterator<FileItem> it = fields.iterator();

                                    while (it.hasNext()) {
                                        FileItem fileItem = it.next();
                                        if (fileItem.isFormField()) {
                                            String fieldName = fileItem.getFieldName();
                                            String fieldValue = fileItem.getString();
                                            switch (fieldName) {
                                                case "selectJenisProduk":
                                                    jenisId = fieldValue;
                                                    break;
                                                case "inputNama":
                                                    nama = fieldValue;
                                                    break;
                                                case "inputDeskripsi":
                                                    deskripsi = fieldValue;
                                                    break;
                                                case "inputHarga":
                                                    harga = fieldValue;
                                                    break;
                                            }
                                        } else {
                                            if ("inputImage".equals(fileItem.getFieldName()) && fileItem.getSize() > 0) {
                                                String uploadPath = "C:/Users/Peno/Documents/4 sem/PWL/MieRantau/web/Admin/images"; // Sesuaikan path dengan kebutuhan Anda
                                                File uploadDir = new File(uploadPath);
                                                if (!uploadDir.exists()) {
                                                    uploadDir.mkdirs(); // Buat direktori jika belum ada
                                                }

                                                String originalFileName = new File(fileItem.getName()).getName();
                                                String fileExtension = "";
                                                int dotIndex = originalFileName.lastIndexOf('.');
                                                if (dotIndex > 0) {
                                                    fileExtension = originalFileName.substring(dotIndex);
                                                }

                                                String uuid = UUID.randomUUID().toString();
                                                String newFileName = originalFileName.substring(0, dotIndex) + "_" + uuid + fileExtension;

                                                photoPath = uploadPath + File.separator + newFileName;
                                                File uploadedFile = new File(photoPath);
                                                fileItem.write(uploadedFile);
                                                photoPath = "images/" + newFileName; // Path untuk ditampilkan di halaman
                                            }
                                        }
                                    }

                                    if (jenisId != null && nama != null && deskripsi != null && harga != null && photoPath != null) {
                                        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "")) {
                                            String query = "INSERT INTO product (jenis_id, nama, deskripsi, harga, photo) VALUES (?, ?, ?, ?, ?)";
                                            PreparedStatement statement = connection.prepareStatement(query);
                                            statement.setString(1, jenisId);
                                            statement.setString(2, nama);
                                            statement.setString(3, deskripsi);
                                            statement.setString(4, harga);
                                            statement.setString(5, photoPath);

                                            int updatedQuery = statement.executeUpdate();

                                            if (updatedQuery != 0) {
                                                response.sendRedirect("product.jsp");
                                            } else {
                                                message = "Failed to insert product.";
                                            }
                                        } catch (SQLException e) {
                                            message = "Database error: " + e.getMessage();
                                        }
                                    } else {
                                        message = "Please fill all required fields.";
                                    }
                                } catch (Exception e) {
                                    message = "File upload error: " + e.getMessage();
                                }
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

                                    Class.forName("com.mysql.jdbc.Driver");

                                    Connection connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
                                    Statement statement = connection.createStatement();

                                    String query = "SELECT * FROM jenis_produk";

                                    ResultSet resultSet = statement.executeQuery(query);
                                    while (resultSet.next()) {
                            %>
                            <option value="<%= resultSet.getString("id") %>"><%= resultSet.getString("nama_jenis") %></option>
                            <%
                                    }
                                    resultSet.close(); statement.close(); connection.close();
                                } catch( Exception e){
                                    out.println(e.getMessage());
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="inputNama">Nama</label>
                        <input type="text" class="form-control" id="inputNama" name="inputNama" required>
                    </div>

                    <div class="form-group">
                        <label for="inputDeskripsi">Deskripsi</label>
                        <textarea class="form-control" id="inputDeskripsi" name="inputDeskripsi" rows="3" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="inputHarga">Harga</label>
                        <input type="number" class="form-control" id="inputHarga" name="inputHarga" required>
                    </div>

                    <div class="form-group">
                        <label for="inputImage">Image</label>
                        <input type="file" class="form-control dropify" id="inputImage" name="inputImage" data-allowed-file-extensions="png jpg jpeg" data-max-file-size="2M" required>
                    </div>

                    <button type="submit" class="btn btn-primary me-2">Submit</button>
                    <button href="product." type="button" class="btn btn-light">Cancel</button>
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