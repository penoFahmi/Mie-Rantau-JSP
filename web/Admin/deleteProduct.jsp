<%-- 
    Document   : deleteProduct
    Created on : 3 Jul 2024, 00.59.48
    Author     : Peno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Product</title>
    </head>
    <body>
        <%
        String id = request.getParameter("id");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connectionURL = "jdbc:mysql://localhost/mie_rantau_jsp";
            Connection connection = DriverManager.getConnection(connectionURL,
        "root", "");
            Statement statement = connection.createStatement();
            int i = statement.executeUpdate("DELETE FROM product WHERE ID=" + id +
        "");
            response.sendRedirect("product.jsp");
        } catch (Exception e) {
            response.sendRedirect("product.jsp");
        }
        %>
    </body>
</html>
