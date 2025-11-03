<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Products - Admin | AmazeMart</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f6f6f6;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            background-color: #001f3f;
            padding: 15px 30px;
        }

        .navbar-brand {
            font-weight: bold;
            color: white;
            font-size: 1.5rem;
        }

        .navbar .nav-link {
            color: white !important;
            margin-left: 20px;
        }

        .navbar .nav-link:hover {
            color: #ffd700 !important;
        }

        .table img {
            object-fit: cover;
            border-radius: 6px;
        }

        .footer {
            margin-top: 50px;
            text-align: center;
            font-size: 14px;
            color: #888;
            padding-bottom: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg shadow-sm">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="#">AmazeMart Admin</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="admin.jsp">🏠 Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">🚪 Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-4">
    <h3 class="mb-4">📦 All Products</h3>
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark text-center">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price (₹)</th>
                    <th>Stock</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection conn = DBConnection.getConnection();
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM products");

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            double price = rs.getDouble("price");
                            int stock = rs.getInt("stock");
                            String image = rs.getString("image_url");

                            if (image == null || image.trim().isEmpty()) {
                                image = "https://via.placeholder.com/150x100?text=No+Image";
                            }
                %>
                <tr class="text-center">
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td>₹<%= price %></td>
                    <td><%= stock %></td>
                    <td><img src="<%= image %>" width="100" height="70" alt="Product Image"></td>
                    <td>
                        <form action="DeleteProductServlet" method="post" class="d-inline">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit" class="btn btn-sm btn-danger">🗑️ Delete</button>
                        </form>
                        <a href="editProduct.jsp?id=<%= id %>" class="btn btn-sm btn-info text-white">✏️ Edit</a>
                    </td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                <tr><td colspan="6" class="text-danger text-center">Error loading products.</td></tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    &copy; 2025 AmazeMart Admin Panel
</div>

</body>
</html>
