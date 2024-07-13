<%-- 
    Document   : prosesUpdate
    Created on : 10 Jul 2024, 20.26.40
    Author     : Peno
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.io.File, java.io.IOException, org.apache.commons.fileupload.FileItem, org.apache.commons.fileupload.FileItemFactory, org.apache.commons.fileupload.disk.DiskFileItemFactory, org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<%
    String id = null;
    String jenis_id = null;
    String nama = null;
    String deskripsi = null;
    String harga = null;
    String photo = null;

    // Define the upload path for images
    String uploadPath = "C:\\Users\\Peno\\Documents\\4 sem\\PWL\\MieRantau\\web\\Admin\\images";

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (isMultipart) {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(request);

        for (FileItem item : items) {
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("UTF-8");

                switch (fieldName) {
                    case "id":
                        id = fieldValue;
                        break;
                    case "selectJenisProduk":
                        jenis_id = fieldValue;
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
                String fileName = new File(item.getName()).getName();
                if (!fileName.isEmpty()) {
                    String fileExtension = "";
                    int dotIndex = fileName.lastIndexOf('.');
                    if (dotIndex > 0) {
                        fileExtension = fileName.substring(dotIndex);
                    }

                    String uuid = UUID.randomUUID().toString();
                    String newFileName = fileName.substring(0, dotIndex) + "_" + uuid + fileExtension;

                    File uploadedFile = new File(uploadPath + File.separator + newFileName);
                    item.write(uploadedFile);

                    photo = "images\\" + newFileName;
                }
            }
        }
    }

    if (id != null) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost/mie_rantau_jsp", "root", "");

            String querySelect = "SELECT photo FROM product WHERE id = ?";
            statement = connection.prepareStatement(querySelect);
            statement.setString(1, id);
            resultSet = statement.executeQuery();

            String oldPhotoPath = null;
            if (resultSet.next()) {
                oldPhotoPath = resultSet.getString("photo");
            }

            if (!isMultipart || photo == null) {
                photo = oldPhotoPath;
            }

            String queryUpdate = "UPDATE product SET jenis_id = ?, nama = ?, deskripsi = ?, harga = ?, photo = ? WHERE id = ?";
            statement = connection.prepareStatement(queryUpdate);
            statement.setString(1, jenis_id);
            statement.setString(2, nama);
            statement.setString(3, deskripsi);
            statement.setString(4, harga);
            statement.setString(5, photo);
            statement.setString(6, id);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                if (oldPhotoPath != null && !oldPhotoPath.equals(photo)) {
                    File oldFile = new File(uploadPath + File.separator + oldPhotoPath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }

                response.sendRedirect("product.jsp");
            } else {
                out.println("Failed to update product.");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                out.println("Error closing database connection: " + e.getMessage());
            }
        }
    } else {
        out.println("Product ID is missing.");
    }
%>


