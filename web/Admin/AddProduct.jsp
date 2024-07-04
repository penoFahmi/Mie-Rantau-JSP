<%-- 
    Document   : AddProduct
    Created on : 4 Jul 2024, 22.41.06
    Author     : Peno
--%>

<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.File, java.io.IOException, java.io.PrintWriter, javax.servlet.http.HttpServlet, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.apache.commons.fileupload.FileItem, org.apache.commons.fileupload.FileItemFactory, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <title>Admin Product</title>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-"> 
            <div class="container shadow p-5 mt-3" style="background-color:#F7F7F9; height: 100vh;">
                <div class="justify-content-center d-flex">
                    <h1>Add Product</h1>
                </div>
                <form action="AddProduct.jsp" method="post" enctype="multipart/form-data">
                    <%
                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            String jenisId = null, nama = null, deskripsi = null, harga = null, imagePath = null, image_path = null;

                            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                            if (!isMultipart) {
                                out.println("File Not Uploaded");
                            } else {
                                FileItemFactory factory = new DiskFileItemFactory();
                                ServletFileUpload upload = new ServletFileUpload(factory);

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
                                        if (fileItem.getFieldName().equals("inputImage") && fileItem.getSize() > 0) {
                                            String uploadPath = "C:\\Users\\Peno\\Documents\\4 sem\\PWL\\MieRantau\\web\\Admin\\images";
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

                                            imagePath = uploadPath + "\\" + newFileName;
                                            File uploadedFile = new File(imagePath);
                                            fileItem.write(uploadedFile);
                                            image_path = "images\\" + newFileName;
                                        }
                                    }
                                }
                                if (jenisId != null && nama != null && deskripsi != null && harga != null && imagePath != null) {
                                    try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "")) {
                                        String query = "INSERT INTO product (jenis_id, nama, deskripsi, harga, photo) values (?, ?, ?, ?, ?)";
                                        PreparedStatement statementInput = connection.prepareStatement(query);
                                        statementInput.setString(1, jenisId);
                                        statementInput.setString(2, nama);
                                        statementInput.setString(3, deskripsi);
                                        statementInput.setString(4, harga);
                                        statementInput.setString(5, image_path);

                                        int updateQuery = statementInput.executeUpdate();
                                        if (updateQuery != 0) {
                                            response.sendRedirect("admin.jsp");
                                        }
                                    } catch (SQLException e) {
                                        out.println("Database connection or query execution error: " + e.getMessage());
                                    }
                                } else {
                                    out.println("Missing required form fields or file upload failed.");
                                }
                            }
                        }
                    %>

                    <label for="selectJenisProduk" class="form-label">Jenis Produk</label>
                    <select class="form-select" id="selectJenisProduk" name="selectJenisProduk" required>
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

                    <label for="inputNama" class="form-label my-2">Nama</label>
                    <input type="text" id="inputNama" name="inputNama" class="form-control" required>

                    <label for="inputDeskripsi" class="form-label my-2">Deskripsi</label>
                    <textarea class="form-control" id="inputDeskripsi" name="inputDeskripsi" rows="3" required></textarea>

                    <label for="inputHarga" class="form-label my-2">Harga</label>
                    <input type="number" id="inputHarga" name="inputHarga" class="form-control" required>

                    <label for="inputImage" class="form-label my-2">Image</label>
                    <div style="width: 500px;">
                        <input type="file" id="inputImage" name="inputImage" class="dropify" 
                           data-allowed-file-extensions="png jpg jpeg" 
                           data-max-file-size="2M"
                        required/>
                    </div>

                    <div class="justify-content-end d-flex">
                        <input type="submit" class="btn btn-primary my-2" value="Add Product">
                    </div>
                </form>
            </div>
        </main>
                      
        <script>
            $(document).ready(function() {
                $('.dropify').dropify();
            });
        </script>
</body>
</html>
