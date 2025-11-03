<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product - Admin | AmazeMart</title>
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

        .accordion-button {
            background-color: #001f3f;
            color: #fff;
            font-weight: bold;
        }

        .accordion-button:not(.collapsed) {
            background-color: #001234;
        }

        .accordion-body {
            background-color: #fff;
        }

        label {
            font-weight: 500;
        }

        .form-control, .form-select {
            border-radius: 6px;
        }

        .footer {
            margin-top: 50px;
            text-align: center;
            font-size: 14px;
            color: #888;
            padding-bottom: 20px;
        }

        .toast-container {
            z-index: 1055;
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

<!-- Page Content -->
<div class="container mt-4">
    <div class="accordion" id="adminAccordion">

        <!-- Add Product Section -->
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingAdd">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseAdd" aria-expanded="true" aria-controls="collapseAdd">
                    ➕ Add New Product
                </button>
            </h2>
            <div id="collapseAdd" class="accordion-collapse collapse show" aria-labelledby="headingAdd">
                <div class="accordion-body">
                    <form action="AddProductServlet" method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <label>Product Name</label>
                                <input type="text" name="name" class="form-control mb-3" required>

                                <label>Category</label>
                                <input type="text" name="category" class="form-control mb-3" required>

                                <label>Subcategory</label>
                                <input type="text" name="subcategory" class="form-control mb-3">

                                <label>Description</label>
                                <textarea name="description" rows="3" class="form-control mb-3"></textarea>

                                <label>Price (₹)</label>
                                <input type="number" name="price" class="form-control mb-3" step="0.01" required>

                                <label>Stock Quantity</label>
                                <input type="number" name="stock" class="form-control mb-3" value="10" required>

                                <label>Image URL</label>
                                <input type="text" name="image" class="form-control mb-4" placeholder="https://example.com/image.jpg" required>

                                <input type="submit" value="Add Product" class="btn btn-primary w-100">
                            </div>

                            <div class="col-md-6">
                                <p class="text-muted"><strong>Preview:</strong> Image based on your URL will appear on homepage.</p>
                                <img src="https://via.placeholder.com/300x200?text=Product+Image" class="img-thumbnail mb-2 w-100">
                                <p class="text-secondary">Use public image URLs from platforms like Imgur, Unsplash, Cloudinary, etc.</p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Site Stats Section -->
        <div class="accordion-item mt-3">
            <h2 class="accordion-header" id="headingStats">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseStats" aria-expanded="false" aria-controls="collapseStats">
                    📊 Site Stats
                </button>
            </h2>
            <div id="collapseStats" class="accordion-collapse collapse" aria-labelledby="headingStats">
                <div class="accordion-body">
                    <%
                        Connection conn = DBConnection.getConnection();
                        Statement stmt = conn.createStatement();
                        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM users");
                        rs1.next();
                        int totalUsers = rs1.getInt(1);

                        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM products");
                        rs2.next();
                        int totalProducts = rs2.getInt(1);
                        stmt.close();
                        conn.close();
                    %>
                    <p><strong>Total Registered Customers:</strong> <%= totalUsers %></p>
                    <p><strong>Total Products:</strong> <%= totalProducts %></p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Toast on success -->
<%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
%>
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div class="toast show text-white bg-success" role="alert">
            <div class="toast-body">✅ Product added successfully!</div>
        </div>
    </div>
<% } %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
