<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, dao.DBConnection" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = DBConnection.getConnection();
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE id = ?");
    stmt.setInt(1, id);
    ResultSet rs = stmt.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="navbar">
    <div><strong>Edit Product</strong></div>
    <div>
        <a href="adminManageProducts.jsp">Back</a>
    </div>
</div>

<div class="container">
    <form action="EditProductServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <label>Name</label>
        <input type="text" name="name" value="<%= rs.getString("name") %>" required>

        <label>Category</label>
        <input type="text" name="category" value="<%= rs.getString("category") %>" required>

        <label>Subcategory</label>
        <input type="text" name="subcategory" value="<%= rs.getString("subcategory") %>">

        <label>Description</label>
        <input type="text" name="description" value="<%= rs.getString("description") %>">

        <label>Price</label>
        <input type="text" name="price" value="<%= rs.getDouble("price") %>" required>

        <label>Stock</label>
        <input type="number" name="stock" value="<%= rs.getInt("stock") %>" required>

        <label>Image URL</label>
        <input type="text" name="image" value="<%= rs.getString("image") %>" required>

        <input type="submit" value="Update Product">
    </form>
</div>

</body>
</html>
